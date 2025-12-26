module thermalfunctions__jspline

  use thermalfunctions__kinds, only : wp
  use evortran__util_interp_spline, only :  &
    spline_construct
  use evortran__util_interp_spline, only :  &
    spline_getval
  use evortran__util_numpy, only : logspace
  use thermalfunctions__jexact, only : Jb
  use thermalfunctions__jexact, only : Jf

  private

  integer, parameter :: Ninit = 10000
  real(wp), parameter :: xsq_min = 1.0e-8_wp
  real(wp), parameter :: xsq_max = 1.0e3_wp
  integer :: Nf
  real(wp), allocatable :: b_Jf(:)
  real(wp), allocatable :: c_Jf(:)
  real(wp), allocatable :: d_Jf(:)
  real(wp), allocatable :: yf(:)
  real(wp), allocatable :: ff(:)
  integer :: Nb
  real(wp), allocatable :: b_Jb(:)
  real(wp), allocatable :: c_Jb(:)
  real(wp), allocatable :: d_Jb(:)
  real(wp), allocatable :: yb(:)
  real(wp), allocatable :: fb(:)
  logical :: is_init = .false.

  !$omp threadprivate(  &
  !$omp   is_init,  &
  !$omp   ff, b_Jf, c_Jf, d_Jf,  &
  !$omp   fb, b_Jb, c_Jb, d_Jb, yf, yb, Nf, Nb)


  public :: init_splines
  public :: Jb_spline
  public :: Jf_spline

contains

  function Jb_spline(x) result(y)

    real(wp), intent(in) :: x
    real(wp) :: y

    if (.not. is_init) then
      call init_splines(xsq_min, xsq_max, Ninit)
      is_init = .true.
    end if

    y = spline_getval(x, yb, fb, b_Jb, c_Jb, d_Jb, Nb)

  end function Jb_spline

  function Jf_spline(x) result(y)

    real(wp), intent(in) :: x
    real(wp) :: y

    if (.not. is_init) then
      call init_splines(xsq_min, xsq_max, Ninit)
      is_init = .true.
    end if

    y = spline_getval(x, yf, ff, b_Jf, c_Jf, d_Jf, Nf)

  end function Jf_spline

  subroutine init_splines(a, b, N)

    real(wp), intent(in) :: a
    real(wp), intent(in) :: b
    integer, intent(in) :: N

    integer :: i

    Nf = N
    yf = logspace(a, b, Nf)
    allocate(ff(Nf))
    allocate(b_Jf(Nf))
    allocate(c_Jf(Nf))
    allocate(d_Jf(Nf))
    do i = 1, Nf
      ff(i) = Jf(yf(i))
    end do
    call spline_construct(  &
      yf, ff, b_Jf, c_Jf, d_Jf, Nf)

    Nb = 2 * N
    allocate(b_Jb(Nb))
    allocate(c_Jb(Nb))
    allocate(d_Jb(Nb))
    allocate(yb(Nb))
    allocate(fb(Nb))
    do i = 1, N
      yb(i) = -yf(N - i + 1)
      yb(N + i) = yf(i)
    end do
    do i = 1, Nb
      fb(i) = Jb(yb(i))
    end do

    call spline_construct(  &
      yb, fb, b_Jb, c_Jb, d_Jb, Nb)

  end subroutine

end module thermalfunctions__jspline
