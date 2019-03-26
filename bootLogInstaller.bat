@echo off
setlocal enabledelayedexpansion

goto main

rem call :yesOrNo variableStoringResult "Prompt to show user"
rem Gets a 'y' (yes) or 'n' (no) from the user
rem param1 = nameOfVariable
rem param2 = stringPrompt
:yesOrNo

    rem prints the prompt
    echo %~2
    echo Enter 'Y' for yes and 'N' for no
    set /p selection="Selection: "
    
    if %selection%==Y ( 
        set %~1=0 
    ) else if %selection%==y ( 
        set %~1=0
    ) else if %selection%==N ( 
        set %~1=1 
    ) else if %selection%==n ( 
        set %~1=1 
    ) else ( 
        echo.
        call :yesOrNo %~1 %~2
    )
    echo.

goto :eof

rem The user chooses what directory they want to save bootLog.txt in
:chooseDirectory

    echo What directory do you want to use?
    echo Specify the absolute path
    set /p %~1=""

    rem gives the user the option to create the folder if it does not exist
    if not exist "%~1%" (
        rem 0 means 'y' and 1 means 'n'
        set choice=0
        echo.
        call :yesOrNo choice "!%~1%! does not exist. Do you want to create it?"
        
        if !choice! equ 0 (
            mkdir "!%~1!"
        ) else (
            call :chooseDirectory %~1
            goto :eof
        )
    )

goto :eof

:main
    setlocal

    set startup=C:\Users\%username%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
    
    if not exist "%startup%" (
        echo "%startup% does not exist"
        echo This program requires the existence of that path.
        goto :eof
    )

    echo This program will store the info about when the computer was started up in a text file
    echo Enter the name you want for the .txt file (without the extension)
    set /p fileName=""
    set fileName=%fileName%.txt
    set location=C:\ProgramData\Programs

    rem asks the user if they want to save the file in C:\ProgramData\Programs
    set /a useDefault=2
    echo.
    echo %fileName% will be saved in C:\ProgramData\Programs
    echo The directory and %fileName% will be hidden
    echo You can choose to save %fileName% in another location
    echo You will be given the option to hide the folder
    echo.
    call :yesOrNo useDefault "Do you want to save %fileName% in %location% ?"

    rem if the user chose to use their own directory, they get to choose
    if %useDefault% equ 1 (
        call :chooseDirectory location

        set hideOrNot=1
        call :yesOrNo choice "Do you want to hide !location!?"

        if !choice! equ 0 (
            attrib +h "!location!"
        )
    )

    rem creates the folder in which to put bootLog.txt
    if not exist "%location%" (
        mkdir "%location%"
        attrib +h "%location%"
    )
        
    rem creates bootLog.txt
    if not exist "%location%\%fileName%" (
        type nul > "%location%\%fileName%"
        attrib +h "%location%\%fileName%"
    )
    
    rem creates bootLogger.bat
    if not exist "%startup%\bootLogger.bat" (
        type nul > "%startup%\bootLogger.bat"
    )
    
    echo echo %%date%% %%time%% %%username%% ^>^> "%location%\%fileName%" > "%startup%\bootLogger.bat"
    
    echo Set up complete
    pause

    endlocal
goto :eof
