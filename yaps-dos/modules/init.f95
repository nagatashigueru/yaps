! ######################
! MODULO EN DESARROLLO
! ######################

MODULE init

    USE files

    IMPLICIT NONE

    CHARACTER(LEN=200) :: ScfInputFile
    CHARACTER(LEN=200) :: DosOutputFile
    CHARACTER(LEN=20) :: AtomoName
    CHARACTER(LEN=20) :: OrbitalName

    CHARACTER(LEN=15), DIMENSION(3), PARAMETER :: Patrones = [CHARACTER(LEN=15) :: 'ATOMO','ORBITAL','ATOMO Y ORBITAL']
    INTEGER :: PatronOption
    INTEGER :: OptionGnuplot

    INTEGER, PRIVATE :: IScfFlag

    LOGICAL, PRIVATE :: IScfExist


    
    CONTAINS

        SUBROUTINE Options()

            IMPLICIT NONE

            INTEGER :: Option

            WRITE(*,*) "¿QUE DESEA HACER?"
            WRITE(*,*) "1: AYUDA"
            WRITE(*,*) "2: INICIAR PROCESAMIENTO"
            READ(*,*) Option

            IF (Option .EQ. 1) THEN
                !CALL Ayuda
            END IF

            IF (Option .EQ. 2) THEN
                !CALL Procesamiento
            END IF
        END SUBROUTINE Options

        SUBROUTINE Interactive()
        
            IMPLICIT NONE
            
            IScfFlag = 0

            WRITE(*,*) "-------------------------------"
            WRITE(*,*) "| INICIALIZACION DE PARAMETROS |"
            WRITE(*,*) "-------------------------------"
            DO WHILE(IScfFlag .NE. 1)
                WRITE(*,*) "Nombre del archivo SCF"
                READ(*,*) ScfInputFile
                IScfExist = ScfExistence(TRIM(ScfInputFile),LEN(TRIM(ScfInputFile)))

                IF (IScfExist) THEN
                    IScfFlag = 1
                END IF
            END DO
            WRITE(*,*) "NOMBRE DEL ARCHIVO DE SALIDA"
            READ(*,*) DosOutputFile
            WRITE(*,*) "TIPO DE PATRON DE BUSQUEDA"
            WRITE(*,*) "1 :: POR ATOMO"
            WRITE(*,*) "2 :: POR ORBITAL"
            WRITE(*,*) "3 :: POR ATOMO Y AORBITAL"
            WRITE(*,*) "ESCRIBA EL NUMERO DE OPCION"
            READ(*,*) PatronOption

            IF (PatronOption .EQ. 1) THEN
                CALL ListAtomos(TRIM(ScfInputFile),LEN(TRIM(ScfInputFile)))
                WRITE(*,*) "ESCRIBA EL NOMBRE DEL ATOMO"
                READ(*,*) AtomoName
            END IF

            IF (PatronOption .EQ. 2) THEN
                WRITE(*,*) "ESCRIBA EL NOMBRE DEL ORBITAL"
                READ(*,*) OrbitalName
            END IF

            IF (PatronOption .EQ. 3) THEN
                CALL ListAtomos(TRIM(ScfInputFile),LEN(TRIM(ScfInputFile)))
                WRITE(*,*) "ESCRIBA EL NOMBRE DEL ATOMO"
                READ(*,*) AtomoName
                WRITE(*,*) "ESCRIBA EL NOMBRE DEL ORBITAL"
                READ(*,*) OrbitalName
            END IF

            WRITE(*,*) "¿DESEA UN GRAFICO CON GNUPLOT?"
            WRITE(*,*) "1 :: SI"
            WRITE(*,*) "2 :: NO"
            WRITE(*,*) "ESCRIBA EL NUMERO DE OPCION"
            READ(*,*) OptionGnuplot

            WRITE(*,*) "---------------------"
            WRITE(*,*) "RESUMEN DE PARAMETROS"
            WRITE(*,*) "---------------------"
            WRITE(*,*) " "
            WRITE(*,*) "PARAMETRO | VALOR"
            WRITE(*,*) "-----------------"
            WRITE(*,*) "ARCHIVO SCF ::",ScfInputFile
            WRITE(*,*) "ARCHIVO DE SALIDA ::",DosOutputFile
            WRITE(*,*) "TIPO DE PATRON ::",Patrones(PatronOption)

            IF (PatronOption .EQ. 1) THEN
                WRITE(*,*) "ATOMO ::",AtomoName
            END IF
            IF (PatronOption .EQ. 2) THEN
                WRITE(*,*) "ORBITAL ::",OrbitalName
            END IF
            IF (PatronOption .EQ. 3) THEN
                WRITE(*,*) "ATOMO ::",AtomoName
                WRITE(*,*) "ORBITAL ::",OrbitalName
            END IF

            IF (OptionGnuplot .EQ. 1) THEN
                WRITE(*,*) "GRAFICO GNUPLOT :: SI"
            END IF
            IF (OptionGnuplot .EQ. 2) THEN
                WRITE(*,*) "GRAFICO GNUPLOT :: NO"
            END IF


        END SUBROUTINE Interactive
END MODULE init
