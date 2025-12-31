import numpy as np
import time
from pythermalfunctions.jexact import Jb
from pythermalfunctions.jexact import Jf
from pythermalfunctions.jspline import Jb_spline
from pythermalfunctions.jspline import Jf_spline
from cosmoTransitions.finiteT import Jb as Jb_cosmo
from cosmoTransitions.finiteT import Jf as Jf_cosmo

print()
ysq = 4.0
print("ysq =", ysq)
print()
res = Jb(ysq)
print("Jb_exact(ysq)  =", res)
res = Jb_spline(ysq)
print("Jb_spline(ysq) =", res)
res = Jb_cosmo(np.sqrt(ysq))
print("Jb_cosmo(y)    =", res)
print()
res = Jf(ysq)
print("Jf_exact(ysq)  =", res)
res = Jf_spline(ysq)
print("Jf_spline(ysq) =", res)
res = Jf_cosmo(np.sqrt(ysq))
print("Jf_cosmo(y)    =", res)
print()
print("Compare runtimes to cosmoTransitions:")
print("  Calling Jb 400 000 time:")
start = time.perf_counter()
for i in range(0, 400_000):
    x = Jb(ysq)
end = time.perf_counter()
print(f"  -> Elapsed time: {end - start:.6f} seconds")
print("  Calling Jb_spline 400 000 time:")
start = time.perf_counter()
for i in range(0, 400_000):
    x = Jb_spline(ysq)
end = time.perf_counter()
print(f"  -> Elapsed time: {end - start:.6f} seconds")
print("  Calling Jb_cosmo 400 000 time:")
start = time.perf_counter()
for i in range(0, 400_000):
    x = Jb_cosmo(ysq)
end = time.perf_counter()
print(f"  -> Elapsed time: {end - start:.6f} seconds")
print()
