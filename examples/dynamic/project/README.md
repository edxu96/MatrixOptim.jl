
# Find the Trajectory using Dynamic Optimization

In the report, it is important to give the results and an interpretation of those, but certainly also to describe the chosen method, its background and assumptions.

## 1, Trajectory of a Suspended Chain

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

<p align="center"><img src="/examples/dynamic/project/tex/cef1dcb53809470999e3cd014c94521e.svg?invert_in_darkmode&sanitize=true" align=middle width=144.61048799999998pt height=153.69987765pt/></p>

The calculate procedure for iterations can be expressed by the following equations:

<p align="center"><img src="/examples/dynamic/project/tex/1b8746e5df5cfcf9dd7f7b0cc76ff510.svg?invert_in_darkmode&sanitize=true" align=middle width=278.34147659999996pt height=137.5294668pt/></p>

or the following equations according to Pontryagins Maximum principle:

<p align="center"><img src="/examples/dynamic/project/tex/0123cb69d017e6328ec866dd8ea34393.svg?invert_in_darkmode&sanitize=true" align=middle width=631.3636725pt height=137.80322325pt/></p>

When <img src="/examples/dynamic/project/tex/ed6ccff2a53f69f4c96dce6a9fc774d4.svg?invert_in_darkmode&sanitize=true" align=middle width=212.30146904999998pt height=22.831056599999986pt/>, the results are:

The value of the costate vector at 0, <img src="/examples/dynamic/project/tex/8d54550f8c3f314c8645aa4db192e631.svg?invert_in_darkmode&sanitize=true" align=middle width=60.62598794999999pt height=33.305929799999994pt/>, is:

When <img src="/examples/dynamic/project/tex/8ab74d51f506ab3d319edfc456af1e16.svg?invert_in_darkmode&sanitize=true" align=middle width=228.73988774999995pt height=22.831056599999986pt/>, the results are:

The value of the costate vector at 0, <img src="/examples/dynamic/project/tex/8d54550f8c3f314c8645aa4db192e631.svg?invert_in_darkmode&sanitize=true" align=middle width=60.62598794999999pt height=33.305929799999994pt/>, is:

### Vertical Force and Costate Vector

Determine the vertical force in the origin (i = 0). Compare this with the costate at the origin. Discuss your observations. Give a qualified guess on the sign of horizontal force in the origin.

### Two Symmetric Half Chains

For <img src="/examples/dynamic/project/tex/87b1657177022f790cc2ab8fbcc138bb.svg?invert_in_darkmode&sanitize=true" align=middle width=123.85906005pt height=22.465723500000017pt/>, we have:

<p align="center"><img src="/examples/dynamic/project/tex/44878bfbb42d9a7a5e1ae410d52674cf.svg?invert_in_darkmode&sanitize=true" align=middle width=412.2651489pt height=88.493889pt/></p>

where the boundary conditions are:

<p align="center"><img src="/examples/dynamic/project/tex/d49fde9de438443f411722033b803ff4.svg?invert_in_darkmode&sanitize=true" align=middle width=113.74056540000001pt height=64.7674335pt/></p>

When <img src="/examples/dynamic/project/tex/4d8fc1d3851286cb7b423eaf172ee903.svg?invert_in_darkmode&sanitize=true" align=middle width=55.00368554999999pt height=22.465723500000017pt/>

## 2, Trajectory of a Suspended Wire

Now, the chain is substituted by a wire and the problem becomes a continuous problem. Let <img src="/examples/dynamic/project/tex/6f9bad7347b91ceebebd3ad7e6f6f2d1.svg?invert_in_darkmode&sanitize=true" align=middle width=7.7054801999999905pt height=14.15524440000002pt/> the distance along the wire. The positions along the wire obey

<p align="center"><img src="/examples/dynamic/project/tex/0992366c43f1ad69bf7ac24eec97428b.svg?invert_in_darkmode&sanitize=true" align=middle width=237.09815415pt height=39.452455349999994pt/></p>

where the boundary conditions are:

<p align="center"><img src="/examples/dynamic/project/tex/6fe55ab3c01b53af069221da5fe99c2e.svg?invert_in_darkmode&sanitize=true" align=middle width=117.4582332pt height=87.1240095pt/></p>

So the potential energy in steady state can be expressed by:

<p align="center"><img src="/examples/dynamic/project/tex/ef421a9d6e7ad7bc5344795837fa8180.svg?invert_in_darkmode&sanitize=true" align=middle width=132.2186844pt height=41.15109735pt/></p>

where

<p align="center"><img src="/examples/dynamic/project/tex/d43a5cd1ea7359573d72e34fda511dd5.svg?invert_in_darkmode&sanitize=true" align=middle width=124.30212629999998pt height=41.09589pt/></p>

The Hamiltonian function is:

<p align="center"><img src="/examples/dynamic/project/tex/6513a3c7887729b7936195665ddcb56d.svg?invert_in_darkmode&sanitize=true" align=middle width=275.07778155pt height=16.438356pt/></p>

Euler-Lagrange equations are:

<p align="center"><img src="/examples/dynamic/project/tex/86b5be090f00b1faa74c4d2337c83325.svg?invert_in_darkmode&sanitize=true" align=middle width=214.7925945pt height=115.06849364999998pt/></p>

or the following equations according to Pontryagins Maximum principle:

<p align="center"><img src="/examples/dynamic/project/tex/cbde22906356a6c052548caceb047a2b.svg?invert_in_darkmode&sanitize=true" align=middle width=402.59250735pt height=126.09769095pt/></p>

Plot the shape of the wire and discuss your observations. Determine the value of the costate vector in origin. Investigate the variation of the Hamiltonian function (i.e. the variation of the Hamiltonian as function of <img src="/examples/dynamic/project/tex/6f9bad7347b91ceebebd3ad7e6f6f2d1.svg?invert_in_darkmode&sanitize=true" align=middle width=7.7054801999999905pt height=14.15524440000002pt/>). Plot the function as function of s and explain what you see - and why.
