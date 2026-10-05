import numpy as np
import torch
from pythermalfunctions.jspline import Jb_spline
from pythermalfunctions.jspline import Jf_spline
from pythermalfunctions.jspline import dJb_spline
from pythermalfunctions.jspline import dJf_spline
from pythermalfunctions.jspline import d2Jb_spline
from pythermalfunctions.jspline import d2Jf_spline
from pythermalfunctions.jtorch import Jb
from pythermalfunctions.jtorch import Jf
from pythermalfunctions.jtorch import _dJb
from pythermalfunctions.jtorch import _dJf


x_np = np.linspace(1e-2, 10, 50)

for J, dJ, J_s, dJ_s, d2J_s, l in zip(
        [Jb, Jf], [_dJb.apply, _dJf.apply],
        [Jb_spline, Jf_spline],
        [dJb_spline, dJf_spline],
        [d2Jb_spline, d2Jf_spline],
        ['Jb', 'Jf']):

    x = torch.tensor(x_np, dtype=torch.float64, requires_grad=True)

    # Values agree with the scalar wrapper
    y = J(x)
    y_ref = np.array([J_s(xi) for xi in x_np])
    assert np.allclose(y.detach().numpy(), y_ref, rtol=0, atol=0)

    # First derivative from autograd
    dy, = torch.autograd.grad(y.sum(), x, create_graph=True)
    dy_ref = np.array([dJ_s(xi) for xi in x_np])
    assert np.allclose(dy.detach().numpy(), dy_ref, rtol=0, atol=0)

    # Second derivative from autograd
    d2y, = torch.autograd.grad(dy.sum(), x)
    d2y_ref = np.array([d2J_s(xi) for xi in x_np])
    assert np.allclose(d2y.numpy(), d2y_ref, rtol=0, atol=0)

    # Consistency of the analytic derivatives with finite differences
    xg = torch.tensor(x_np, dtype=torch.float64, requires_grad=True)
    assert torch.autograd.gradcheck(J, (xg,), eps=1e-6, atol=1e-5)
    assert torch.autograd.gradcheck(dJ, (xg,), eps=1e-6, atol=1e-5)
    assert torch.autograd.gradgradcheck(J, (xg,), eps=1e-6, atol=1e-5)

    # Chain rule through ysq = m^2(phi) / T^2 and Hessian
    T = 1.5
    def V(phi):
        m2 = 0.5 * phi[0]**2 + 0.2 * phi[1]**2 + 0.1 * phi[0] * phi[1]
        return T**4 * J(m2 / T**2)
    phi = torch.tensor([1.3, 0.7], dtype=torch.float64)
    H = torch.autograd.functional.hessian(V, phi)
    p0, p1 = phi.tolist()
    ysq = (0.5 * p0**2 + 0.2 * p1**2 + 0.1 * p0 * p1) / T**2
    gm = np.array([p0 + 0.1 * p1, 0.4 * p1 + 0.1 * p0])
    Hm = np.array([[1.0, 0.1], [0.1, 0.4]])
    H_ref = d2J_s(ysq) * np.outer(gm, gm) + T**2 * dJ_s(ysq) * Hm
    assert np.allclose(H.numpy(), H_ref, rtol=1e-12, atol=0)

    print(l + ': all checks passed')
