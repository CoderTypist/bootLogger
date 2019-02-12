@echo off

set website=https://www.google.com/
set numWindows=40

set count=0

:loop
	
	set /a count=count+1
	start chrome --incognito %website%
	if %count% equ %numWindows% goto break

goto loop

:break
