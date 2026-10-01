module thermalfunctions__pyjspline

  use thermalfunctions__kinds, only : wp
  use thermalfunctions__jspline, only : Jb_spline
  use thermalfunctions__jspline, only : Jf_spline
  use thermalfunctions__jspline, only : dJb_spline
  use thermalfunctions__jspline, only : dJf_spline
  use iso_c_binding

  implicit none

  private

  public :: Jb_spline_c
  public :: Jf_spline_c
  public :: dJb_spline_c
  public :: dJf_spline_c

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

end module thermalfunctions__pyjspline
