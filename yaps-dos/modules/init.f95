! ######################
! MODULO EN DESARROLLO
! ######################

MODULE init

    IMPLICIT NONE
    
    CONTAINS

        SUBROUTINE Options

            IMPLICIT NONE

            INTEGER :: Option

            WRITE(*,*) "¿QUE DESEA HACER?"
            WRITE(*,*) "1: AYUDA"
            WRITE(*,*) "2: INICIAR PROCESAMIENTO"
            READ(*,*) Option

            IF (Option .EQ. 1) THEN
                CALL Ayuda
            END IF

            IF (Option .EQ. 2) THEN
                CALL Procesamiento
            END IF
        END SUBROUTINE Options
END MODULE init
