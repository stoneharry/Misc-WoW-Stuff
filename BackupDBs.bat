@ECHO off

set year=%date:~10,4%
set month=%date:~4,2%
set day=%date:~7,2%
set DATET=%year%_%month%_%day%

echo Backing up scripts...

md "C:\Users\StoneDev\Desktop\Backups\Scripts"
xcopy /E "C:\Users\StoneDev\Desktop\Dev Realm\Scripts\Dropbox\kronos (1)" "C:\Users\StoneDev\Desktop\Backups\Scripts"

echo Backing up auth...

"c:\program files\mysql\MySQL Server 5.5\bin\mysqldump" --host="127.0.0.1" --user="" --password="@" eoc_auth > "c:\Users\StoneDev\desktop\backups\"%DATET%_auth.sql
echo Done.

echo Backing up chars...

"c:\program files\mysql\MySQL Server 5.5\bin\mysqldump" --host="127.0.0.1" --user="" --password="@" eoc_chars > "c:\Users\StoneDev\desktop\backups\"%DATET%_chars.sql
echo Done.

echo Backing up world...

"c:\program files\mysql\MySQL Server 5.5\bin\mysqldump" --host="127.0.0.1" --user="" --password="@" eoc_world > "c:\Users\StoneDev\desktop\backups\"%DATET%_world.sql
echo Done.

echo Compressing...

"C:\Users\StoneDev\desktop\7za" a -tzip -y -mx9 "C:\Users\StoneDev\desktop\"%DATET%.zip "C:\Users\StoneDev\desktop\Backups"
xcopy C:\Users\StoneDev\desktop\%DATET%.zip "C:\Users\StoneDev\Desktop\Dev Realm\Scripts\Dropbox\kronos (1)\"
echo Done.

echo Deleting old files...

del "C:\Users\StoneDev\desktop\Backups\*.sql"
del "C:\Users\StoneDev\desktop\%DATET%.zip"
rmdir /s /q "C:\Users\StoneDev\Desktop\Backups\Scripts"

echo Done!