<?php
$con = mysql_connect("37.59.19.103", "eocweb", "@");

$account = mysql_real_escape_string($_GET["accountName"]);
$hash = mysql_real_escape_string($_GET["sessionKeyHash"]);
$id = mysql_real_escape_string($_GET["messageId"]);

$count = 0;
$id_found = 0;

mysql_select_db('harry_auth', $con);

$q = mysql_query("SELECT `id`,`hash`,`read` FROM `account_messages` WHERE account = '{$account}' ORDER BY `id`") or die(mysql_error());

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
					$id_found = $row['id'];
					break;
				}
				
				$count = $count + 1;
			}
		//}
	}
}

if ($id_found != 0)
{
	mysql_query("UPDATE `account_messages` SET `read` = '1' WHERE `id` = '{$id_found}'") or die(mysql_error());
}

mysql_close($con);
?>