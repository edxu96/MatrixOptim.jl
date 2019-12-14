

The objective in this assignment is primely to apply dynamic optimization on a specific problem rather than determining the shape of a suspended chain or cable. (This can be found in just about any text book in mechanics). In the report, it is important to give the results and an interpretation of those, but certainly also to describe the chosen method, its background and assumptions.

### Rewrite the Cost Function in Standard Form

For <img src="/examples/dynamic/project/tex/87b1657177022f790cc2ab8fbcc138bb.svg?invert_in_darkmode&sanitize=true" align=middle width=123.85906005pt height=22.465723500000017pt/>, we have:

<p align="center"><img src="/examples/dynamic/project/tex/44878bfbb42d9a7a5e1ae410d52674cf.svg?invert_in_darkmode&sanitize=true" align=middle width=412.2651489pt height=88.493889pt/></p>

where the end points are:

<p align="center"><img src="/examples/dynamic/project/tex/d5e976a1a29efc4411c34a227b2d2a27.svg?invert_in_darkmode&sanitize=true" align=middle width=120.08604629999999pt height=87.1240095pt/></p>

The (steady state) potential energy can be written as:

<p align="center"><img src="/examples/dynamic/project/tex/a381899fdf98fdfd103db242eba21819.svg?invert_in_darkmode&sanitize=true" align=middle width=233.98111605pt height=105.4751709pt/></p>

where

<p align="center"><img src="/examples/dynamic/project/tex/2b27a0c5827073622e30f34ca0d83eb9.svg?invert_in_darkmode&sanitize=true" align=middle width=277.14659939999996pt height=87.1240095pt/></p>

### Solve the Problem

The Hamiltonian function is:

<p align="center"><img src="/examples/dynamic/project/tex/0c63070d48ae3596e30bd20135460ab9.svg?invert_in_darkmode&sanitize=true" align=middle width=480.48699765000003pt height=32.990165999999995pt/></p>

Euler-Lagrange equations are:

<p align="center"><img src="/examples/dynamic/project/tex/9d16e79283f23393303970095a8b8786.svg?invert_in_darkmode&sanitize=true" align=middle width=312.91698735pt height=138.28108139999998pt/></p>

where the boundary conditions are:

<p align="center"><img src="/examples/dynamic/project/tex/d5e976a1a29efc4411c34a227b2d2a27.svg?invert_in_darkmode&sanitize=true" align=middle width=120.08604629999999pt height=87.1240095pt/></p>

The calculate procedure for iterations can be expressed by the following equations:

<p align="center"><img src="/examples/dynamic/project/tex/1b8746e5df5cfcf9dd7f7b0cc76ff510.svg?invert_in_darkmode&sanitize=true" align=middle width=278.34147659999996pt height=137.5294668pt/></p>

or the following equations according to Pontryagins Maximum principle:

<p align="center"><img src="/examples/dynamic/project/tex/8f657142ac15fbb67879bb7326143a41.svg?invert_in_darkmode&sanitize=true" align=middle width=573.69488055pt height=137.5294668pt/></p>

When <img src="/examples/dynamic/project/tex/ed6ccff2a53f69f4c96dce6a9fc774d4.svg?invert_in_darkmode&sanitize=true" align=middle width=212.30146904999998pt height=22.831056599999986pt/>, the results are:

The value of the costate vector at 0, <img src="/examples/dynamic/project/tex/8d54550f8c3f314c8645aa4db192e631.svg?invert_in_darkmode&sanitize=true" align=middle width=60.62598794999999pt height=33.305929799999994pt/>, is:

When <img src="/examples/dynamic/project/tex/8ab74d51f506ab3d319edfc456af1e16.svg?invert_in_darkmode&sanitize=true" align=middle width=228.73988774999995pt height=22.831056599999986pt/>, the results are:

The value of the costate vector at 0, <img src="/examples/dynamic/project/tex/8d54550f8c3f314c8645aa4db192e631.svg?invert_in_darkmode&sanitize=true" align=middle width=60.62598794999999pt height=33.305929799999994pt/>, is:

### Vertical Force and Costate Vector

Determine the vertical force in the origin (i = 0). Compare this with the costate at the origin. Discuss your observations. Give a qualified guess on the sign of horizontal force in the origin.
