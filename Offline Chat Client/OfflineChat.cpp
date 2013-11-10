#include <stdio.h>
#include <iostream>
#include <string>
#include <curl.h>
#include <sstream>
#include <vector>
#include "sha1.h"
#include <fstream>

using namespace std;

#define URL_GetMessages "http://eoc.dispersion-wow.com/scripts/OfflineChat/GetMessages.php"
#define URL_SendMessage "http://eoc.dispersion-wow.com/scripts/OfflineChat/SendChatMessage.php"
#define URL_Authenticate "http://eoc.dispersion-wow.com/scripts/OfflineChat/Authenticate.php"
#define Session_Storage "OfflineChat_Session.db"

bool shuttingdown = false;
bool thread1exit = false;
bool thread2exit = false;
const long n = 0x1971425;
int MessageSpam = 0;
long lastClock = 0;

string username = "";

vector<int> IDsRead;

static size_t data_write(void* buf, size_t size, size_t nmemb, void* userp)
{
	if(userp)
	{
		std::ostream& os = *static_cast<std::ostream*>(userp);
		std::streamsize len = size * nmemb;
		if(os.write(static_cast<char*>(buf), len))
			return len;
	}
	return 0;
}

CURLcode curl_read(const std::string& url, std::ostream& os, long timeout = 5)
{
	CURLcode code(CURLE_FAILED_INIT);
	CURL* curl = curl_easy_init();

	if(curl)
	{
		if(CURLE_OK == (code = curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, &data_write))
		&& CURLE_OK == (code = curl_easy_setopt(curl, CURLOPT_NOPROGRESS, 1L))
		&& CURLE_OK == (code = curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1L))
		&& CURLE_OK == (code = curl_easy_setopt(curl, CURLOPT_FILE, &os))
		&& CURLE_OK == (code = curl_easy_setopt(curl, CURLOPT_TIMEOUT, timeout))
		&& CURLE_OK == (code = curl_easy_setopt(curl, CURLOPT_COOKIEFILE, Session_Storage))
		&& CURLE_OK == (code = curl_easy_setopt(curl, CURLOPT_COOKIEJAR, Session_Storage))
		&& CURLE_OK == (code = curl_easy_setopt(curl, CURLOPT_URL, url.c_str())))
		{
			code = curl_easy_perform(curl);
		}
		curl_easy_cleanup(curl);
	}
	return code;
}

bool authenticate(string password)
{
	ostringstream oss;
	string URL = URL_Authenticate;
	URL += "?user=" + username + "&pass=" + password;
    curl_read(URL, oss);
	string html = oss.str();

	if (html.length() > 0)
		if (atoi(html.c_str()) == n)
			return true;
	return false;
}

void SendChatMessage(string message)
{
	MessageSpam++;
	if (clock() > lastClock + 10000)
	{
		if (MessageSpam > 10)
		{
			shuttingdown = true;
			return;
		}
		MessageSpam = 0;
		lastClock = clock();
	}
	ostringstream oss;
	string destination = URL_SendMessage;
	int position = message.find(" ");
    while (position != string::npos) 
    {
		message.replace(position, 1, "||");
		position = message.find(" ", position + 1);
    }
	destination += "?user=" + username;
	destination += "&message=" + message;
    curl_read(destination, oss);
}

void HandleMessage(string message)
{
	if (message.length() < 1)
		return;
	for (unsigned int i = 0; i < message.length() - 2; i++)
	{
		if (message.at(i) == '|' && message.at(i+1) == '|')
		{
			i = i + 2;
		}
		else
		{
			continue;
		}
		string output = "";
		string ID = "";

		bool advance = true;
		while (advance)
		{
			ID += message.at(i);
			i++;
			if (message.at(i) == '|' && message.at(i+1) == '|')
				advance = false;
		}
		i += 2;
		advance = true;
		int intID = atoi(ID.c_str());
		int size = IDsRead.size();
		bool found = false;
		for (int j = 0; j < size; j++)
		{
			if (IDsRead[j] == intID)
			{
				found = true;
				break;
			}
		}
		while (advance)
		{
			output += message.at(i);
			i++;
			if (message.at(i) == '|' && message.at(i+1) == '|')
				advance = false;
		}
		i += 2;
		output += " ";
		advance = true;
		while (advance)
		{
			if (message.at(i) == '|' && message.at(i+1) == 'c' && message.at(i+2) == 'f') // Handle links
			{
				while (message.at(i) != '[')
					i++;
				while (message.at(i) != ']')
				{
					output += message.at(i);
					i++;
				}
				output += message.at(i);
				while (message.at(i) != '|' && message.at(i+1) != 'r')
					i++;
				i += 3;
			}
			else
			{
				output += message.at(i); // Normal message
			}
			i++;
			if (message.at(i) == '|' && message.at(i+1) == '|')
				advance = false;
		}
		i += 20; // skip date

		if (!found)
		{
			IDsRead.push_back(intID);
			cout << output << endl;
		}
	}
}

string getMessages()
{
	ostringstream oss;
    curl_read(URL_GetMessages, oss);
	string html = oss.str();
	return html;
}

DWORD WINAPI threadOne(LPVOID args)
{
	int ConnTimeout = 0;
	while (!shuttingdown)
	{
		string message = getMessages();
		if (message.length() < 1)
		{
			if (ConnTimeout == 4)
			{
				printf("\n-- Webserver has completely stopped responding. Closing program. --\n\n");
				shuttingdown = true;
				continue;
			}
			printf("\n-- Warning: Website did not respond for more than 5 seconds. --\n\n");
			ConnTimeout++;
		}
		ConnTimeout = 0;
		HandleMessage(message);
		Sleep(1000);
	}
	thread1exit = true;
	return NULL;
}

DWORD WINAPI threadTwo(LPVOID args)
{
	string input;
	int length;
	while (!shuttingdown)
	{
		getline(cin, input);
		length = input.length();
		if (length > 0)
		{
			if (length > 255)
			{
				printf("\n-- Message too long to send. Keep under 255 characters. --\n");
				continue;
			}
			SendChatMessage(input);
			printf("[Webchat] [%s] %s\n", username.c_str(), input.c_str());
		}
	}
	thread2exit = true;
	return NULL;
}

string StringToUpper(const string & s)
{
    string ret(s.size(), char());
    for(unsigned int i = 0; i < s.size(); ++i)
        ret[i] = (s[i] <= 'z' && s[i] >= 'a') ? s[i]-('a'-'A') : s[i];
    return ret;
}

inline void SafeShutdown()
{
	curl_global_cleanup();
	remove(Session_Storage);

	ofstream myfile;
	myfile.open(Session_Storage, ios::trunc);
	myfile << "# Session Database\n";
	myfile.close();
}

BOOL WINAPI ConsoleHandler(DWORD CEvent)
{
    switch(CEvent)
    {
		case CTRL_C_EVENT:
			SafeShutdown();
			break;
		case CTRL_BREAK_EVENT:
			SafeShutdown();
			break;
		case CTRL_CLOSE_EVENT:
			SafeShutdown();
			break;
		case CTRL_LOGOFF_EVENT:
			SafeShutdown();
			break;
		case CTRL_SHUTDOWN_EVENT:
			SafeShutdown();
			break;
    }
    return TRUE;
}


int main(void)
{
	printf("\nPlease input your username: ");
	cin >> username;
	printf("\nPlease input your password: ");
	string password = "";
	cin >> password;

	password = StringToUpper(username) + ":" + StringToUpper(password);

	unsigned char hash[20];
	char hexstring[41];
	sha1::calc(password.c_str(), password.length(), hash);
	sha1::toHexString(hash, hexstring);
	
	password = hexstring;

	curl_global_init(CURL_GLOBAL_ALL);

	if (!authenticate(password))
	{
		printf("\nFailed to authenticate. Aborting...\n");
		SafeShutdown();
		Sleep(2000);
		return -1;
	}

	printf("\nSuccessfully authenticated.\n");

	/*
	printf("\nEnter your desired display name: ");
	cin >> username;
	printf("\n");
	*/

	string message = getMessages();
	if (message.length() < 1)
	{
		printf("\nFailed to connect to server.\n");
		SafeShutdown();
		Sleep(2000);
		return -1;
	}
	HandleMessage(message);

	CreateThread(NULL, 0, threadOne, NULL, 0, NULL);
	CreateThread(NULL, 0, threadTwo, NULL, 0, NULL);

	while (!shuttingdown || !thread1exit || !thread2exit)
	{
		if (SetConsoleCtrlHandler((PHANDLER_ROUTINE)ConsoleHandler,TRUE)==FALSE)
		{
			SafeShutdown();
			return -1;
		}
		Sleep(1000);
	}

	SafeShutdown();

	return 0;
}