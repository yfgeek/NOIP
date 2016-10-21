@echo off
copy parity.i%1 parity.in
copy parity.o%1 parity.std
parity %2
test
@echo on
