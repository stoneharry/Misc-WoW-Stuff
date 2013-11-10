@echo off

::enable that thing to allow, for example, incremental counter in a for loop :)
echo.- EnableDelayedExpansion
SETLOCAL EnableDelayedExpansion

::variables
echo.- variables
:: - place here the absolute root path of your files
set path2work="C:\Users\Harry_\Desktop\New\folders"

::only an auxiliar variable
set pathbak=%cd%

::go to %path2work% and its drive letter
echo.- entering the path you want
for /f "delims=¯" %%i in ('echo.%path2work%') do %%~di
cd %path2work%

::search all subfolders and save them to a temp file
echo.- searching for subfolders
echo.%path2work%>%temp%\tmpvar.txt
for /f "delims=¯" %%i in ('dir /s /b /on /ad') do echo.%%i>>%temp%\tmpvar.txt

::execute command for root folder and all found subfolders
echo.
echo.2.executing...
for /f "delims=¯" %%i in (%temp%\tmpvar.txt) do (
  cd %%i
  echo.- in folder: %%i
  for /f "delims=¯" %%j in ('dir /b /on /a-d *.lua') do (
echo %%i\%%j
    C:\Users\Harry_\Desktop\New\lua52.exe C:\Users\Harry_\Desktop\New\_ob.lua %%i\%%j
  )
)

echo.
echo.3.exiting...
::return to %pathbak% and its driveletter
for /f "delims=¯" %%i in ('echo.%pathbak%') do %%~di
cd %pathbak%

@echo on