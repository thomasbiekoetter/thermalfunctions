import os
import ctypes
import numpy as np


lib_path = os.path.join(
    os.path.dirname(__file__),
    "lib",
    "libthermalfunctions.so")

thermalfunctions_c = ctypes.CDLL(lib_path)

Jb_c = getattr(
    thermalfunctions_c,
    "Jb_c")
Jb_c.argtypes = [
    ctypes.c_double,
    ctypes.POINTER(ctypes.c_double)
]
Jb_c.restype = None
def Jb(ysq):
    res = ctypes.c_double()
    Jb_c(ysq, ctypes.byref(res))
    return res.value

Jf_c = getattr(
    thermalfunctions_c,
    "Jf_c")
Jf_c.argtypes = [
    ctypes.c_double,
    ctypes.POINTER(ctypes.c_double)
]
Jf_c.restype = None
def Jf(ysq):
    res = ctypes.c_double()
    Jf_c(ysq, ctypes.byref(res))
    return res.value
