echo off

REM compile
echo Compile...
ghc -o final final.hs

REM start to execute it
echo Run...
final.exe < testcase1.in