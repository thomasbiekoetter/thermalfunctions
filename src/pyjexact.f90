module thermalfunctions__pyjexact

  use thermalfunctions__kinds, only : wp
  use thermalfunctions__jexact, only : Jb
  use thermalfunctions__jexact, only : Jf
  use iso_c_binding

  implicit none

  private

  public :: Jb_c
  public :: Jf_c

contains

  subroutine Jb_c(ysq, res) bind(C, name="Jb_c")

    real(c_double), value, intent(in) :: ysq
    real(c_double), intent(out) :: res

    real(wp) :: ysq_f
    real(wp) :: res_f

    ysq_f = real(ysq, wp)
    res_f = Jb(ysq_f)
    res = real(res_f, c_double)

  end subroutine Jb_c

  subroutine Jf_c(ysq, res) bind(C, name="Jf_c")

    real(c_double), value, intent(in) :: ysq
    real(c_double), intent(out) :: res

    real(wp) :: ysq_f
    real(wp) :: res_f

    ysq_f = real(ysq, wp)
    res_f = Jf(ysq_f)
    res = real(res_f, c_double)

  end subroutine Jf_c

end module thermalfunctions__pyjexact
