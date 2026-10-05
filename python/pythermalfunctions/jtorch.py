"""Torch-differentiable versions of the spline thermal functions.

The functions Jb and Jf act element-wise on torch tensors of ysq and
support autograd up to second order (gradients and Hessians). The
derivatives are provided by the spline derivatives dJ and d2J of the
Fortran library. Third derivatives are not available.

Evaluation happens on the CPU in double precision; the results are
cast back to the dtype and device of the input tensor.
"""
import os
import ctypes
import numpy as np
import torch


lib_path = os.path.join(
    os.path.dirname(__file__),
    "lib",
    "libthermalfunctions.so")

thermalfunctions_c = ctypes.CDLL(lib_path)


def _load_arr(name):
    f = getattr(thermalfunctions_c, name)
    f.argtypes = [
        ctypes.c_int,
        ctypes.POINTER(ctypes.c_double),
        ctypes.POINTER(ctypes.c_double)
    ]
    f.restype = None
    return f


_Jb_arr_c = _load_arr("Jb_spline_arr_c")
_dJb_arr_c = _load_arr("dJb_spline_arr_c")
_d2Jb_arr_c = _load_arr("d2Jb_spline_arr_c")
_Jf_arr_c = _load_arr("Jf_spline_arr_c")
_dJf_arr_c = _load_arr("dJf_spline_arr_c")
_d2Jf_arr_c = _load_arr("d2Jf_spline_arr_c")


def _eval(f_c, ysq):
    x = np.ascontiguousarray(
        ysq.detach().cpu().numpy(), dtype=np.float64)
    res = np.empty_like(x)
    f_c(
        x.size,
        x.ctypes.data_as(ctypes.POINTER(ctypes.c_double)),
        res.ctypes.data_as(ctypes.POINTER(ctypes.c_double)))
    return torch.from_numpy(res).to(device=ysq.device, dtype=ysq.dtype)


def _make(name, f_c, df=None):
    """Create an autograd function evaluating f_c whose derivative
    is the autograd function df (None: derivative not available)."""

    def forward(ctx, ysq):
        ctx.save_for_backward(ysq)
        return _eval(f_c, ysq)

    def backward(ctx, grad_out):
        ysq, = ctx.saved_tensors
        if df is None:
            raise NotImplementedError(
                "Derivative of " + name + " is not available.")
        return grad_out * df.apply(ysq)

    return type(name, (torch.autograd.Function,), {
        "forward": staticmethod(forward),
        "backward": staticmethod(backward),
    })


_d2Jb = _make("d2Jb", _d2Jb_arr_c)
_dJb = _make("dJb", _dJb_arr_c, _d2Jb)
_Jb = _make("Jb", _Jb_arr_c, _dJb)

_d2Jf = _make("d2Jf", _d2Jf_arr_c)
_dJf = _make("dJf", _dJf_arr_c, _d2Jf)
_Jf = _make("Jf", _Jf_arr_c, _dJf)


def _as_tensor(ysq):
    if isinstance(ysq, torch.Tensor):
        return ysq
    return torch.as_tensor(ysq, dtype=torch.float64)


def Jb(ysq):
    return _Jb.apply(_as_tensor(ysq))


def Jf(ysq):
    return _Jf.apply(_as_tensor(ysq))


def dJb(ysq):
    return _dJb.apply(_as_tensor(ysq))


def dJf(ysq):
    return _dJf.apply(_as_tensor(ysq))


def d2Jb(ysq):
    return _d2Jb.apply(_as_tensor(ysq))


def d2Jf(ysq):
    return _d2Jf.apply(_as_tensor(ysq))
