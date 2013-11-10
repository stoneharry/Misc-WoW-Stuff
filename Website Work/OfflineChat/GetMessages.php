<?php
$dispersionwow = session_name("dispersionwow");
session_set_cookie_params(0, '/scripts/OfflineChat/', '.eoc.dispersion-wow.com');
session_start();
if (isset($_SESSION['IP']))
{
	$user = $_SESSION['IP'];
	$connection = mysql_connect("37.59.19.103", "eocweb", "@") or die("Connection to Database failed");
	mysql_select_db("harry_chars") or die ("Database selection failed");

	$result = mysql_query("SELECT * FROM `chat` ORDER BY `date` ASC");
	$row = mysql_fetch_array($result);
	while ($row)
	{
		if (strpos($row[1],$user) !== false) {
		}
		else
		{
			echo "||{$row[0]}";
			echo "||{$row[1]}";
			echo "||{$row[2]}";
			echo "||{$row[3]}";
		}

		$row = mysql_fetch_array($result);
	}

	mysql_close($connection);
}
?>