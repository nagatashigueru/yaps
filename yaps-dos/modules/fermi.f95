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
    ! Line    :: Recibe cada una de las lineas leidas del archivo para luego   |
    !            ser procesada                                                 |
    ! Patron  :: Patron de frase para identificar la linea que contiene la     |
    !            energia de fermi                                              |
    ! Flag    :: Flag que indica cuando se hallo la energia de fermi y detiene |
    !            el bucle                                                      |
    ! Find    :: Recibe el valor de la funcion index para luego ser procesado  |
    ! IOError :: Recibe el estado de abrir el archivo de entrada               |
    ! -------------------------------------------------------------------------|

    integer, parameter, private :: UnitInput = 23

    character(len=19), parameter, private :: Patron = "the Fermi energy is"
    character(len=11), parameter, private :: FmtRead = "(24X,F11.4)"

    character(len=100), private :: Line
    
    integer, private :: Flag 
    integer, private :: Find
    integer, private :: IOError

    ! *****************
    ! ... subrutina ...
    ! *****************

    contains

        subroutine GetFermi(FileInput, FermiEnergy)
           
            character(len=27), intent (in) :: FileInput

            real, intent (out) :: FermiEnergy

            Flag = 0

            open(unit=UnitInput, file=FileInput, iostat=IOError, &
                 status="old", action="read")
            if (IOError .ne. 0) then
                write(*,*) "Error al abrir :: ",FileInput
                stop
            end if

            do while(Flag .ne. 1)
                read(unit=UnitInput,fmt='(a100)') Line
                Find = index(Line,Patron)
                if (Find .ne. 0 .and. Flag .ne. 1) then
                    read(Line,fmt=FmtRead) FermiEnergy
                    Flag = 1
                end if
            end do

            write(*,*) "*******************************************************"
            write(*,*) "| Energia - Fermi                                     |"
            write(*,*) "*******************************************************"
            write(*,fmt='(A17,1X,A27)') "Archivo leído :: ",FileInput
            write(*,fmt='(A20,F11.4)') "Energia de Fermi :: ",FermiEnergy

            close(unit=UnitInput)

        end subroutine GetFermi
end module fermi
