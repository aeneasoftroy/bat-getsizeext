@echo off
REM GetSizeExt batch script by Aeneas Of Troy
REM This is a little helper script for compression benchmarking which also doubles as scriptable detailed file size reporting tool.
REM the script recursively searches for the given file extension(s) and reports the cumulative size.
REM Usage examples:
REM _GetSizeExt.bat * "%CD%\Dataset"
REM _GetSizeExt.bat "wav,jpg" "%CD%\audiofiles"
REM _GetSizeExt.bat "zip,rar,nz,rz,ace,wav,mp3,jpg" "%CD%\files"
REM calling the script from another batch:
REM call "%SCRIPTHOMEDIR%\_GetSizeExt.bat" * "%CD%"
REM call "%SCRIPTHOMEDIR%\_GetSizeExt.bat" "zip,rar,nz,rz,ace,wav,mp3,jpg" "%CD%" >> "%SCRIPTHOMEDIR%\log.txt"

REM THE OUTPUT WHEN INSUFFICIENT PARAMETERS ARE GIVEN:
if [%1] == [] color 0c&&echo GetSizeExt batch script by AOT&&echo.&&echo ERROR^: No file extension filter parameter specified.&&echo.&&echo Usage examples^: &&echo %0 ^* "%%CD%%" &&echo %0 "zip,rar,nz,rz,ace,wav,mp3,jpg" "%%CD%%"&&pause&&goto :EOF

REM SET FIRST PARAMETER AS EXTENSION INPUT:
set EXTENSIONS=%1

REM WE'RE GOING TO EXPAND VARIABLES INSIDE LOOPS SO:
setlocal enabledelayedexpansion

REM STRIP THE QUOTES FROM THE STRING:
set EXTENSIONS=!EXTENSIONS:"=!

REM CHANGE DIRECTORY TO THE SCRIPT'S ROOT
pushd "%~dp0"

REM INCLUDE THE BIN DIRECTORY IN THE PATH WITH YOUR EXTRA EXECUTABLES (OPTIONAL)
set path=%CD%\bin;%PATH%

REM SET THE TITLE OF THE WINDOW
title GETSIZEEXT-AOT

REM DEFINE THE USED VARIABLES TO 0 TO AVOID COMPLICATIONS
set TOTALSIZE=0
set TOTALFILES=0

REM Change to the given directory before getting the file details:
CD %2

REM WE JUMP OVER THE GET_EXT PROCEDURE TO THE 'START' WHICH WILL SPLIT THE INPUT OF %1 AND CALLS IT.
goto :START

:GET_EXT

REM SINCE THE IS CALLED WITH A PARAMETER, WE SET IT TO VARIABLE 'EXT'
set EXT=%1

REM GOTO END OF FILE (EOF) WHEN THERE'S NO INPUT LEFT:
if [%EXT%] == [] goto :EOF
REM DEFINE THE USED VARIABLES TO 0 TO AVOID COMPLICATIONS
set Count=0
set Countb=0
set CountKB=0
set CountMB=0
REM RECURSIVELY SEEK FOR THE GIVEN EXTENSION THROUGH THE DEFINED DIRECTORY
for /R "%CD%" %%i in (*.%EXT%) do SET /A Count += 1 >NUL
REM RECURSIVELY SEEK FOR THE GIVEN EXTENSION THROUGH THE DEFINED DIRECTORY AND GET THE SIZE
for /R "%CD%" %%i in (*.%EXT%) do SET /A Countb += %%~zi >NUL
REM START DIVIDING THE BYTESIZE TO KB AND MB:
set /a CountKB = %countb% / 1024
set /a CountMB = %countb% / 1024 / 1024
REM ECHO TOTALS ON COMPLETION:
if not %count% == 0 echo %EXT%: %count% files, %countb% byte, %countkb% KByte, %countmb% MByte
REM SET TOTALS OF THE VARIABLES:
set /a TOTALFILES = %TOTALFILES% + %count% 
set /a TOTALSIZE = %TOTALSIZE% + %countkb%
set /a TOTALSIZEMB = %TOTALSIZE% / 1024
goto :EOF

:START
REM QUICK WAY TO SPLIT THE INPUT OF EXTENSIONS TO THE GET_EXT LOOP (14 extensions max!):
FOR /f "tokens=1,2,3,4,5,6,7,8,9,10,11,12,13,14 delims=," %%a IN ("%extensions%") do (
call :GET_EXT %%a
call :GET_EXT %%b
call :GET_EXT %%c
call :GET_EXT %%d
call :GET_EXT %%e
call :GET_EXT %%f
call :GET_EXT %%g
call :GET_EXT %%h
call :GET_EXT %%i
call :GET_EXT %%j
call :GET_EXT %%k
call :GET_EXT %%l
call :GET_EXT %%m
call :GET_EXT %%n
call :GET_EXT %%o
call :GET_EXT %%p
REM ECHO THE TOTALS OF ALL THE PERFORMED CALCULATIONS:
echo Total size: !TOTALSIZE! KByte ^(!TOTALSIZEMB!MB^) in !TOTALFILES! files.
)
:EOF
