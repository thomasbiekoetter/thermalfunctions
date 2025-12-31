import os
import ctypes
import numpy as np


lib_path = os.path.join(
    os.path.dirname(__file__),
    "lib",
    "libthermalfunctions.so")

thermalfunctions_c = ctypes.CDLL(lib_path)

Jb_spline_c = getattr(
    thermalfunctions_c,
    "Jb_spline_c")
Jb_spline_c.argtypes = [
    ctypes.c_double,
    ctypes.POINTER(ctypes.c_double)
]
Jb_spline_c.restype = None
def Jb_spline(ysq):
    res = ctypes.c_double()
    Jb_spline_c(ysq, ctypes.byref(res))
    return res.value

Jf_spline_c = getattr(
    thermalfunctions_c,
    "Jf_spline_c")
Jf_spline_c.argtypes = [
    ctypes.c_double,
    ctypes.POINTER(ctypes.c_double)
]
Jf_spline_c.restype = None
def Jf_spline(ysq):
    res = ctypes.c_double()
    Jf_spline_c(ysq, ctypes.byref(res))
    return res.value
