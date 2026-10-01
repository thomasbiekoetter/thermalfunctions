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

dJb_spline_c = getattr(
    thermalfunctions_c,
    "dJb_spline_c")
dJb_spline_c.argtypes = [
    ctypes.c_double,
    ctypes.POINTER(ctypes.c_double)
]
dJb_spline_c.restype = None
def dJb_spline(ysq):
    res = ctypes.c_double()
    dJb_spline_c(ysq, ctypes.byref(res))
    return res.value

dJf_spline_c = getattr(
    thermalfunctions_c,
    "dJf_spline_c")
dJf_spline_c.argtypes = [
    ctypes.c_double,
    ctypes.POINTER(ctypes.c_double)
]
dJf_spline_c.restype = None
def dJf_spline(ysq):
    res = ctypes.c_double()
    dJf_spline_c(ysq, ctypes.byref(res))
    return res.value

d2Jb_spline_c = getattr(
    thermalfunctions_c,
    "d2Jb_spline_c")
d2Jb_spline_c.argtypes = [
    ctypes.c_double,
    ctypes.POINTER(ctypes.c_double)
]
d2Jb_spline_c.restype = None
def d2Jb_spline(ysq):
    res = ctypes.c_double()
    d2Jb_spline_c(ysq, ctypes.byref(res))
    return res.value

d2Jf_spline_c = getattr(
    thermalfunctions_c,
    "d2Jf_spline_c")
d2Jf_spline_c.argtypes = [
    ctypes.c_double,
    ctypes.POINTER(ctypes.c_double)
]
d2Jf_spline_c.restype = None
def d2Jf_spline(ysq):
    res = ctypes.c_double()
    d2Jf_spline_c(ysq, ctypes.byref(res))
    return res.value
