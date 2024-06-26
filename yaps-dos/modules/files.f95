!*******************************************************************************
! NOMBRE      :: files
! AUTOR       :: Shigueru Nagata
! Fecha       :: Junio 2024
! Descripcion :: Modulo de funciones para trabajar con archivos.
! ******************************************************************************

MODULE files
    IMPLICIT NONE

    CONTAINS

    FUNCTION NumberLines(InputFile) RESULT(CountLines)
        
        IMPLICIT NONE

        INTEGER, PARAMETER :: UnitInput = 23

        CHARACTER(LEN=100), PARAMETER :: ReadFmt = '(a100)'

        CHARACTER(LEN=200) :: InputFile
        CHARACTER(LEN=100) :: Line

        INTEGER :: CountLines
        INTEGER :: ReadFlag
        INTEGER :: OError
        INTEGER :: RError

        CountLines = 0
        ReadFlag = 0

        OPEN(UNIT=UnitInput,FILE=TRIM(InputFile),IOSTAT=OError,STATUS="OLD",ACTION="READ")

        IF (OError .NE. 0) THEN
            WRITE(*,*) "Error al abrir :: ",InputFile
            STOP
        END IF

        DO WHILE (ReadFlag .NE. 1)
            READ(UNIT=UnitInput,FMT=ReadFmt,IOSTAT=RError) Line
            IF (RError .NE. 0) THEN
                ReadFlag = 1
            END IF
            CountLines = CountLines + 1
        END DO

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
END MODULE files
