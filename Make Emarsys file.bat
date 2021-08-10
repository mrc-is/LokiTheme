
CHCP 65001
REM This BAT is ascii enabled
REM Keep the first line blank (this is necessary, because there are hidden chars in the first line for UTF-8 text file)
REM Example ascii (Alt255= )
REM To add Carriage RTN use %NL%
@echo off
::Set carriage RTN
set NLM=^


REM DoNot delete 2 empty lines above
set NL=^^^%NLM%%NLM%^%NLM%%NLM%
cmd /v:on /c
::Set proj name in UPPER case
CLS&Title Give Project Name&echo.&SET /P str=
set cap=
for /f "skip=2 delims=" %%I in ('tree "\%str%"') do if not defined cap set "cap=%%~I"
set "proj=%cap:~3%"
::set month
setlocal EnableDelayedExpansion
REM get %date% format first (eg Fri 03/12/2021)
:selek
CLS&Title Take Note of Date format&echo %date%%NL%
echo select Date format:
echo.&echo DDD dd/mm/yyyy [1]&echo mm/dd/yyyy     [2]&echo dd/mm/yyyy     [3]&echo.
set choice=&set /p choice=
if not '%choice%'=='' set choice=%choice:~0,1%
if '%choice%'=='1' (set month-num=%date:~4,2%&Goto lead0)
if '%choice%'=='2' (set month-num=%date:~0,2%&Goto lead0)
if '%choice%'=='3' (set month-num=%date:~3,2%&Goto lead0)
CLS&Goto selek

REM 4,2 for DDD dd/mm/yyyy  or 0,2 for mm/dd/yyyy  or 3,2 for dd/mm/yyyy
::set month-num=%date:~4,2%
REM remove any leading zero :
:lead0
IF "%month-num:~0,1%"=="0" SET month-num=%month-num:~1%
FOR /f "tokens=%month-num%" %%a in ("jan feb mar apr may jun jul aug sep oct nov dec") do set monthz=%%a
set cap=&&for /f "skip=2 delims=" %%I in ('tree "\%monthz%"') do (if not defined cap set "cap=%%~I")
set "monthy=%cap:~3%"
if not defined monthy CLS&Goto selek
::set day of month
for /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%b)
Set datez=!mydate!
::Final output
echo MSNO	Phone	FirstName	Email>%tmp%\log
Set Fold=%datez% %monthy%
Set File=%datez%%monthz% %proj%.txt

for %%A IN ('dir /b c:\') DO (md "%Fold%"&&copy /y %tmp%\log "%Fold%\%File%" )
IF ERRORLEVEL 1 (
for %%A IN ('dir /b c:\') DO (copy /y %tmp%\log "%Fold%\%File%" )
)
copy log.bat "%datez% %monthy%"
start "" "%Fold%\%File%"
exit /B
