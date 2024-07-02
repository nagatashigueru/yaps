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
    CHARACTER(LEN=200) :: SearchLine ! PATRON - BUSQUEDA
    CHARACTER(LEN=200) :: LineFile
    REAL :: FermiEner               ! ENERGIA - FERMI
    INTEGER :: NumLines          ! NUMERO - LINEAS

    ScfFile = "examplefiles/BiFeO3.scf.out"
    DosFile = "examplefiles/BiFeO3.dos-proyec.pdos-atm-1(Fe1)-wfc-1(s)"
    SearchLine = "examplefiles/*\(Bi\)*"

    CALL GetFermi(ScfFile,FermiEner)
    CALL ListFiles(TRIM(SearchLine),LEN(TRIM(SearchLine)))

    OPEN(UNIT=25,FILE="FILES.txt",STATUS="OLD",ACTION="READ")
    READ(UNIT=25,FMT='(A200)') LineFile
    CLOSE(UNIT=25)
    
    NumLines = NumberLines(TRIM(LineFile),LEN(TRIM(LineFile)))
    WRITE(*,*) "Cantidad de valores de energía :: ",NumLines - 1

END PROGRAM DOS
