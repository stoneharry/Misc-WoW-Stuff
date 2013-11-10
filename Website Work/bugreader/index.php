<!DOCTYPE html>
<html><head><title>Bug Report Reader - Edge of Chaos</title><script language="JavaScript" type="text/javascript">
<!--
if (document.getElementById) {
document.writeln('<style type="text/css"><!--')
document.writeln('.texter {display:none} @media print {.texter {display:block;}}')
document.writeln('//--></style>') }

function openClose(theID) {
if (document.getElementById(theID).style.display == "block") { document.getElementById(theID).style.display = "none" }
else { document.getElementById(theID).style.display = "block" } }
// -->
</script></head><body>
<?php
$pass = $_GET["pass"];

if ($pass == "54321")
{

$connection = mysql_connect("37.59.19.103", "eocweb", "@") or die("Connection to Database failed");
mysql_select_db("harry_chars") or die ("Database selection failed");

$result = mysql_query("SELECT * FROM `playerbugreports` ORDER BY UID DESC");
$row = mysql_fetch_array($result);
$count = 0;
while ($row)
{
	$show = false;
	$output = "";
	for ($i = 0; $i < 6; $i++)
	{
		if ($i == 0)
		{
			$date = date('m/d/Y', $row[2]);
			$output = $output . "<div onClick=\"openClose('a{$row[0]}')\" style=\"cursor:hand; cursor:pointer\">";
			$output = $output . "<u><b>Bug ID: {$row[$i]}</b></u> - <b>Account ID:</b> {$row[1]} - <b>Date:</b> {$date} - <u><font color=\"blue\">Open/Close</font></u></div>";
		}
		else if ($i == 1)
		{
			$output = $output . "<div id=\"a{$row[0]}\" class=\"texter\">";
			$output = $output . "<b>Account ID:</b> {$row[$i]}<br>";
		}
		else if ($i == 2)
		{
			$date = date('m/d/Y', $row[$i]);
			$output = $output . "<b>Date:</b> {$date}<br>";
		}
		else if ($i == 3)
		{
			if ($row[$i] == 1)
			{
				$output = $output . "<b>Suggestion:</b> True<br>";
			}
			else
			{
				$output = $output . "<b>Suggestion:</b> False<br>";
			}
		}
		else if ($i == 4)
		{
			$output = $output . "<a href=\"delete.php?id={$row[0]}&pass=12345\">Delete This Report</a><br>";
			$output = $output . "<b>Character Data:</b><br><pre>";
			// Parse XML
			$html= "<?xml version=\"1.0\"?><Config>{$row[$i]}</Config>";
			$html = str_replace("<", "<T", $html);
			$html = str_replace("<T?", "<?", $html);
			$html = str_replace("<T/", "</T", $html);
			$xml = simplexml_load_string($html);

			$output = $output . "Report Type:		{$xml->T26}<br>";
			$output = $output . "WoW Version:		{$xml->T1}<br>";
			$output = $output . "WoW Build:		{$xml->T2}<br>";
			$output = $output . "Realm Name:		{$xml->T4}<br>";
			$output = $output . "Locale:			{$xml->T5}<br>";
			$output = $output . "Character:		{$xml->T6}<br>";
			$output = $output . "Race:			{$xml->T8}<br>";
			$output = $output . "Level:			{$xml->T7}<br>";
			$output = $output . "Gender:			{$xml->T9}<br>";
			$output = $output . "Average Combat Time:	{$xml->T39}<br>";
			$output = $output . "NPC Name:		{$xml->T23}<br>";
			$output = $output . "Speed:		{$xml->T16}<br>";
			$output = $output . "Map:			{$xml->T11}<br>";
			$output = $output . "Location:		{$xml->T12}<br>";
			$output = $output . "Reported:		{$xml->T43}<br>";
			$output = $output . "AddOns:			{$xml->T19}<br>";
			$output = $output . "Survey Name:		{$xml->T27}<br>";
			$output = $output . "Survey ID:		{$xml->T28}<br>";
			$output = $output . "Survey Objective:		{$xml->T29}<br>";
			$output = $output . "Survey Type:		{$xml->T30}<br>";
			$output = $output . "Survey Obtained:	{$xml->T31}<br>";
			$output = $output . "Survey Submitted:	{$xml->T32}<br>";
			$in = $xml->T33;
			if ($in == 1)
			{
				$in = "Extremely Vague";
			}
			else if ($in == 2)
			{
				$in = "Somewhat Vague";
			}
			else if ($in == 3)
			{
				$in = "Fairly Clear";
			}
			else if ($in == 4)
			{
				$in = "Perfectly Clear";
			}
			$output = $output . "Clarity:		{$in}<br>";
			$in = $xml->T34;
			if ($in == 1)
			{
				$in = "Easy";
			}
			else if ($in == 2)
			{
				$in = "Manageable";
			}
			else if ($in == 3)
			{
				$in = "Challenging";
			}
			else if ($in == 4)
			{
				$in = "Hard";
			}
			$output = $output . "Difficulty:		{$in}<br>";
			$in = $xml->T35;
			if ($in == 1)
			{
				$in = "Awful";
			}
			else if ($in == 2)
			{
				$in = "Bad";
			}
			else if ($in == 3)
			{
				$in = "Good";
			}
			else if ($in == 4)
			{
				$in = "Awesome";
			}
			$output = $output . "Rewards:		{$in}<br>";
			$in = $xml->T36;
			if ($in == 1)
			{
				$in = "Not fun at all";
			}
			else if ($in == 2)
			{
				$in = "Not very fun";
			}
			else if ($in == 3)
			{
				$in = "Pretty fun";
			}
			else if ($in == 4)
			{
				$in = "A lot of fun";
			}
			$output = $output . "Fun:			{$in}<br>";
			$output = $output . "Who:		{$xml->T23}<br>";
			$output = $output . "Where:		{$xml->T24}<br>";
			$output = $output . "When:		{$xml->T25}<br>";
			$output = $output . "Type:		{$xml->T26}<br>";
			$output = $output . "Equipment:		{$xml->T22}<br>";
			$mess = $xml->T41;
			if (strlen($mess) != 0)
			{
				$show = true;
				$output = $output . "Message: {$mess}<br>";
			}

			$output = $output . "</pre>";
			//print_r($xml);

		}
		else if ($i == 5)
		{
			$output = $output . "<b>Computer:</b> <pre>{$row[$i]}<br></pre></div>";
		}
	}
	$output = $output . "<br>";
	if ($show)
	{
		$count = $count + 1;
		echo $output;
	}
	$row = mysql_fetch_array($result);
}
echo "<br><br><b>There are {$count} reports open.</b><br><br>";

mysql_close($connection);

}
else
{
$connection = mysql_connect("37.59.19.103", "StoneHarry", "@") or die("Connection to Database failed");
mysql_select_db("harry_chars") or die ("Database selection failed");

$result = mysql_query("SELECT * FROM `playerbugreports` ORDER BY UID DESC");
$row = mysql_fetch_array($result);
$count = 0;
while ($row)
{
	$show = false;
	$output = "";
	for ($i = 0; $i < 6; $i++)
	{
		if ($i == 0)
		{
			$date = date('m/d/Y', $row[2]);
			$output = $output . "<div onClick=\"openClose('a{$row[0]}')\" style=\"cursor:hand; cursor:pointer\">";
			$output = $output . "<u><b>Bug ID: {$row[$i]}</b></u> - <b>Account ID:</b> {$row[1]} - <b>Date:</b> {$date} - <u><font color=\"blue\">Open/Close</font></u></div>";
		}
		else if ($i == 1)
		{
			$output = $output . "<div id=\"a{$row[0]}\" class=\"texter\">";
			$output = $output . "<b>Account ID:</b> {$row[$i]}<br>";
		}
		else if ($i == 2)
		{
			$date = date('m/d/Y', $row[$i]);
			$output = $output . "<b>Date:</b> {$date}<br>";
		}
		else if ($i == 3)
		{
			if ($row[$i] == 1)
			{
				$output = $output . "<b>Suggestion:</b> True<br>";
			}
			else
			{
				$output = $output . "<b>Suggestion:</b> False<br>";
			}
		}
		else if ($i == 4)
		{
			$output = $output . "<b>Character Data:</b><br><pre>";
			// Parse XML
			$html= "<?xml version=\"1.0\"?><Config>{$row[$i]}</Config>";
			$html = str_replace("<", "<T", $html);
			$html = str_replace("<T?", "<?", $html);
			$html = str_replace("<T/", "</T", $html);
			$xml = simplexml_load_string($html);

			$output = $output . "Report Type:		{$xml->T26}<br>";
			$output = $output . "WoW Version:		{$xml->T1}<br>";
			$output = $output . "WoW Build:		{$xml->T2}<br>";
			$output = $output . "Realm Name:		{$xml->T4}<br>";
			$output = $output . "Locale:			{$xml->T5}<br>";
			$output = $output . "Character:		{$xml->T6}<br>";
			$output = $output . "Race:			{$xml->T8}<br>";
			$output = $output . "Level:			{$xml->T7}<br>";
			$output = $output . "Gender:			{$xml->T9}<br>";
			$output = $output . "Average Combat Time:	{$xml->T39}<br>";
			$output = $output . "NPC Name:		{$xml->T23}<br>";
			$output = $output . "Speed:		{$xml->T16}<br>";
			$output = $output . "Map:			{$xml->T11}<br>";
			$output = $output . "Location:		{$xml->T12}<br>";
			$output = $output . "Reported:		{$xml->T43}<br>";
			$output = $output . "AddOns:			{$xml->T19}<br>";
			$output = $output . "Survey Name:		{$xml->T27}<br>";
			$output = $output . "Survey ID:		{$xml->T28}<br>";
			$output = $output . "Survey Objective:		{$xml->T29}<br>";
			$output = $output . "Survey Type:		{$xml->T30}<br>";
			$output = $output . "Survey Obtained:	{$xml->T31}<br>";
			$output = $output . "Survey Submitted:	{$xml->T32}<br>";
			$in = $xml->T33;
			if ($in == 1)
			{
				$in = "Extremely Vague";
			}
			else if ($in == 2)
			{
				$in = "Somewhat Vague";
			}
			else if ($in == 3)
			{
				$in = "Fairly Clear";
			}
			else if ($in == 4)
			{
				$in = "Perfectly Clear";
			}
			$output = $output . "Clarity:		{$in}<br>";
			$in = $xml->T34;
			if ($in == 1)
			{
				$in = "Easy";
			}
			else if ($in == 2)
			{
				$in = "Manageable";
			}
			else if ($in == 3)
			{
				$in = "Challenging";
			}
			else if ($in == 4)
			{
				$in = "Hard";
			}
			$output = $output . "Difficulty:		{$in}<br>";
			$in = $xml->T35;
			if ($in == 1)
			{
				$in = "Awful";
			}
			else if ($in == 2)
			{
				$in = "Bad";
			}
			else if ($in == 3)
			{
				$in = "Good";
			}
			else if ($in == 4)
			{
				$in = "Awesome";
			}
			$output = $output . "Rewards:		{$in}<br>";
			$in = $xml->T36;
			if ($in == 1)
			{
				$in = "Not fun at all";
			}
			else if ($in == 2)
			{
				$in = "Not very fun";
			}
			else if ($in == 3)
			{
				$in = "Pretty fun";
			}
			else if ($in == 4)
			{
				$in = "A lot of fun";
			}
			$output = $output . "Fun:			{$in}<br>";
			$output = $output . "Who:		{$xml->T23}<br>";
			$output = $output . "Where:		{$xml->T24}<br>";
			$output = $output . "When:		{$xml->T25}<br>";
			$output = $output . "Type:		{$xml->T26}<br>";
			$output = $output . "Equipment:		{$xml->T22}<br>";
			$mess = $xml->T41;
			if (strlen($mess) != 0)
			{
				$show = true;
				$output = $output . "Message: {$mess}<br>";
			}

			$output = $output . "</pre>";
			//print_r($xml);

		}
		else if ($i == 5)
		{
			$output = $output . "<b>Computer:</b> <pre>{$row[$i]}<br></pre></div>";
		}
	}
	$output = $output . "<br>";
	if ($show)
	{
		$count = $count + 1;
		echo $output;
	}
	$row = mysql_fetch_array($result);
}
echo "<br><br><b>There are {$count} reports open.</b><br><br>";

mysql_close($connection);
}
?>
</body></html>