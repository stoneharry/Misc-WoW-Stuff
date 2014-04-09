<?php
$con = mysql_connect("", "", "@");

$account = mysql_real_escape_string($_GET["accountName"]);
$hash = mysql_real_escape_string($_GET["sessionKeyHash"]);
$id = mysql_real_escape_string($_GET["messageId"]);

$count = 0;

mysql_select_db('harry_auth', $con);

$q = mysql_query("SELECT `id`,`message`,`read`,`hash` FROM `account_messages` WHERE account = '{$account}' ORDER BY `id`") or die(mysql_error());

if (mysql_num_rows($q) != 0)
{
	while($row = mysql_fetch_array($q))
	{
		//if ($hash == $row['hash'])
		//{
			if ($row['read'] == 0)
			{
				if ($count == $id)
				{
					$body = $row['message'];
					echo "<body>{$body}</body>";
					break;
				}
				
				$count = $count + 1;
			}
		//}
	}
}

mysql_close($con);
?>