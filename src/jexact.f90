module thermalfunctions__jexact

  use thermalfunctions__kinds, only : wp
  use quadpack, only: dqag

  implicit none

  private

  public :: Jb
  public :: Jf

contains

  function Jb(ysq) result(res)

    real(wp), intent(in) :: ysq
    real(wp) :: res

    real(wp) :: a = 0.0e0_wp
    real(wp) :: b = 1.0e2_wp
    real(wp) :: epsabs = 0.0e0_wp
    real(wp) :: epsrel = 10**(log10(epsilon(1.0e0_wp)) / 2.0e0_wp + 1.0e0_wp)
    integer :: key = 1
    real(wp) :: abserr
    integer :: neval
    integer :: ier
    integer, parameter :: limit = 200
    integer, parameter :: lenw = 4 * limit
    integer :: last
    integer :: iwork(limit)
    real(wp) :: work(lenw)

    call dqag(  &
      f, a, b,  &
      epsabs, epsrel, key, res, abserr,  &
      neval, ier, limit, lenw, last, iwork, work)

    contains

      function f(x) result(res)

        real(wp), intent(in) :: x
        real(wp) :: res

        res = Iboson(x, ysq)

      end function

  end function

  function Jf(ysq) result(res)

    real(wp), intent(in) :: ysq
    real(wp) :: res

    real(wp) :: a = 0.0e0_wp
    real(wp) :: b = 1.0e2_wp
    real(wp) :: epsabs = 0.0e0_wp
    real(wp) :: epsrel = 10**(log10(epsilon(1.0e0_wp)) / 2.0e0_wp + 1.0e0_wp)
    integer :: key = 1
    real(wp) :: abserr
    integer :: neval
    integer :: ier
    integer, parameter :: limit = 200
    integer, parameter :: lenw = 4 * limit
    integer :: last
    integer :: iwork(limit)
    real(wp) :: work(lenw)

    call dqag(  &
      f, a, b,  &
      epsabs, epsrel, key, res, abserr,  &
      neval, ier, limit, lenw, last, iwork, work)

    contains

      function f(x) result(res)

        real(wp), intent(in) :: x
        real(wp) :: res

        res = Ifermion(x, ysq)

      end function

  end function

  function Iboson(x, ysq) result(res)

    real(wp), intent(in) :: x
    real(wp), intent(in) :: ysq
    real(wp) :: res

    complex(wp) :: z

    z%re = x ** 2 + ysq
    z%im = 0.0e0_wp
    z = sqrt(z)
    res = real(1.0e0_wp * x ** 2 * log(1.0e0_wp - exp(-z)))

  end function Iboson

  function Ifermion(x, ysq) result(res)

    real(wp), intent(in) :: x
    real(wp), intent(in) :: ysq
    real(wp) :: res

    complex(wp) :: z

    z%re = x ** 2 + ysq
    z%im = 0.0e0_wp
    z = sqrt(z)
    res = real(-1.0e0_wp * x ** 2 * log(1.0e0_wp + exp(-z)))

  end function Ifermion

end module thermalfunctions__jexact
