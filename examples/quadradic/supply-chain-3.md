
# Metsa-Oy Production and Supply Chain 3: Stochastic Dynamic

## 1, Introduction

## 2, Definition of Mathematical Expressions

<p align="center"><img src="/examples/quadradic/tex/50220e9df8aa71e1f6400321ad0b7c20.svg?invert_in_darkmode&sanitize=true" align=middle width=679.5676040999999pt height=396.97115204999994pt/></p>

_Table 1, summary of sets_

<p align="center"><img src="/examples/quadradic/tex/7322f45d3aff966e1656d1d751545370.svg?invert_in_darkmode&sanitize=true" align=middle width=782.2652145pt height=327.36799755pt/></p>

_Table 2, summary of decision variables_

<p align="center"><img src="/examples/quadradic/tex/d92dcfaed95fdc9c0b01b9862ca774da.svg?invert_in_darkmode&sanitize=true" align=middle width=759.1170212999999pt height=743.67942495pt/></p>

_Table 3, summary of constants_

## 3, Objective Function

The Objective function composes of many parts:

<p align="center"><img src="/examples/quadradic/tex/f510bdb99fec8650c01a20e8bbec9304.svg?invert_in_darkmode&sanitize=true" align=middle width=686.5706594999999pt height=78.5391552pt/></p>

- When m = 1, the variables are here-and-now decisions variables:

1. cost of timber procurement: <img src="/examples/quadradic/tex/9ef2df73999b9e34cebc98b451a23586.svg?invert_in_darkmode&sanitize=true" align=middle width=256.1740203pt height=27.91243950000002pt/>

2. cost of wood production: <img src="/examples/quadradic/tex/a0f688b49aee6538fa36879fc524c813.svg?invert_in_darkmode&sanitize=true" align=middle width=162.26319779999997pt height=27.91243950000002pt/>

3. cost of pulp and paper production: <img src="/examples/quadradic/tex/a530cd9609956ba8e65a443c56475442.svg?invert_in_darkmode&sanitize=true" align=middle width=310.38598469999994pt height=27.6567522pt/>

4. profit of left timbers selling:

<p align="center"><img src="/examples/quadradic/tex/29e061fbccb1cdb13491df5948921c0e.svg?invert_in_darkmode&sanitize=true" align=middle width=721.82700315pt height=59.1786591pt/></p>

5. profit of fuel wood selling: <img src="/examples/quadradic/tex/f624dba7a12f224efaaec04a32aad3fa.svg?invert_in_darkmode&sanitize=true" align=middle width=166.68490904999996pt height=27.91243950000002pt/>

6. profit of wood selling: <img src="/examples/quadradic/tex/26f35d6a98bdca787973077c5089e582.svg?invert_in_darkmode&sanitize=true" align=middle width=370.7204588999999pt height=27.91243950000002pt/>

7. profit of pulp selling: <img src="/examples/quadradic/tex/e3272f324243d0aa3c2cae3ab2b66041.svg?invert_in_darkmode&sanitize=true" align=middle width=373.83317565pt height=27.91243950000002pt/>

8. profit of paper selling: <img src="/examples/quadradic/tex/54fe0a5949407f1eec60b94da643fab3.svg?invert_in_darkmode&sanitize=true" align=middle width=395.76655304999997pt height=26.76175259999998pt/>

- When m = 2 or 3, the variables are wait-and-see decisions variables:

1. cost of timber procurement: <img src="/examples/quadradic/tex/6c41817d4a436c6309207a1fc3e61469.svg?invert_in_darkmode&sanitize=true" align=middle width=280.23427905pt height=27.91243950000002pt/>

2. cost of wood production: <img src="/examples/quadradic/tex/98b4b6b1bee975301832194268281de3.svg?invert_in_darkmode&sanitize=true" align=middle width=174.29335275pt height=27.91243950000002pt/>

3. cost of pulp and paper production: <img src="/examples/quadradic/tex/c3174ee6a8ee525caeb9a996453bbf34.svg?invert_in_darkmode&sanitize=true" align=middle width=329.8210509pt height=27.6567522pt/>

4. profit of left timbers selling:

<p align="center"><img src="/examples/quadradic/tex/6f641b10cb2ff0d8d3941cf8289eaa41.svg?invert_in_darkmode&sanitize=true" align=middle width=781.9776525pt height=59.1786591pt/></p>

5. profit of fuel wood selling: <img src="/examples/quadradic/tex/0b07657ea33ed91ad7c547e5636e37a8.svg?invert_in_darkmode&sanitize=true" align=middle width=180.91832549999998pt height=27.91243950000002pt/>

6. profit of wood selling: <img src="/examples/quadradic/tex/6a532dd8375b9383f701742768d0eff8.svg?invert_in_darkmode&sanitize=true" align=middle width=430.53615495pt height=27.91243950000002pt/>

7. profit of pulp selling: <img src="/examples/quadradic/tex/fd7a1babe8e030285e370ebdb1ebdf28.svg?invert_in_darkmode&sanitize=true" align=middle width=433.64887335pt height=27.91243950000002pt/>

8. profit of paper selling: <img src="/examples/quadradic/tex/f491bd518f22008565ccf4d9b60f0f5b.svg?invert_in_darkmode&sanitize=true" align=middle width=434.9886535499999pt height=26.76175259999998pt/>

- Cost of capacity expansion:

<p align="center"><img src="/examples/quadradic/tex/0d26930068971ef02557ca1f0dfc5a85.svg?invert_in_darkmode&sanitize=true" align=middle width=756.48453045pt height=86.50267889999999pt/></p>

## 4, Constraints

When <img src="/examples/quadradic/tex/a08aa3f720eb59983ccb69372a8b620d.svg?invert_in_darkmode&sanitize=true" align=middle width=44.56994024999999pt height=21.18721440000001pt/>, the constraints are the same as those in dynamic model. When <img src="/examples/quadradic/tex/de8eee40443fcbaf76ac873e40ccc291.svg?invert_in_darkmode&sanitize=true" align=middle width=78.40560584999999pt height=21.18721440000001pt/>, besides the constraints that all variables are non-negative, there many ten sets of constraints:

1. limit of timber amount in wood production:

<p align="center"><img src="/examples/quadradic/tex/ffc9eedc722fe451ea0fbe96ae63927f.svg?invert_in_darkmode&sanitize=true" align=middle width=364.92959744999996pt height=41.9486826pt/></p>

2. limit of timber amount in pulp and paper production:

<p align="center"><img src="/examples/quadradic/tex/620567475c0888e96f18984d417f6388.svg?invert_in_darkmode&sanitize=true" align=middle width=617.2434774pt height=59.1786591pt/></p>

3. limit of pulp amount in paper production:

<p align="center"><img src="/examples/quadradic/tex/66b3a7c5988dc1ccb4a7b0d36d3e9237.svg?invert_in_darkmode&sanitize=true" align=middle width=343.18696994999993pt height=21.469790099999997pt/></p>

4. limit of wood amount in selling:

<p align="center"><img src="/examples/quadradic/tex/b7c1f237d96d57f9e10bf0b854331c10.svg?invert_in_darkmode&sanitize=true" align=middle width=339.7693233pt height=37.90293045pt/></p>

5. limit of pulp amount in selling:

<p align="center"><img src="/examples/quadradic/tex/a7a5ffa153a30f3921e3f987517c4e4a.svg?invert_in_darkmode&sanitize=true" align=middle width=446.6264913pt height=37.90293045pt/></p>

6. limit of paper amount in selling:

<p align="center"><img src="/examples/quadradic/tex/7648147f3d5b1911c43d9f192d9ed01d.svg?invert_in_darkmode&sanitize=true" align=middle width=290.3867472pt height=37.90293045pt/></p>

7. limit of capacity in saw mill:

<p align="center"><img src="/examples/quadradic/tex/ddea00002a798a378239a083ed553ab9.svg?invert_in_darkmode&sanitize=true" align=middle width=293.7277167pt height=66.10372725pt/></p>

8. limit of capacity in plywood mill:

<p align="center"><img src="/examples/quadradic/tex/e25080d3f390be8c5ee999247c4e1b3d.svg?invert_in_darkmode&sanitize=true" align=middle width=326.4278952pt height=38.90747685pt/></p>

9. limit of capacity in pulp production:

<p align="center"><img src="/examples/quadradic/tex/3b809b1ba2092018ef16ebc6da507d56.svg?invert_in_darkmode&sanitize=true" align=middle width=280.88171925pt height=20.95157625pt/></p>

10. limit of capacity in paper production:

<p align="center"><img src="/examples/quadradic/tex/ccbc19add29235e7d674accd5dc95839.svg?invert_in_darkmode&sanitize=true" align=middle width=258.96496725pt height=16.438356pt/></p>

11. relation between capacity expansion factors

<p align="center"><img src="/examples/quadradic/tex/093c5077d93657dcfaddcfd524d62a28.svg?invert_in_darkmode&sanitize=true" align=middle width=155.37469695pt height=88.58448225pt/></p>
