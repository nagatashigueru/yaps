MODULE saludo

    IMPLICIT NONE

    CONTAINS

    SUBROUTINE Greeting()

        IMPLICIT NONE
        WRITE(*,*) " "
        WRITE(*,*) "             WELCOME TO          "
        WRITE(*,*) " "
        WRITE(*,*) "██    ██  █████  ██████  ███████ "
        WRITE(*,*) " ██  ██  ██   ██ ██   ██ ██      "
        WRITE(*,*) "  ████   ███████ ██████  ███████ "
        WRITE(*,*) "   ██    ██   ██ ██           ██ "
        WRITE(*,*) "   ██    ██   ██ ██      ███████ "
        WRITE(*,*) " "
        WRITE(*,*) "            MODULE          "
        WRITE(*,*) " ___________________________"
        WRITE(*,*) "|                           |"
        WRITE(*,*) "| ██████╗  ██████╗ ███████╗ |"
        WRITE(*,*) "| ██╔══██╗██╔═══██╗██╔════╝ |"
        WRITE(*,*) "| ██║  ██║██║   ██║███████╗ |"
        WRITE(*,*) "| ██║  ██║██║   ██║╚════██║ |"
        WRITE(*,*) "| ██████╔╝╚██████╔╝███████║ |"
        WRITE(*,*) "| ╚═════╝  ╚═════╝ ╚══════╝ |"
        WRITE(*,*) "|___________________________|"
    END SUBROUTINE Greeting

    SUBROUTINE Separador()
        
        IMPLICIT NONE

        INTEGER :: Cols
        CHARACTER(LEN=14), PARAMETER :: Comando="sh columnas.sh"

        OPEN(UNIT=22,FILE='columnas.sh',STATUS='NEW',ACTION='WRITE')
        WRITE(UNIT=22,FMT='(A)') "#!/bin/bash"
        WRITE(UNIT=22,FMT='(A)') "columnas=$(tput cols)"
        WRITE(UNIT=22,FMT='(A)') 'echo "$columnas" > columnas.txt'
        CLOSE(UNIT=22)

        CALL EXECUTE_COMMAND_LINE(Comando)

        OPEN(UNIT=23,FILE='columnas.txt',STATUS='OLD',ACTION='READ')
        READ(UNIT=23,FMT='(I4)') Cols
        CLOSE(UNIT=23,STATUS='DELETE')

        WRITE(*,FMT='(A)') REPEAT("-",Cols)

        OPEN(UNIT=99,FILE='columnas.sh',STATUS='OLD')
 
        CLOSE(UNIT=99,STATUS='DELETE')
    END SUBROUTINE Separador

END MODULE saludo
