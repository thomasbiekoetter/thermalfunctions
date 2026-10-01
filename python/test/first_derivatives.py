from pythermalfunctions.jspline import Jb_spline as Jb
from pythermalfunctions.jspline import Jf_spline as Jf
from pythermalfunctions.jspline import dJb_spline as dJb
from pythermalfunctions.jspline import dJf_spline as dJf
import matplotlib.pyplot as plt
import numpy as np


N = 1000
xmin = 1e-4
xmax = 10
x = np.linspace(xmin, xmax, N)
y = np.zeros(shape=x.shape)
dy = np.zeros(shape=x.shape)


for J, dJ, l in zip([Jb, Jf], [dJb, dJf], ['dJb', 'dJf']):
    for i in range(0, N):
        y[i] = J(x[i])
        dy[i] = dJ(x[i])
    dy_num = np.gradient(y, x, edge_order=2)
    fig, (ax1, ax2) = plt.subplots(2, 1, sharex=True)
    label = l + ' (spline)'
    ax1.plot(x, dy, label=label)
    ax1.plot(x, dy_num, '--', label='np.gradient')
    ax1.legend()
    ax2.plot(x, dy - dy_num)
    ax2.set_ylabel('difference')
    ax2.set_xlabel('x')
    name = l + '_check.pdf'
    plt.savefig(name)
    print('max abs difference:', np.max(np.abs(dy - dy_num)))

