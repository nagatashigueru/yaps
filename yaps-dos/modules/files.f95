!*******************************************************************************
! NOMBRE      :: files
! AUTOR       :: Shigueru Nagata
! Fecha       :: Junio 2024
! Descripcion :: Modulo de funciones para trabajar con archivos.
! ******************************************************************************

MODULE files

    USE init
    USE error

    IMPLICIT NONE

    CONTAINS

    FUNCTION NumberLines(InputFile,SizeName) RESULT(CountLines)
        
        IMPLICIT NONE

        INTEGER, PARAMETER :: UnitInput = 23

        INTEGER :: SizeName
        INTEGER :: CountLines
        INTEGER :: ReadFlag
        INTEGER :: OError
        INTEGER :: RError

        CHARACTER(LEN=100), PARAMETER :: ReadFmt = '(a100)'

        CHARACTER(LEN=SizeName) :: InputFile
        CHARACTER(LEN=100) :: Line
        

        CountLines = 0
        ReadFlag = 0

        OPEN(UNIT=UnitInput,FILE=InputFile,IOSTAT=OError,STATUS="OLD",ACTION="READ")

        IF (OError .NE. 0) THEN
            WRITE(*,*) "Error al abrir :: ",InputFile
            STOP
        END IF

        DO WHILE (ReadFlag .NE. 1)
            READ(UNIT=UnitInput,FMT=ReadFmt,IOSTAT=RError) Line
            IF (RError .NE. 0) THEN
                ReadFlag = 1
            ELSE
                CountLines = CountLines + 1
            END IF
        END DO

        CLOSE(UNIT=UnitInput)

    END FUNCTION NumberLines

    SUBROUTINE ListFiles(SearchPatron,LongPatron)

        IMPLICIT NONE

        CHARACTER(LEN=2), PARAMETER :: cmd1 = "ls"
        CHARACTER(LEN=11), PARAMETER :: cmd2 = "> FILES.txt"
        CHARACTER(LEN=200) :: Command
        CHARACTER(LEN=100) :: Line
        INTEGER :: LongPatron
        INTEGER :: CountFile
        CHARACTER(LEN=LongPatron) :: SearchPatron

        Command = cmd1//" "//SearchPatron//" "//cmd2

        CALL EXECUTE_COMMAND_LINE(TRIM(Command))

        OPEN(UNIT=24,FILE="FILES.txt",STATUS="OLD",ACTION="READ")
        
        WRITE(*,*) ""
        WRITE(*,FMT='(A27)') "***************************"
        WRITE(*,FMT='(A27)') "*** LISTADO DE ARCHIVOS ***"
        WRITE(*,FMT='(A27)') "***************************"
        WRITE(*,*) ""
        WRITE(*,FMT='(A20,1X,A)') "PATRON USADO ::",SearchPatron
        WRITE(*,FMT='(A20,1X)') "ARCHIVOS HALLADOS ::"
        WRITE(*,*)""

        WRITE(*,FMT='(A4,2X,A1,1X,A)') "N°","|","RUTA / NOMBRE"
        WRITE(*,*) "---------------------"

        CountFile = 0

        DO
            READ(UNIT=24,FMT='(A100)',END=100) Line
            CountFile = CountFile + 1
            !WRITE(*,FMT='(I3.3,2X,A)') CountFile,TRIM(Line)
            WRITE(*,FMT='(I4.3,1X,A1,1X,A)') CountFile,'|',TRIM(Line)
        END DO

        WRITE(*,*) ""

        100 CLOSE(UNIT=24)


    END SUBROUTINE ListFiles

    SUBROUTINE TestExistence(TEFile,LenTEFile)
        
        IMPLICIT NONE

        INTEGER :: LenTEFile
        INTEGER :: TEStat
        INTEGER :: TEOption
        CHARACTER(LEN=LenTEFile) :: TEFile

        INTEGER, PARAMETER :: TEUnit=34

        OPEN(UNIT=TEUnit,IOSTAT=TEStat,FILE=TEFile,STATUS='OLD')

        IF (TEStat .EQ. 0) THEN
            WRITE(*,*)""
            WRITE(*,FMT='(A11,1X,A)') ADJUSTR("ARCHIVO ::"),TEFile
            WRITE(*,FMT='(A11,1X,A6)') ADJUSTR("ESTADO ::"),"EXISTE"
            WRITE(*,FMT='(A11)') ADJUSTR("ACCION ::")
            WRITE(*,FMT='(A11,1X,A15)') ADJUSTR("->"),"1 :: REEMPLAZAR"
            WRITE(*,FMT='(A11,1X,A21)') ADJUSTR("->"),"2 :: DETENER PROGRAMA"
            READ(*,*)TEOption

            IF (TEOption .EQ. 1) THEN
                CLOSE(UNIT=TEUnit,STATUS='DELETE')
            END IF
            IF (TEOption .EQ. 2) THEN
                CALL FileDuplicate(TRIM(TEFile),LEN(TRIM(TEFile)))
            END IF
        END IF

    END SUBROUTINE TestExistence

    FUNCTION PatronAtomo(Atomo,LongAtomo) RESULT(Patron)
        
        IMPLICIT NONE
 
        CHARACTER(LEN=3), PARAMETER :: RightPatron = '\)*'
        CHARACTER(LEN=3), PARAMETER :: LeftPatron = '*\('
 
        INTEGER :: LongAtomo
        CHARACTER(LEN=LongAtomo) :: Atomo

        CHARACTER(LEN=LongAtomo+6) :: Patron

        Patron = LeftPatron//Atomo//RightPatron
    END FUNCTION PatronAtomo

    FUNCTION PatronOrbital(Orbital,LongOrbital) RESULT(Patron)
    
        IMPLICIT NONE

        CHARACTER(LEN=3), PARAMETER :: RightPatron = "\)*"
        CHARACTER(LEN=3), PARAMETER :: LeftPatron = "*\("

        INTEGER :: LongOrbital
        CHARACTER(LEN=LongOrbital) :: Orbital

        CHARACTER(LEN=LongOrbital+6) :: Patron

        Patron = LeftPatron//Orbital//RightPatron
    END FUNCTION PatronOrbital

    FUNCTION PatronAtomoOrbital(Atomo,LongAtomo,Orbital,LongOrbital) RESULT(Patron)
    
        IMPLICIT NONE

        CHARACTER(LEN=3), PARAMETER :: RightPatron = "\)*"
        CHARACTER(LEN=3), PARAMETER :: LeftPatron = "*\("
        CHARACTER(LEN=2), PARAMETER :: CenterPatron = "\("

        INTEGER :: LongAtomo
        INTEGER :: LongOrbital
        CHARACTER(LEN=LongAtomo) :: Atomo
        CHARACTER(LEN=LongOrbital) :: Orbital
        CHARACTER(LEN=LongOrbital+LongAtomo) :: LoLa
        CHARACTER(LEN=LEN(LoLa)+11) :: Patron

        Patron = LeftPatron//Atomo//RightPatron//CenterPatron//Orbital//RightPatron
    END FUNCTION PatronAtomoOrbital

END MODULE files
