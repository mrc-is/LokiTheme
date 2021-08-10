@echo off&Title Enter desired AMT
setlocal enableextensions
set count=0
for %%x in (*.txt) do set /a count+=1
If %count% GTR 1 (Goto LOG)
echo.&SET /P qty=
SET i=1
for /r %%f in (*.txt) do (set ori=%%~nxf&set ori2=%%~nf)
:loop
SET /A i=i+1
Copy "%ori%" "%ori2% %i%.txt" >NUL&echo.&echo Check folder for new files    &CLS
DEL %tmp%\log
for %%f in (*.txt) do (echo %%~nf) >>%tmp%\log
If %qty% == %i% (Start "" Notepad %tmp%\log&&EXIT)
Goto loop
endlocal

:LOG
dir /b /a-d *.txt>%tmp%\log
setlocal enabledelayedexpansion
set INTEXTFILE=%tmp%\log
set OUTTEXTFILE=%tmp%\slog
set SEARCHTEXT=.txt
set REPLACETEXT=
set OUTPUTLINE=
del %OUTTEXTFILE%
for /f "tokens=1,* delims=¶" %%A in ( '"type %INTEXTFILE%"') do (
SET string=%%A
SET modified=!string:%SEARCHTEXT%=%REPLACETEXT%!
echo !modified! >> %OUTTEXTFILE%
)
del %INTEXTFILE%
Start "" Notepad %tmp%\slog


:REN
ren "26mar SIM 2.txt " "26Mar SIM 4a n710.txt"
ren "26mar SIM.txt " "26Mar SIM 4d n710.txt"
