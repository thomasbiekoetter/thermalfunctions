module thermalfunctions__pyjspline

  use thermalfunctions__kinds, only : wp
  use thermalfunctions__jspline, only : Jb_spline
  use thermalfunctions__jspline, only : Jf_spline
  use thermalfunctions__jspline, only : dJb_spline
  use thermalfunctions__jspline, only : dJf_spline
  use thermalfunctions__jspline, only : d2Jb_spline
  use thermalfunctions__jspline, only : d2Jf_spline
  use iso_c_binding

  implicit none

  private

  public :: Jb_spline_c
  public :: Jf_spline_c
  public :: dJb_spline_c
  public :: dJf_spline_c
  public :: d2Jb_spline_c
  public :: d2Jf_spline_c
  public :: Jb_spline_arr_c
  public :: dJb_spline_arr_c
  public :: d2Jb_spline_arr_c
  public :: Jf_spline_arr_c
  public :: dJf_spline_arr_c
  public :: d2Jf_spline_arr_c

contains

  subroutine Jb_spline_c(ysq, res) bind(C, name="Jb_spline_c")

    real(c_double), value, intent(in) :: ysq
    real(c_double), intent(out) :: res

    real(wp) :: ysq_f
    real(wp) :: res_f

    ysq_f = real(ysq, wp)
    res_f = Jb_spline(ysq_f)
    res = real(res_f, c_double)

  end subroutine Jb_spline_c

  subroutine dJb_spline_c(ysq, res) bind(C, name="dJb_spline_c")

    real(c_double), value, intent(in) :: ysq
    real(c_double), intent(out) :: res

    real(wp) :: ysq_f
    real(wp) :: res_f

    ysq_f = real(ysq, wp)
    res_f = dJb_spline(ysq_f)
    res = real(res_f, c_double)

  end subroutine dJb_spline_c

  subroutine d2Jb_spline_c(ysq, res) bind(C, name="d2Jb_spline_c")

    real(c_double), value, intent(in) :: ysq
    real(c_double), intent(out) :: res

    real(wp) :: ysq_f
    real(wp) :: res_f

    ysq_f = real(ysq, wp)
    res_f = d2Jb_spline(ysq_f)
    res = real(res_f, c_double)

  end subroutine d2Jb_spline_c

  subroutine Jf_spline_c(ysq, res) bind(C, name="Jf_spline_c")

    real(c_double), value, intent(in) :: ysq
    real(c_double), intent(out) :: res

    real(wp) :: ysq_f
    real(wp) :: res_f

    ysq_f = real(ysq, wp)
    res_f = Jf_spline(ysq_f)
    res = real(res_f, c_double)

  end subroutine Jf_spline_c

  subroutine dJf_spline_c(ysq, res) bind(C, name="dJf_spline_c")

    real(c_double), value, intent(in) :: ysq
    real(c_double), intent(out) :: res

    real(wp) :: ysq_f
    real(wp) :: res_f

    ysq_f = real(ysq, wp)
    res_f = dJf_spline(ysq_f)
    res = real(res_f, c_double)

  end subroutine dJf_spline_c

  subroutine d2Jf_spline_c(ysq, res) bind(C, name="d2Jf_spline_c")

    real(c_double), value, intent(in) :: ysq
    real(c_double), intent(out) :: res

    real(wp) :: ysq_f
    real(wp) :: res_f

    ysq_f = real(ysq, wp)
    res_f = d2Jf_spline(ysq_f)
    res = real(res_f, c_double)

  end subroutine d2Jf_spline_c

  subroutine Jb_spline_arr_c(n, ysq, res) bind(C, name="Jb_spline_arr_c")

    integer(c_int), value, intent(in) :: n
    real(c_double), intent(in) :: ysq(n)
    real(c_double), intent(out) :: res(n)

    integer :: i

    do i = 1, n
      res(i) = real(Jb_spline(real(ysq(i), wp)), c_double)
    end do

  end subroutine Jb_spline_arr_c

  subroutine dJb_spline_arr_c(n, ysq, res) bind(C, name="dJb_spline_arr_c")

    integer(c_int), value, intent(in) :: n
    real(c_double), intent(in) :: ysq(n)
    real(c_double), intent(out) :: res(n)

    integer :: i

    do i = 1, n
      res(i) = real(dJb_spline(real(ysq(i), wp)), c_double)
    end do

  end subroutine dJb_spline_arr_c

  subroutine d2Jb_spline_arr_c(n, ysq, res) bind(C, name="d2Jb_spline_arr_c")

    integer(c_int), value, intent(in) :: n
    real(c_double), intent(in) :: ysq(n)
    real(c_double), intent(out) :: res(n)

    integer :: i

    do i = 1, n
      res(i) = real(d2Jb_spline(real(ysq(i), wp)), c_double)
    end do

  end subroutine d2Jb_spline_arr_c

  subroutine Jf_spline_arr_c(n, ysq, res) bind(C, name="Jf_spline_arr_c")

    integer(c_int), value, intent(in) :: n
    real(c_double), intent(in) :: ysq(n)
    real(c_double), intent(out) :: res(n)

    integer :: i

    do i = 1, n
      res(i) = real(Jf_spline(real(ysq(i), wp)), c_double)
    end do

  end subroutine Jf_spline_arr_c

  subroutine dJf_spline_arr_c(n, ysq, res) bind(C, name="dJf_spline_arr_c")

    integer(c_int), value, intent(in) :: n
    real(c_double), intent(in) :: ysq(n)
    real(c_double), intent(out) :: res(n)

    integer :: i

    do i = 1, n
      res(i) = real(dJf_spline(real(ysq(i), wp)), c_double)
    end do

  end subroutine dJf_spline_arr_c

  subroutine d2Jf_spline_arr_c(n, ysq, res) bind(C, name="d2Jf_spline_arr_c")

    integer(c_int), value, intent(in) :: n
    real(c_double), intent(in) :: ysq(n)
    real(c_double), intent(out) :: res(n)

    integer :: i

    do i = 1, n
      res(i) = real(d2Jf_spline(real(ysq(i), wp)), c_double)
    end do

  end subroutine d2Jf_spline_arr_c

end module thermalfunctions__pyjspline
