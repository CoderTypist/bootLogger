@echo off

rem creates the folder in which to put bootLog.txt
if not exist "C:\ProgramData\Programs" (
    mkdir "C:\ProgramData\Programs"
    attrib +h "C:\ProgramData\Programs"
)

rem creates bootLog.txt
if not exist "C:\ProgramData\Programs\bootLog.txt" (
    type nul > "C:\ProgramData\Programs\bootLog.txt"
    attrib +h "C:\ProgramData\Programs\bootLog.txt"
)

rem creates bootLogger.bat
if not exist "C:\Users\%username%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\bootLogger.bat" (
    type nul > boolLogger.bat
    attrib +h "C:\Users\%username%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\bootLogger.bat"
    echo echo %date% %time% %username% ^>^> "C:\ProgramData\Programs\bootLog.txt" > "C:\Users\%username%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\bootLogger.bat"
)
