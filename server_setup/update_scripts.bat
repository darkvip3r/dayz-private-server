@echo off
cd bliss_files
echo.
echo Update Chernarus BattlEye script files
echo.
..\perl\bin\perl -w update_scripts.pl --world chernarus ..\..\dayz_1.chernarus\BattlEye\
echo.
echo Update Lingor Island BattlEye script files
echo.
..\perl\bin\perl -w update_scripts.pl --world lingor ..\..\dayz_2.lingor\BattlEye\
echo.
echo Update Utes BattlEye script files
echo.
..\perl\bin\perl -w update_scripts.pl --world utes ..\..\dayz_3.utes\BattlEye\
echo.
echo Update Takistan BattlEye script files
echo.
..\perl\bin\perl -w update_scripts.pl --world takistan ..\..\dayz_4.takistan\BattlEye\
echo.
echo Update Panthera BattlEye script files
echo.
..\perl\bin\perl -w update_scripts.pl --world panthera2 ..\..\dayz_5.panthera2\BattlEye\
echo.
echo Update Fallujah BattlEye script files
echo.
..\perl\bin\perl -w update_scripts.pl --world fallujah ..\..\dayz_6.fallujah\BattlEye\
echo.
echo Update Zargabad BattlEye script files
echo.
..\perl\bin\perl -w update_scripts.pl --world zargabad ..\..\dayz_7.zargabad\BattlEye\
echo.
echo Update Namalsk BattlEye script files
echo.
..\perl\bin\perl -w update_scripts.pl --world namalsk ..\..\dayz_8.namalsk\BattlEye\
echo.
echo Update Celle BattlEye script files
echo.
..\perl\bin\perl -w update_scripts.pl --world mbg_celle2 ..\..\dayz_9.mbg_celle2\BattlEye\
echo.
echo Update Taviana BattlEye script files
echo.
..\perl\bin\perl -w update_scripts.pl --world tavi ..\..\dayz_10.tavi\BattlEye\
echo.
echo BattlEye script files updated.
pause
exit