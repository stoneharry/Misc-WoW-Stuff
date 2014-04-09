<?php
$ = session_name("");
session_set_cookie_params(0, '/scripts/OfflineChat/', '.eoc.');
session_start();
if (isset($_SESSION['IP']))
{
	$connection = mysql_connect("", "", "@") or die("Connection to Database failed");
	mysql_select_db("harry_chars") or die ("Database selection failed");
	$user = $_GET["user"];
	$message = $_GET["message"];
	if ($user != NULL && $user != "" && $message != NULL && $message != "")
	{
		$user = mysql_real_escape_string($user);
		$message = mysql_real_escape_string($message);
		$user = str_replace("\"", "\\\"", $user);
		$message = str_replace("\"", "\\\"", $message);
		$message = str_replace("||", " ", $message);
		mysql_query("INSERT INTO `chat_send` (username, message) VALUES (\"{$user}\", \"{$message}\")");
	}
	mysql_close($connection);
}
?>