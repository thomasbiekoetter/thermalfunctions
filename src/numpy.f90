module thermalfunctions__numpy

  use thermalfunctions__kinds, only : wp

  implicit none

  private

  public :: linspace
  public :: logspace

contains

  pure function linspace(a, b, num) result(y)

    real(wp), intent(in) :: a
    real(wp), intent(in) :: b
    integer, intent(in) :: num
    real(wp), dimension(num) :: y

    integer :: i
    real(wp) :: step

    step = (b - a) / real(num - 1, wp)
    y(1) = a
    do i=2,num
      y(i) = a + (i - 1) * step
    end do

  end function linspace

  pure function logspace(a, b, num) result(y)

    real(wp), intent(in) :: a
    real(wp), intent(in) :: b
    integer, intent(in) :: num
    real(wp), dimension(num) :: y

    real(wp) :: log_start, log_stop

    log_start = log10(a)
    log_stop = log10(b)

    y = 10.0e0_wp**linspace(log_start, log_stop, num)

  end function logspace

end module thermalfunctions__numpy
