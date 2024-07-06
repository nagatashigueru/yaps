!*******************************************************************************
! NOMBRE      :: files
! AUTOR       :: Shigueru Nagata
! Fecha       :: Junio 2024
! Descripcion :: Modulo de funciones para trabajar con archivos.
! ******************************************************************************

MODULE files
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
        
        WRITE(*,*) "***************************"
        WRITE(*,*) "*** LISTADO DE ARCHIVOS ***"
        WRITE(*,*) "***************************"
        WRITE(*,*) "PATRON USADO :: ",SearchPatron
        WRITE(*,*) "ARCHIVOS HALLADOS ::"

        CountFile = 0

        DO
            READ(UNIT=24,FMT='(A100)',END=100) Line
            CountFile = CountFile + 1
            WRITE(*,FMT='(I3.3,2X,A)') CountFile,TRIM(Line)
        END DO

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
            WRITE(*,*)"ARCHIVO :: ",TEFile
            WRITE(*,*)"ESTADO :: EXISTE"
            WRITE(*,*)"ACCION :: 1 (BORRAR)"
            READ(*,*)TEOption

            IF (TEOption .EQ. 1) THEN
                CLOSE(UNIT=TEUnit,STATUS='DELETE')
            END IF
        END IF

    END SUBROUTINE TestExistence
END MODULE files
