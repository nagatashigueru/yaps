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

main : HeadObj $(OBJS) HeadExe
	$(FC) -o $(BINARY) $(OBJS)

HeadObj :
	@printf -- '-%0.s' {1..50}
	@echo ""
	@echo "CREANDO OBJETOS"
	@printf -- '-%0.s' {1..50}
	@echo ""

HeadExe :
	@printf -- '-%0.s' {1..50}
	@echo ""
	@echo "CREANDO EJECUTABLE"
	@printf -- '-%0.s' {1..50}
	@echo ""

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

clean :
	rm *.o *.mod *.out
