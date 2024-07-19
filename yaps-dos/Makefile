# **************************
#   MAKEFILE - yaps-dos    
# --------------------------
# Autor :: Shigueru Nagata
# Fecha :: Junio 2024
# **************************

# ... VARIABLES ...

OBJS = saludo.o error.o fermi.o files.o init.o data.o yaps-dos.o 
BINARY = yaps-dos.out
FC = gfortran
PATHMD = modules

# ... REGLAS ...

all = main

main : $(OBJS)
	$(FC) -o $(BINARY) $(OBJS)

saludo.o : $(PATHMD)/saludo.f95
	$(FC) -c $(PATHMD)/saludo.f95

error.o : $(PATHMD)/error.f95
	$(FC) -c $(PATHMD)/error.f95
                               
fermi.o : $(PATHMD)/fermi.f95
	$(FC) -c $(PATHMD)/fermi.f95

files.o : $(PATHMD)/files.f95
	$(FC) -c $(PATHMD)/files.f95

init.o : $(PATHMD)/init.f95
	$(FC) -c $(PATHMD)/init.f95

data.o : $(PATHMD)/data.f95
	$(FC) -c $(PATHMD)/data.f95

yaps-dos.o : yaps-dos.f95
	$(FC) -c yaps-dos.f95
