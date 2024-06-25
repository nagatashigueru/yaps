!*****************************************************************************
! Nombre      :: yaps-dos
! Descripcion :: Script para procesamiento de densidades de estado parciales.
!                De QuantumESPRESSO.
! Autor       :: Shigueru Nagata
!*****************************************************************************

program DOS

    use fermi

    implicit none

    character(len=27) :: ScfFile    ! Archivo de entrada
    real :: FermiEner               ! Energia de fermi

    ScfFile = "examplefiles/BiFeO3.scf.out"

    call GetFermi(ScfFile,FermiEner)

end program DOS
