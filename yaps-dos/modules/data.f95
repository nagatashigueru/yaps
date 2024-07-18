! ************************************************************************
! NAME        :: data.f95
! AUTOR       :: Shigueru Nagata
! Descripcion :: Modulo para trabajar con los datos de densidad de estado.
! ************************************************************************

MODULE data

    USE files
    USE init

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
                        DataArray(j,3) = DataArray(j,3) - Down
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
                WRITE(UNIT=UnitOut,FMT='(F7.3,1X,E9.3E2,1X,E10.3E2)')MatrixData(row,1),MatrixData(row,2),MatrixData(row,3)
            END DO

            CLOSE(UNIT=UnitOut)

        END SUBROUTINE WriteData

        SUBROUTINE WriteGnuplot(Atomo,LongAtomo,Orbital,LongOrbital)
        
            IMPLICIT NONE

            INTEGER :: LongAtomo
            INTEGER :: LongOrbital

            CHARACTER(LEN=LongAtomo) :: Atomo
            CHARACTER(LEN=LongOrbital) :: Orbital

            CHARACTER(LEN=4), PARAMETER :: BaseName= "DOS-"
            CHARACTER(LEN=8), PARAMETER :: BaseExtension = ".gnuplot"
            CHARACTER(LEN=1), PARAMETER :: Separator = "-"
            CHARACTER(:), ALLOCATABLE :: GnuplotFile
            
            INTEGER :: LongName
            INTEGER,  PARAMETER :: UnitDos = 55

            IF (PatronOption .EQ. 1) THEN
                LongName = LEN(BaseName) + LEN(BaseExtension) + LEN(Atomo)
                ALLOCATE(CHARACTER(LEN=LongName) :: GnuplotFile)
                GnuplotFile = BaseName//Atomo//BaseExtension
            END IF
            IF (PatronOption .EQ. 2) THEN
                LongName = LEN(BaseName) + LEN(BaseExtension) + LEN(Orbital)
                ALLOCATE(CHARACTER(LEN=LongName) :: GnuplotFile)
                GnuplotFile = BaseName//Orbital//BaseExtension
            END IF
            IF (PatronOption .EQ. 3) THEN
                LongName = LEN(BaseName) + LEN(BaseExtension) + LEN(Separator) + LEN(Atomo) + LEN(Orbital)
                ALLOCATE(CHARACTER(LEN=LongName) :: GnuplotFile)
                GnuplotFile = BaseName//Atomo//Separator//Orbital//BaseExtension
            END IF

            CALL TestExistence(GnuplotFile,LEN(GnuplotFile))

            OPEN(UNIT=UnitDos,FILE=GnuplotFile,STATUS='NEW',ACTION='WRITE')

            IF (PatronOption .EQ. 1) THEN
                WRITE(UNIT=UnitDos,FMT='(A)') "set title '"//BaseName//Atomo//"'"
            END IF
            IF (PatronOption .EQ. 2) THEN
                WRITE(UNIT=UnitDos,FMT='(A)') "set title '"//BaseName//Orbital//"'"
            END IF
            IF (PatronOption .EQ. 3) THEN
                WRITE(UNIT=UnitDos,FMT='(A)') "set title '"//BaseName//Atomo//Separator//Orbital//"'"
            END IF

            WRITE(UNIT=UnitDos,FMT='(A)') "set style line 6 lt 6 lw 2.0 lc rgb 'blue'"
            WRITE(UNIT=UnitDos,FMT='(A)') "set xlabel 'Energía'"
            WRITE(UNIT=UnitDos,FMT='(A)') "set ylabel 'Densidad de Estados'"
            WRITE(UNIT=UnitDos,FMT='(A)') "plot '"//TRIM(DosOutputFile)//"' u 1:2 w lines ls 6"
            

            CLOSE(UNIT=UnitDos)

            WRITE(*,*) "SE CREO EL ARCHIVO :: ",GnuplotFile
            WRITE(*,*) "PARA VISUALIZAR EL GRAFICO EJECUTE ::"
            WRITE(*,*) "gnuplot -p ",GnuplotFile
            
        END SUBROUTINE WriteGnuplot   
END MODULE data
