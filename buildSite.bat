@ECHO off
cls
echo %date% %time%
pushd %~dp0
echo Building site using jekyll . . .
REM --incremental
call jekyll build -d .\_site

popd