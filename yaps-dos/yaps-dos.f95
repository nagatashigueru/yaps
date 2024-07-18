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

    CHARACTER(LEN=200) :: SearchLine ! PATRON - BUSQUEDA
    CHARACTER(LEN=200) :: LineFile
    CHARACTER(LEN=100) :: OutFile
    REAL :: FermiEner               ! ENERGIA - FERMI
    INTEGER :: NumLines          ! NUMERO - LINEAS
    INTEGER :: Rows
    INTEGER :: Columns
    REAL, DIMENSION(:,:), ALLOCATABLE :: ValueArray

    CALL Greeting()
    CALL Interactive()

    IF (PatronOption .EQ. 1) THEN
        SearchLine = PatronAtomo(TRIM(AtomoName),LEN(TRIM(AtomoName)))
    END IF
    IF (PatronOption .EQ. 2) THEN
        SearchLine = PatronOrbital(TRIM(OrbitalName),LEN(TRIM(OrbitalName)))
    END IF
    IF (PatronOption .EQ. 3) THEN
        SearchLine = PatronAtomoOrbital(TRIM(AtomoName),LEN(TRIM(AtomoName)),TRIM(OrbitalName),LEN(TRIM(OrbitalName)))
    END IF

    CALL GetFermi(TRIM(ScfInputFile),LEN(TRIM(ScfInputFile)),FermiEner)
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
    CALL WriteData(ValueArray,Rows,Columns,TRIM(DosOutputFile),LEN(TRIM(DosOutputFile)))

    IF (OptionGnuplot .EQ. 1) THEN
        CALL WriteGnuplot(TRIM(AtomoName),LEN(TRIM(AtomoName)),TRIM(OrbitalName),LEN(TRIM(OrbitalName)))
    END IF

END PROGRAM DOS
