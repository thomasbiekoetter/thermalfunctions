from pythermalfunctions.jtorch import Jb
from pythermalfunctions.jtorch import Jf
import matplotlib.pyplot as plt
import numpy as np
import torch


N = 1000
xmin = 1e-3
xmax = 10
x_np = np.linspace(xmin, xmax, N)


for J, l in zip([Jb, Jf], ['Jb', 'Jf']):
    x = torch.tensor(x_np, dtype=torch.float64, requires_grad=True)
    y = J(x)
    dy, = torch.autograd.grad(y.sum(), x, create_graph=True)
    d2y, = torch.autograd.grad(dy.sum(), x)
    y = y.detach().numpy()
    dy = dy.detach().numpy()
    d2y = d2y.numpy()
    dy_num = np.gradient(y, x_np, edge_order=2)
    d2y_num = np.gradient(dy, x_np, edge_order=2)
    fig, (ax1, ax2, ax3) = plt.subplots(3, 1, sharex=True, figsize=(6, 8))
    ax1.plot(x_np, y, label=l + ' (torch)')
    ax1.set_ylabel(l)
    ax1.legend()
    ax2.plot(x_np, dy, label='d' + l + ' (autograd)')
    ax2.plot(x_np, dy_num, '--', label='np.gradient(' + l + ')')
    ax2.set_ylabel('d' + l)
    ax2.legend()
    ax3.plot(x_np, d2y, label='d2' + l + ' (autograd)')
    ax3.plot(x_np, d2y_num, '--', label='np.gradient(d' + l + ')')
    ax3.set_ylabel('d2' + l)
    ax3.set_xlabel('x')
    ax3.legend()
    name = 'torch_' + l + '.pdf'
    plt.savefig(name)
    print(l + ': max abs difference dJ: ', np.max(np.abs(dy - dy_num)))
    print(l + ': max abs difference d2J:', np.max(np.abs(d2y - d2y_num)))
