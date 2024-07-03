! ************************************************************************
! NAME        :: data.f95
! AUTOR       :: Shigueru Nagata
! Descripcion :: Modulo para trabajar con los datos de densidad de estado.
! ************************************************************************

USE files

MODULE data

    IMPLICIT NONE

    CONTAINS

        SUBROUTINE GetData(DataArray,DataRows,DataColumns)
            
            IMPLICIT NONE
            
            INTEGER :: DataRows
            INTEGER :: DataColumns
            REAL, DIMENSION(DataRows,DataColumns), INTENT(OUT) :: DataArray

            CHARACTER(LEN=9), PARAMETER :: ListFiles="FILES.txt"

            CHARACTER(LEN=200) :: NameFile
            CHARACTER(LEN=200) :: TrashLine

            NumberFiles = NumberLines(ListFiles,LEN(ListFiles))

            OPEN(UNIT=23,FILE=ListFiles,STATUS="OLD",ACTION="READ")
            DO i=1,NumberFiles
                READ(UNIT=23)NameFile
                OPEN(UNIT=24,FILE=TRIM(NameFile),STATUS="OLD",ACTION="READ")
                READ(UNIT=24,FORMAT='(A200)')TrashLine
                DO j=1,DataRows
                    READ(UNIT=24,FORMAT='(F8.3,2X,)')
                END DO
                READ(UNIT=24,FORMAT='(A200)')TrashLine
                CLOSE(UNIT=24)
            END DO

            CLOSE(UNIT=23)
        END SUBROUTINE GetData
END MODULE data
