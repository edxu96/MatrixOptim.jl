
# Metsa-Oy Forest and Supply Chain 1: Static

## 1, Introduction

The supply chain is illustrated using the following figure:

![](./images/1.png)

## 2, Definition of Mathematical Expressions

<p align="center"><img src="/examples/quadradic/tex/5826e1b3c1cb519a62f10219cc1d90c0.svg?invert_in_darkmode&sanitize=true" align=middle width=679.5676040999999pt height=357.51909599999993pt/></p>

_Table 1, summary of sets_

<p align="center"><img src="/examples/quadradic/tex/3836148835e7bf1815d988a931bb109d.svg?invert_in_darkmode&sanitize=true" align=middle width=531.5126355pt height=162.41008575pt/></p>

_Table 2, summary of decision variables_

<p align="center"><img src="/examples/quadradic/tex/45bc7b394c378423a429e9fe779cd34c.svg?invert_in_darkmode&sanitize=true" align=middle width=686.0831735999999pt height=462.78645599999993pt/></p>

_Table 3, summary of constants_

## 3, Objective Function

The Objective function composes of seven parts:

<p align="center"><img src="/examples/quadradic/tex/d16780476c1029e7e141aa8f57d13f2e.svg?invert_in_darkmode&sanitize=true" align=middle width=447.33465975pt height=17.9744895pt/></p>

1. cost of timber procurement: <img src="/examples/quadradic/tex/e684e451ee0e696d2097a1abacbb0633.svg?invert_in_darkmode&sanitize=true" align=middle width=225.03610634999995pt height=27.91243950000002pt/>

2. cost of wood production: <img src="/examples/quadradic/tex/37206ee5228e3dd15db1bb8cf46d0e12.svg?invert_in_darkmode&sanitize=true" align=middle width=149.35345919999997pt height=27.91243950000002pt/>

3. cost of pulp and paper production: <img src="/examples/quadradic/tex/43a2635f44a9f56b79a8ae1e3c391e44.svg?invert_in_darkmode&sanitize=true" align=middle width=242.45478509999998pt height=27.6567522pt/>

4. profit of left timbers selling:

<p align="center"><img src="/examples/quadradic/tex/7b8dfc0b566a3a63e6e3accaabfa0eb8.svg?invert_in_darkmode&sanitize=true" align=middle width=659.45019525pt height=59.1786591pt/></p>

5. profit of fuel wood selling: <img src="/examples/quadradic/tex/1b659a4d826919922811b7d275bf2e58.svg?invert_in_darkmode&sanitize=true" align=middle width=153.77517044999996pt height=27.91243950000002pt/>

6. profit of wood selling: <img src="/examples/quadradic/tex/32ca75984f86e56e01c418b7f6d5ef0f.svg?invert_in_darkmode&sanitize=true" align=middle width=281.8592964pt height=27.91243950000002pt/>

7. profit of pulp selling: <img src="/examples/quadradic/tex/39b6d494aa52f9c75518cf3e6269dd88.svg?invert_in_darkmode&sanitize=true" align=middle width=283.33392285pt height=27.91243950000002pt/>

8. profit of paper selling: <img src="/examples/quadradic/tex/92ca546912179d9956f45eddf58b3232.svg?invert_in_darkmode&sanitize=true" align=middle width=312.3548339999999pt height=25.70766330000001pt/>

## 4, Constraints

Besides the constraints that all variables are non-negative, there are ten sets of constraints:

1. limit of timber amount in wood production:

<p align="center"><img src="/examples/quadradic/tex/be71294c428b4264e0fba57c44b04bb4.svg?invert_in_darkmode&sanitize=true" align=middle width=177.2920248pt height=41.9486826pt/></p>

2. limit of timber amount in pulp and paper production:

<p align="center"><img src="/examples/quadradic/tex/29ea5580ef018de33d61f4cad6b78e7e.svg?invert_in_darkmode&sanitize=true" align=middle width=404.8505472pt height=59.1786591pt/></p>

3. limit of pulp amount in paper production:

<p align="center"><img src="/examples/quadradic/tex/0b1693f36fbcb61a4d51175e6ceb773b.svg?invert_in_darkmode&sanitize=true" align=middle width=185.98139999999998pt height=21.469790099999997pt/></p>

4. limit of wood amount in selling:

<p align="center"><img src="/examples/quadradic/tex/b8242fd212c676db6bf72c24647ae054.svg?invert_in_darkmode&sanitize=true" align=middle width=152.95368495pt height=37.90293045pt/></p>

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

## 5, Result

obj = <img src="/examples/quadradic/tex/5cd9210cd4aac1f23498aecaf49797b6.svg?invert_in_darkmode&sanitize=true" align=middle width=61.535618099999986pt height=21.18721440000001pt/>

Produced quantity of final products {MAS, KUS, KOS, KUV, KOV, HSEL, LSEL, PAPER} = [0, 0, 0, 0, 0, 16, 16, 80]. The units of first five quantities are <img src="/examples/quadradic/tex/e19e1d4fc2f89a8a1a4c66e84bf22b09.svg?invert_in_darkmode&sanitize=true" align=middle width=93.08636534999998pt height=26.76175259999998pt/>, and the units of last three are <img src="/examples/quadradic/tex/01df07585615c41a5b91b5949690b3f6.svg?invert_in_darkmode&sanitize=true" align=middle width=95.02317pt height=24.65753399999998pt/>.

```
result_h_t = [0, -0, -0, 77, 80, 68]
result_y_i = [0, 0, 0, 0, 0]
result_y_j = [16, 16]
result_y_paper = 80
result_z_ik = [
	0.0 130.0 58.33 50.0;
	0.0 60.0 54.17 46.67;
	0.0 35.0 31.25 32.0;
	0.0 190.0 150.0 97.22;
	537.5 292.86 162.5 126.67
	]
result_z_jk = [
	0.0 312.5 230.0 216.67;
	0.0 700.0 191.67 178.57142857142858
	]
result_z_paper_k = [24.85, 27.39, 6.16, 21.60]
```
