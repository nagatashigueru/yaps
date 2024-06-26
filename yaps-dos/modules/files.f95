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

    SUBROUTINE ListFiles(PatronFile)

        IMPLICIT NONE

        CHARACTER(LEN=3), PARAMETER :: cmd1 = "ls "
        CHARACTER(LEN=14), PARAMETER :: cmd2 = "> ListFile.txt"
        CHARACTER(LEN=20) :: PatronFile


    END SUBROUTINE ListFiles
END MODULE files
