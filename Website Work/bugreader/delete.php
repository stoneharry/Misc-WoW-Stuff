<!DOCTYPE html>
<html><head><title>Bug Report Deleter - Edge of Chaos</title>
<?php
$pass = $_GET["pass"];

if ($pass == "12345")
{

$connection = mysql_connect("37.59.19.103", "eocweb", "St0n3H4arry@eoc2013BTS") or die("Connection to Database failed");
mysql_select_db("harry_chars") or die ("Database selection failed");
$id = mysql_real_escape_string($_GET["id"]);
if ($id != NULL && $id != "")
{
	mysql_query("DELETE FROM `playerbugreports` WHERE `UID` = '{$id}'");
	echo "Deleted successfully. <a href=\"index.php?pass=12345\">Return.</a>";
}
mysql_close($connection);

}
?>
</body></html>