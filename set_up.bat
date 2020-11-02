
@echo off

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
	echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
	set params= %*
	echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

	"%temp%\getadmin.vbs"
	del "%temp%\getadmin.vbs"
	exit

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------
	start /wait %~dp0\AutoHotkey\installer.exe
	schtasks /create /tn SecondKeyboard /tr "%~dp0\program\autostart.bat" /sc onlogon
	if %errorlevel%	== 1 (
		echo Task set up unsuccessful. Contact developer.
	) else (	
		echo Task set up successful. Every time you open your pc everything will be ready.
	)	
	cmd /k
