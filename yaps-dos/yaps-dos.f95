!*****************************************************************************
! Nombre      :: yaps-dos
! Descripcion :: Script para procesamiento de densidades de estado parciales.
!                De QuantumESPRESSO.
! Autor       :: Shigueru Nagata
!*****************************************************************************

PROGRAM DOS

    USE fermi
    USE files

    IMPLICIT NONE

    CHARACTER(LEN=27) :: ScfFile    ! SCF - FILE
    CHARACTER(LEN=200) :: DosFile    ! DOS - FILE
    REAL :: FermiEner               ! ENERGIA - FERMI
    INTEGER :: NumLines          ! NUMERO - LINEAS

    ScfFile = "examplefiles/BiFeO3.scf.out"
    DosFile = "examplefiles/BiFeO3.dos-proyec.pdos-atm-1(Fe1)-wfc-1(s)"

    CALL GetFermi(ScfFile,FermiEner)

    NumLines = NumberLines(TRIM(DosFile))

END PROGRAM DOS
