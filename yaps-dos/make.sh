#!/bin/bash
#echo "LIMPIANDO"
#rm yaps-dos.out yaps-dos.o fermi.o fermi.mod files.o files.mod data.o data.mod saludo.o saludo.mod
echo "*** CREANDO OBJETOS ***"
gfortran -c yaps-dos.f95
gfortran -c modules/fermi.f95
gfortran -c modules/files.f95
gfortran -c modules/data.f95
gfortran -c modules/saludo.f95
echo "*** OBJETOS CREADOS ***"
echo " "
echo "*** GENERANDO EJECUTABLE ***"
gfortran -o yaps-dos.out yaps-dos.o fermi.o files.o data.o saludo.o
echo "*** EJECUTABLE GENERADO ***"
