# pythermalfunctions

**pythermalfunctions** is the Python interface to the **thermalfunctions** Fortran library.  
It provides access to the implementations of thermal one-loop functions commonly used in finite-temperature quantum field theory.

The Python package wraps the Fortran core and exposes both **exact numerical** and **spline-interpolated** thermal functions for convenient use in Python workflows.

---

## Requirements

To build and install the Python interface, the following tools must be available:

* **Python** (with `pip`)  
* **gfortran**  
* **fpm** (Fortran Package Manager)  
* **patchelf**  

> **Note:** `patchelf` is required to correctly patch the generated shared library.  
> It can be installed either via your system package manager or via pip:  

```
pip install patchelf
```

---

## Installation

From the root directory of the project, run:

```
make wrapper
```

This command will:

1. Build the Fortran shared library using **fpm**  
2. Patch the resulting shared object using **patchelf**  
3. Install the Python package **pythermalfunctions** into your active Python environment using **pip**  

After installation, the package can be imported like any standard Python module.

---

## Usage

The package provides both **exact** and **spline-interpolated** versions of the bosonic and fermionic thermal functions.

### Imports

```
from pythermalfunctions.jexact import Jb
from pythermalfunctions.jexact import Jf
from pythermalfunctions.jspline import Jb_spline
from pythermalfunctions.jspline import Jf_spline
```

### Example

```
ysq = 4.0

res_exact = Jb(ysq)
res_spline = Jb_spline(ysq)
```

* `Jb`, `Jf` – Numerical evaluation via direct integration (using `quadpack`)  
* `Jb_spline`, `Jf_spline` – Fast spline-interpolated approximations based on precomputed tables  

All functions take a single argument `ysq` corresponding to the squared mass-to-temperature ratio.

---

## Tests and Benchmarks

The `test/` directory contains an example Python program that:

* Compares the results of `pythermalfunctions` against the thermal functions implemented in [CosmoTransitions](https://github.com/clwainwright/CosmoTransitions)  
* Benchmarks and compares the runtime performance of the different implementations  

This provides both validation of numerical accuracy and a performance comparison.

---

## Uninstallation / Cleanup

To remove the compiled wrapper and clean the build artifacts, run:

```
make clean
```

This will delete the generated shared libraries and related build files.

---

## License

This project is licensed under the **GNU General Public License v3.0 (GPL-3.0)**.

