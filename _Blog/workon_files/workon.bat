@ECHO OFF

REM default location for global venvs
set _envs_root=C:\venvs

GOTO :MAIN


:USAGE
echo Usage:
echo %0 {env}
echo Will search for env in cwd (%cd%)
echo  or at root (%_envs_root%)
exit /B -1

:ACTIVATE
REM activate based on parameter passed in
call %1\scripts\activate
EXIT /B %errorlevel%


:MAIN
REM if no paremeter, call usage which will exit
IF "%1"=="" GOTO :USAGE

REM else, search for the env
:SEARCH
IF EXIST "%1" (
  REM activate local
  CALL :ACTIVATE %1
  EXIT /B %errorlevel%
)
IF EXIST "%_envs_root%\%1" (
  REM activate global
  CALL :ACTIVATE %_envs_root%\%1
  EXIT /B %errorlevel%
)
REM not found
ECHO Venv "%1" not found.
REM clear the variable before prompting whether to create locally or in the global deposit
set _local=
set /p _local="Create locally? ("no" will create in %_envs_root%) [Y/n]: "

REM set delayed expansion to allow for getting the cwd in the if statement.
SETLOCAL EnableDelayedExpansion

REM accept 'N' or 'n' via case insensitive match, only check first letter
IF /I "%_local:~0,1%"=="n" (
  echo Creating in venvs root (%_envs_root%)
  PUSHD %_envs_root%
  REM store our current location using delayed expansion
  set _root=!cd!
  call python -m venv %1
  POPD
) ELSE (
  echo Creating locally (!cd!)
  REM store our current location using delayed expansion
  set _root=!cd!
  call python -m venv %1
)
REM end the local scope, and copy _root out of it
ENDLOCAL & set _root=%_root%

CALL :ACTIVATE %_root%\%1

EXIT /B %errorlevel%