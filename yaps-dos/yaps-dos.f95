!*****************************************************************************
! Nombre      :: yaps-dos
! Descripcion :: Script para procesamiento de densidades de estado parciales.
!                De QuantumESPRESSO.
! Autor       :: Shigueru Nagata
!*****************************************************************************

PROGRAM DOS

    USE fermi
    USE files
    USE data
    USE saludo
    USE init

    IMPLICIT NONE

    character(len=100) :: patroncito
    character(len=20) :: ele

    CHARACTER(LEN=27) :: ScfFile    ! SCF - FILE
    CHARACTER(LEN=200) :: SearchLine ! PATRON - BUSQUEDA
    CHARACTER(LEN=200) :: LineFile
    CHARACTER(LEN=100) :: OutFile
    REAL :: FermiEner               ! ENERGIA - FERMI
    INTEGER :: NumLines          ! NUMERO - LINEAS
    INTEGER :: Rows
    INTEGER :: Columns
    REAL, DIMENSION(:,:), ALLOCATABLE :: ValueArray

    ScfFile = "examplefiles/BiFeO3.scf.out"
    SearchLine = "examplefiles/*\(Bi\)*"
    OutFile = "DOS.txt"

    CALL Greeting()

    CALL Interactive()

    CALL GetFermi(TRIM(ScfFile),LEN(TRIM(ScfFile)),FermiEner)
    CALL ListFiles(TRIM(SearchLine),LEN(TRIM(SearchLine)))

    OPEN(UNIT=25,FILE="FILES.txt",STATUS="OLD",ACTION="READ")
    READ(UNIT=25,FMT='(A200)') LineFile
    CLOSE(UNIT=25)
    
    NumLines = NumberLines(TRIM(LineFile),LEN(TRIM(LineFile)))

    Rows = NumLines - 2
    Columns = 3

    ALLOCATE(ValueArray(Rows,Columns))
    ValueArray(:,:) = 0.0
    CALL GetData(ValueArray,Rows,Columns)
    CALL WriteData(ValueArray,Rows,Columns,TRIM(OutFile),LEN(TRIM(OutFile)))

    ele = 'Babebibobu'
    patroncito = PatronAtomoOrbital(trim(ele),len(trim(ele)),trim(ele),len(trim(ele))) 
    write(*,*) patroncito

END PROGRAM DOS
