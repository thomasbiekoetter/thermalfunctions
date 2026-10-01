from pythermalfunctions.jspline import dJb_spline as dJb
from pythermalfunctions.jspline import dJf_spline as dJf
from pythermalfunctions.jspline import d2Jb_spline as d2Jb
from pythermalfunctions.jspline import d2Jf_spline as d2Jf
import matplotlib.pyplot as plt
import numpy as np


N = 1000
xmin = 1e-3
xmax = 10
x = np.linspace(xmin, xmax, N)
dy = np.zeros(shape=x.shape)
d2y = np.zeros(shape=x.shape)


for dJ, d2J, l in zip([dJb, dJf], [d2Jb, d2Jf], ['d2Jb', 'd2Jf']):
    for i in range(0, N):
        dy[i] = dJ(x[i])
        d2y[i] = d2J(x[i])
    d2y_num = np.gradient(dy, x, edge_order=2)
    fig, (ax1, ax2) = plt.subplots(2, 1, sharex=True)
    label = l + ' (spline)'
    ax1.plot(x, d2y, label=label)
    ax1.plot(x, d2y_num, '--', label='np.gradient(dJ)')
    ax1.legend()
    ax2.plot(x, d2y - d2y_num)
    ax2.set_ylabel('difference')
    ax2.set_xlabel('x')
    name = l + '_check.pdf'
    plt.savefig(name)
    print('max abs difference:', np.max(np.abs(d2y - d2y_num)))

