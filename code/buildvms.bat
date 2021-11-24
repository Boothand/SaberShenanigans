set include=
cd game
call game.bat
cd ..\..\cgame
call cgame.bat
cd ..

xcopy /s /y "D:\Git\saber-shenanigans\code\base\vm\jk2mpgame.qvm" "C:\Users\Rune\Documents\jk2mv\SaberShenanigans\vm"
xcopy /s /y "D:\Git\saber-shenanigans\code\base\vm\cgame.qvm" "C:\Users\Rune\Documents\jk2mv\SaberShenanigans\vm"
pause