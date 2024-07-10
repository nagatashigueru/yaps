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

END MODULE saludo
