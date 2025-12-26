program main

  use thermalfunctions__kinds, only : wp
  use thermalfunctions__jexact, only: Jb
  use thermalfunctions__jexact, only: Jf
  use thermalfunctions__jspline, only: Jb_spline
  use thermalfunctions__jspline, only: Jf_spline

  implicit none

  integer :: i
  real(wp) :: x

  write(*,*)
  write(*,*) "Bosons:"
  write(*,*)
  do i = -10, 10, 2
    x = real(i, wp)
    write(*,*) "x          =", x
    write(*,*) "Jb_exact   =", Jb(x)
    write(*,*) "Jb_spline  =", Jb_spline(x)
    write(*,*) "Difference =", Jb(x) - Jb_spline(x)
    write(*,*) "------------------------"
  end do

  write(*,*)
  write(*,*) "Fermions:"
  write(*,*)
  do i = 0, 10, 2
    x = real(i, wp)
    write(*,*) "x          =", x
    write(*,*) "Jf_exact   =", Jf(x)
    write(*,*) "Jf_spline  =", Jf_spline(x)
    write(*,*) "Difference =", Jf(x) - Jf_spline(x)
    write(*,*) "------------------------"
  end do

end program main
