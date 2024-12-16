@echo off
chcp 65001 >nul
title BATranslator vBeta 1.0 >nul
setlocal enabledelayedexpansion >nul

:a
cls
set translation=error in translate
echo Enter the source language code (eg. en for English):
set /p source_lang=
echo.
echo Enter the target language code (eg. fr for French):
set /p target_lang=
echo.
echo Enter the text to be translated:
set /p text=
echo.
::echo.
::echo %source_lang% %target_lang% %text%
::echo.

set "encoded_text="
for /f "tokens=*" %%A in ('echo %text%') do (
set "encoded_text=%%A"
)
::echo encoded text = %text%
::echo.
set "text=!text: =%%20!"
::echo.
::echo this after curl
::curl "https://translate.googleapis.com/translate_a/single?client=gtx&sl=%source_lang%&tl=%target_lang%&dt=t&q=%text%
::echo.
::echo.
for /f "delims=" %%B in ('curl -s "https://translate.googleapis.com/translate_a/single?client=gtx&sl=%source_lang%&tl=%target_lang%&dt=t&q=%text%"') do set "response=%%B"

set result=!response:~4!
for /f "tokens=1 delims=," %%C in ("!result!") do set "translation=%%C"
set translation=!translation:"=!

echo Translation result: !translation!

pause>nul
goto a