! ****************************************************************************|
! Nombre      :: fermi                                                        |
! Author      :: Shigueru Nagata                                              |
! Fecha       :: Junio 2024                                                   |
! Descripcion :: Modulo que contiene la subroutina para obtener la energia de |
!                fermi, desde el archivo de salida (.out) de QuantumESPRESSO  |
! ****************************************************************************|
module fermi
    implicit none

    ! -------------------------------------------------------------------------|
    ! ~~~~~~~~~~~~~~~~~~~~~~~~ variables - parameters ~~~~~~~~~~~~~~~~~~~~~~~~~|
    ! -------------------------------------------------------------------------|
    ! Line   :: Recibe cada una de las lineas leidas del archivo para luego    |
    !           ser procesada                                                  |
    ! Patron :: Patron de frase para identificar la linea que contiene la      |
    !           energia de fermi                                               |
    ! Flag   :: Flag que indica cuando se hallo la energia de fermi y detiene  |
    !           el bucle                                                       |
    ! Find   :: Recibe el valor de la funcion index para luego ser procesado   |
    ! -------------------------------------------------------------------------|

    integer, parameter, private :: UnitInput = 23

    character(len=19), parameter, private :: Patron = "the Fermi energy is"
    character(len=), parameter, private :: FmtRead = "(24X,F11.4)"

    character(len=100), private :: Line
    
    integer, private :: Flag 
    integer, private :: Find
    integer, private :: IOError

    ! *****************
    ! ... subrutina ...
    ! *****************

    contains

        subroutine fermi(FileInput, FermiEnergy)
           
            implicit none

            character(len=50), intent (in) :: FileInput

            real, intent (out) :: FermiEnergy

            Flag = 0

            do while(Flag .ne. 1)
                read(unit=UnitInput,file=FileInput,status="old") Line
                Find = index(Line,Patron)
                if (Find .ne. 0 and Flag .ne. 1) then
                    read(Line,fmt=FmtRead) FermiEnergy
                    Flag = 1
                end if
            end do

            write(*,*) "-------------------------------------------------------"
            write(*,*) "| [X] Energia de Fermi                                |"
            write(*,*) "-------------------------------------------------------"
            write(*,*) "Archivo leído :: ",FileInput
            write(*,*) "Energia de Fermi :: ",FermiEnergy

        end subroutine fermi
end module fermi
