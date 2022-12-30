@setlocal enableextensions enabledelayedexpansion
@echo off
set /a x1=15
set /a x2=10

set /a y1=15
set /a y2=35

set /a x=%x1%
set /a y=%y1%

set /a x2min1=%x2% - %x1%
set /a y2min1=%y2% - %y1%
set /a y2plusy1div2=(%y2% + %y1%)/2

:if %x2min1%  LEQ 0 (goto checkforerror)
:if %y2min1%  LEQ 0 (goto checkforerror)
:noerror

set /a error=0
if %x2min1% LEQ 0 set /a slope = ( ( ( y2 - y1 ) * -1 ) * 1000 ) / 1
if %x2min1% GTR 0 set /a slope = ( ( ( y2 - y1 ) * -1 ) * 1000 ) / ( x2 - x1 )

set /a slope=%slope%*-1

set /a counter = %x1%

:draw

echo [%y%;%x%H#!

if %y2% GTR %x2% (goto initxloop)

:yloop
if %counter%==%x2% (goto end)

set /a error = %error% + %slope%

set /a counter = %counter%+1

set /a x=%x%+1

if %error% GTR 500 (set /a y = %y%+1)
if %error% GTR 500 (set /a error = %error%-500)
if %error% LSS -500 (set /a y = %y%-1)
if %error% LSS -500 (set /a error = %error%+500)

echo [%y%;%x%H#!
goto yloop



:initxloop

:edit variables

set /a slope= ( ( ( x2 - x1 ) * -1 ) * 1000 ) / ( y2 - y1 )
set /a slope=%slope%*-1

set /a counter = %y1%

:xloop
if %counter%==%y2% (goto end)

set /a counter = %counter%+1

set /a error = %error% + %slope%

set /a y=%y%+1

if %error% GTR 500 (set /a x = %x%+1)
if %error% GTR 500 (set /a error = %error%-500)
if %error% LSS -500 (set /a x = %x%-1)
if %error% LSS -500 (set /a error = %error%+500)

echo [%y%;%x%H#!
goto xloop



:checkforerror
if %y2min1%  LSS 0 (goto X2X1Y2Y1error)
if %y2plusy1div2% EQU %y2% (goto X1Largeerror)
goto noerror


:X2X1Y2Y1error
echo error 1: X2 cant be less than X1 while Y2 is less than Y1
pause
exit

:X1Largeerror
echo error 2: X1 can not be larger than X2 if Y1 and Y2 is the same value
pause
exit

:end
pause





