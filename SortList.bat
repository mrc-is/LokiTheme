@echo off
if exist "test.txt" Goto Start
Title ■ACHTUNG!
echo missing test.txt
pause>NUL&exit

:start
setlocal EnableExtensions EnableDelayedExpansion
   Set file=test.txt
for %%a in (%FILE%) do (
   Set "File2=%%~na2.txt")

REM get first line:
<%FILE% set /p first=
REM write it to a new file:
>%FILE2% echo %first%
REM sort the rest and append to the new file:
<%FILE% more +1|sort >>%FILE2%

DEL %FILE%
REN %FILE2% %FILE%

REM remove blank lines in between:
for /f "usebackq tokens=* delims=" %%a in ("%FILE%") do (echo(%%a)>>~.txt
move /y ~.txt "%FILE%"
