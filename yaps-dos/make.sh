#!/bin/bash
echo "*** CREANDO OBJETOS ***"
gfortran -c yaps-dos.f95
gfortran -c modules/fermi.f95
gfortran -c modules/files.f95
echo "*** OBJETOS CREADOS ***"
echo " "
echo "*** GENERANDO EJECUTABLE ***"
gfortran -o yaps-dos.out yaps-dos.o fermi.o files.o
echo "*** EJECUTABLE GENERADO ***"
