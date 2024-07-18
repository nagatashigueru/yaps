MODULE error

    IMPLICIT NONE

    CONTAINS

        SUBROUTINE FileDuplicate(FDFileName,FDLongFile)
        
            IMPLICIT NONE

            INTEGER :: FDLongFile
            CHARACTER(LEN=FDLongFile) :: FDFileName

            WRITE(*,*) "ERROR DE DUPLICACION DE ARCHIVO"
            WRITE(*,*) "ARCHIVO ::",FDFileName
            WRITE(*,*) "PROGRAMA YAPS-DOS TERMINADO"
            STOP

        END SUBROUTINE FileDuplicate
END MODULE error
