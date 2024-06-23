!*****************************************************************************
! Nombre      :: yaps-dos
! Descripcion :: Script para procesamiento de densidades de estado parciales.
! Autor       :: Shigueru Nagata
!*****************************************************************************

program DOS

    use fermi

    implicit none

    character(len=27) :: ScfFile
    real :: FermiEner

    ScfFile = "examplefiles/BiFeO3.scf.out"

    call GetFermi(ScfFile,FermiEner)

end program DOS
