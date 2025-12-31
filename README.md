# thermalfunctions

**thermalfunctions** is a Fortran package (built with **fpm**) that computes **thermal one-loop functions** in **4D finite-temperature quantum field theory**.
It provides both **exact numerical evaluation** and **fast spline-interpolated approximations** for bosonic and fermionic thermal functions.

In addition to the native Fortran API, **thermalfunctions** also provides a **Python interface**, allowing the core routines to be called directly from Python.
For details on the Python bindings and usage examples, see the `python/` directory, which contains an additional README with full instructions.

---

## Features

* Bosonic thermal one-loop function ( J_b(x) )
* Fermionic thermal one-loop function ( J_f(x) )
* Two computation modes:

  1. **Exact mode**: direct numerical integration using **QUADPACK**
  2. **Spline mode**: cubic spline interpolation of precomputed exact values
* **Python interface** for calling the thermal functions from Python

---


## Installation

### Using fpm as a dependency

Add the following line to the `[dependencies]` section of your `fpm.toml`:

```toml
[dependencies]
thermalfunctions = { git = "https://github.com/thomasbiekoetter/thermalfunctions.git" }
```

---

## Building the package

To build the package locally:

```bash
fpm build
```

To run the included example program:

```bash
fpm run
```

---

## Usage

The library provides separate modules for **exact** and **spline-interpolated** thermal functions.

### Example program

```fortran
program main

  use thermalfunctions__kinds, only : wp
  use thermalfunctions__jexact, only: Jb, Jf
  use thermalfunctions__jspline, only: Jb_spline, Jf_spline

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
```

---

## Modules and API

### Exact numerical evaluation

```fortran
use thermalfunctions__jexact, only: Jb, Jf
```

* `Jb(x)` — bosonic thermal function
* `Jf(x)` — fermionic thermal function
* Uses adaptive numerical integration (QUADPACK)

Recommended when:

* Maximum accuracy is required
* Evaluations are infrequent

---

### Spline interpolation (fast mode)

```fortran
use thermalfunctions__jspline, only: Jb_spline, Jf_spline
```

* `Jb_spline(x)` — cubic spline approximation to `Jb`
* `Jf_spline(x)` — cubic spline approximation to `Jf`

Recommended when:

* Many evaluations are needed
* Performance is important
* Small interpolation errors are acceptable

---

## Requirements

* A modern Fortran compiler (e.g. `gfortran`, `ifx`, `nvfortran`)
* Fortran Package Manager (**fpm**)

---

## License

This project is licensed under the **GNU General Public License v3.0 (GPL-3.0)**.

