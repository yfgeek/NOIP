@echo off
if "%1"=="" goto loop
copy energy%1.in energy.in >nul
echo Problem Test
echo Data %1
time<enter
energy.exe
time<enter
fc energy.out energy%1.ans
pause
goto end
:loop
for %%i in (1 2 3 4 5 6 7 8 9 10) do call %0 %%i
:end
del energy.in
del energy.out