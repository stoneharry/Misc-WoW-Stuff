<?php
$con = mysql_connect("37.59.19.103", "eocweb", "@") or die(mysql_error());

$account = mysql_real_escape_string($_GET["accountName"]);
$hash = mysql_real_escape_string($_GET["sessionKeyHash"]);

$count = 0;

mysql_select_db('harry_auth', $con);

$q = mysql_query("SELECT `heading`,`read`,`hash` FROM `account_messages` WHERE account = '{$account}'") or die(mysql_error());

if (mysql_num_rows($q) != 0)
{
	echo "<headers>";
	
	while($row = mysql_fetch_array($q))
	{
		//if ($hash == $row['hash'])
		//{
			if ($row['read'] == 0)
			{
				$head = $row['heading'];
				
				echo "<header_entry id=\"{$count}\" priority=\"0\" opened=\"0\">";
				echo 	"<subject>{$head}</subject>";
				echo "</header_entry>";
				
				$count = $count + 1;
			}
		//}
	}
	
	echo "</headers>";
}

mysql_close($con);

/*
echo  "<headers>";
echo    "<header_entry id=\"0\" priority=\"0\" opened=\"0\">";
echo      "<subject>{$account}! {$hash}</subject>";
echo    "</header_entry>";
echo    "<header_entry id=\"1\" priority=\"0\" opened=\"0\">";
echo      "<subject>Message 2</subject>";
echo    "</header_entry>";
echo    "<header_entry id=\"2\" priority=\"0\" opened=\"0\">";
echo      "<subject>Message 3</subject>";
echo    "</header_entry>";
echo  "</headers>";
*/
?>