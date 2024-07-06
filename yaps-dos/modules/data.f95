! ************************************************************************
! NAME        :: data.f95
! AUTOR       :: Shigueru Nagata
! Descripcion :: Modulo para trabajar con los datos de densidad de estado.
! ************************************************************************

MODULE data

    USE files

    IMPLICIT NONE

    CONTAINS

        SUBROUTINE GetData(DataArray,DataRows,DataColumns)
            
            IMPLICIT NONE

            INTEGER, PARAMETER :: UnitData=29
            INTEGER, PARAMETER :: UnitValue=30
            
            INTEGER :: DataRows
            INTEGER :: DataColumns
            INTEGER :: NumberFiles
            INTEGER :: j
            INTEGER :: RError
            INTEGER :: ReadFlag

            REAL, DIMENSION(DataRows,DataColumns), INTENT(OUT) :: DataArray
            REAL :: Energy
            REAL :: Up
            REAL :: Down

            CHARACTER(LEN=9), PARAMETER :: ListFiles="FILES.txt"

            CHARACTER(LEN=200) :: NameFile
            CHARACTER(LEN=200) :: TrashLine

            NumberFiles = NumberLines(ListFiles,LEN(ListFiles))

            OPEN(UNIT=UnitData,FILE=ListFiles,STATUS="OLD",ACTION="READ")
            ReadFlag = 0 
            DO WHILE (ReadFlag .NE. 1)
                READ(UNIT=UnitData,FMT='(A200)',IOSTAT=RError)NameFile
                IF (RError .NE. 0) THEN
                    ReadFlag = 1
                ELSE
                    OPEN(UNIT=UnitValue,FILE=TRIM(NameFile),STATUS="OLD",ACTION="READ")
                    READ(UNIT=UnitValue,FMT='(A200)')TrashLine
                    DO j=1,DataRows
                        READ(UNIT=UnitValue,FMT='(1X,F7.3,2X,E9.3E2,2X,E9.3E2)')Energy,Up,Down
                        DataArray(j,1) = Energy
                        DataArray(j,2) = DataArray(j,2) + Up
                        DataArray(j,3) = DataArray(j,3) + Down
                    END DO
                    READ(UNIT=UnitValue,FMT='(A200)')TrashLine
                    CLOSE(UNIT=UnitValue)
                END IF
            END DO

            CLOSE(UNIT=UnitData)
        END SUBROUTINE GetData

        SUBROUTINE WriteData(MatrixData,MatrixRows,MatrixColumns,OutputFile,LenOut)

            IMPLICIT NONE

            INTEGER, PARAMETER :: UnitOut=33
            INTEGER :: row

            INTEGER :: MatrixRows
            INTEGER :: MatrixColumns
            REAL, DIMENSION(MatrixRows,MatrixColumns) :: MatrixData
            
            INTEGER :: LenOut
            CHARACTER(LEN=LenOut) :: OutputFile

            CALL TestExistence(OutputFile,LEN(OutputFile))

            OPEN(UNIT=UnitOut,FILE=OutputFile,STATUS='NEW',ACTION='WRITE')

            DO row=1,MatrixRows
                WRITE(UNIT=UnitOut,FMT='(F7.3,1X,E9.3E2,1X,E9.3E2)')MatrixData(row,1),MatrixData(row,2),MatrixData(row,3)
            END DO

            CLOSE(UNIT=UnitOut)

        END SUBROUTINE WriteData
            
END MODULE data
