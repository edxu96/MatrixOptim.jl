
# Metsa-Oy Production and Supply Chain 2: Dynamic

## 1, Introduction

## 2, Definition of Mathematical Expressions

<p align="center"><img src="/examples/quadradic/tex/563cda82815e6e35d5d6d9c125bc476d.svg?invert_in_darkmode&sanitize=true" align=middle width=679.5676040999999pt height=377.24512319999997pt/></p>

_Table 1, summary of sets_

<p align="center"><img src="/examples/quadradic/tex/e32faef5aff14bb0102b79579fd6124a.svg?invert_in_darkmode&sanitize=true" align=middle width=683.4446982pt height=243.95743514999998pt/></p>

_Table 2, summary of decision variables_

<p align="center"><img src="/examples/quadradic/tex/7132e77b63c26401a5407a215854aaee.svg?invert_in_darkmode&sanitize=true" align=middle width=735.63306795pt height=545.0138034pt/></p>

_Table 3, summary of constants_

## 3, Objective Function

The Objective function composes of seven parts:

<p align="center"><img src="/examples/quadradic/tex/c61df3fb68bf65340623a6208daa538a.svg?invert_in_darkmode&sanitize=true" align=middle width=497.72279864999996pt height=18.84197535pt/></p>

1. cost of timber procurement: <img src="/examples/quadradic/tex/772a07e4a65de6c6fb4ac5dcaf685803.svg?invert_in_darkmode&sanitize=true" align=middle width=240.60506415pt height=27.91243950000002pt/>
2. cost of wood production: <img src="/examples/quadradic/tex/37206ee5228e3dd15db1bb8cf46d0e12.svg?invert_in_darkmode&sanitize=true" align=middle width=149.35345919999997pt height=27.91243950000002pt/>
3. cost of pulp and paper production: <img src="/examples/quadradic/tex/43a2635f44a9f56b79a8ae1e3c391e44.svg?invert_in_darkmode&sanitize=true" align=middle width=242.45478509999998pt height=27.6567522pt/>
4. profit of left timbers selling: <img src="/examples/quadradic/tex/e1ffbd27546576af623355f81a0d5646.svg?invert_in_darkmode&sanitize=true" align=middle width=724.7473859999999pt height=37.80850590000001pt/>
5. profit of fuel wood selling: <img src="/examples/quadradic/tex/1b659a4d826919922811b7d275bf2e58.svg?invert_in_darkmode&sanitize=true" align=middle width=153.77517044999996pt height=27.91243950000002pt/>
6. profit of wood selling: <img src="/examples/quadradic/tex/32ca75984f86e56e01c418b7f6d5ef0f.svg?invert_in_darkmode&sanitize=true" align=middle width=281.8592964pt height=27.91243950000002pt/>
7. profit of pulp selling: <img src="/examples/quadradic/tex/39b6d494aa52f9c75518cf3e6269dd88.svg?invert_in_darkmode&sanitize=true" align=middle width=283.33392285pt height=27.91243950000002pt/>
8. profit of paper selling: <img src="/examples/quadradic/tex/92ca546912179d9956f45eddf58b3232.svg?invert_in_darkmode&sanitize=true" align=middle width=312.3548339999999pt height=25.70766330000001pt/>
9. cost of capacity expansion: <img src="/examples/quadradic/tex/ea7f4d9f60baa367986afea9cbadce97.svg?invert_in_darkmode&sanitize=true" align=middle width=849.6745256999999pt height=37.80850590000001pt/>

## 4, Constraints

Besides the constraints that all variables are non-negative, there are ten sets of constraints:

1. limit of timber amount in wood production:

<p align="center"><img src="/examples/quadradic/tex/be71294c428b4264e0fba57c44b04bb4.svg?invert_in_darkmode&sanitize=true" align=middle width=177.2920248pt height=41.9486826pt/></p>

2. limit of timber amount in pulp and paper production:

<p align="center"><img src="/examples/quadradic/tex/29ea5580ef018de33d61f4cad6b78e7e.svg?invert_in_darkmode&sanitize=true" align=middle width=404.8505472pt height=59.1786591pt/></p>

3. limit of pulp amount in paper production:

<p align="center"><img src="/examples/quadradic/tex/0b1693f36fbcb61a4d51175e6ceb773b.svg?invert_in_darkmode&sanitize=true" align=middle width=185.98139999999998pt height=21.469790099999997pt/></p>

4. limit of wood amount in selling:

<p align="center"><img src="/examples/quadradic/tex/5b52ce8539f371dda15e492a5a637a95.svg?invert_in_darkmode&sanitize=true" align=middle width=144.5759832pt height=37.90293045pt/></p>

5. limit of pulp amount in selling:

<p align="center"><img src="/examples/quadradic/tex/fef6cb834042954053fc776e2a4e1e54.svg?invert_in_darkmode&sanitize=true" align=middle width=261.82183499999996pt height=37.90293045pt/></p>

6. limit of paper amount in selling:

<p align="center"><img src="/examples/quadradic/tex/98b373f111a64de6fa05473c2941578e.svg?invert_in_darkmode&sanitize=true" align=middle width=135.28984425pt height=37.90293045pt/></p>

7. limit of capacity in saw mill:

<p align="center"><img src="/examples/quadradic/tex/9e0b5c9fc8266bed2ebf1fabd3ca182f.svg?invert_in_darkmode&sanitize=true" align=middle width=108.4345977pt height=37.775108249999995pt/></p>

8. limit of capacity in plywood mill:

<p align="center"><img src="/examples/quadradic/tex/fe07094ff82eb5cbe3c99b7598ff71df.svg?invert_in_darkmode&sanitize=true" align=middle width=158.63258565pt height=38.90747685pt/></p>

9. limit of capacity in pulp production:

<p align="center"><img src="/examples/quadradic/tex/cc4149a797b3bb04b3bbd2ddfd463412.svg?invert_in_darkmode&sanitize=true" align=middle width=120.86924355pt height=20.95157625pt/></p>

10. limit of capacity in paper production:

<p align="center"><img src="/examples/quadradic/tex/2adbbe89b80b1c9fc8ed4da55392c3e6.svg?invert_in_darkmode&sanitize=true" align=middle width=104.07936329999998pt height=14.937954899999998pt/></p>

11. relation between capacity expansion factors

<p align="center"><img src="/examples/quadradic/tex/02653a7def9031e049690aa1534c877a.svg?invert_in_darkmode&sanitize=true" align=middle width=96.7046883pt height=63.19632495pt/></p>
