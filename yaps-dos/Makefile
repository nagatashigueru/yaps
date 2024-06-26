# **************************
#   MAKEFILE - yaps-dos    
# --------------------------
# Autor :: Shigueru Nagata
# Fecha :: Junio 2024
# **************************

# ... VARIABLES ...

OBJS = yaps-dos.o fermi.o files.o
BINARY = yaps-dos.out
FC = gfortran
PATHMD = modules

# ... REGLAS ...

all = main

main : $(OBJS)
	$(FC) -o $(BINARY) $(OBJS)

fermi.o : $(PATHMD)/fermi.f95
	$(FC) -c $(PATHMD)/fermi.f95

files.o : $(PATHMD)/files.f95
	$(FC) -c $(PATHMD)/files.f95

yaps-dos.o : yaps-dos.f95
	$(FC) -c yaps-dos.f95
