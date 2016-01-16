set include=
cd game
call game
cd ..\cgame
call cgame
pause
xcopy /s /y "D:\MEGA\JK2\newSaberShenanigans\code\base\vm\jk2mpgame.qvm" "D:\Program Files (x86)\steam\steamapps\common\Jedi Outcast\GameData\SaberShenanigans\vm"
xcopy /s /y "D:\MEGA\JK2\newSaberShenanigans\code\base\vm\cgame.qvm" "D:\Program Files (x86)\steam\steamapps\common\Jedi Outcast\GameData\SaberShenanigans\vm"