<?php
// 26678309 = send is success
$dispersionwow = session_name("dispersionwow");
session_set_cookie_params(0, '/scripts/OfflineChat/', '.eoc.dispersion-wow.com');
ini_set("session.cookie_lifetime","3600");
session_start();
ini_set("session.cookie_lifetime","3600");

$connection = mysql_connect("37.59.19.103", "eocweb", "@") or die("Connection to Database failed");
mysql_select_db("harry_auth") or die ("Database selection failed");

$user = $_GET["user"];
$pass = $_GET["pass"];
$user = mysql_real_escape_string($user);
$pass = mysql_real_escape_string($pass);

$result = mysql_query("SELECT COUNT(*),`banned` FROM `accounts` WHERE `login` = '{$user}' AND `encrypted_password` = '{$pass}'");
$row = mysql_fetch_array($result);

if ($row[0] == 1 && $row[1] == 0)
{
	$_SESSION['IP'] = $user;
}

mysql_close($connection);

if (isset($_SESSION['IP']))
{
	echo "26678309";
}
?>