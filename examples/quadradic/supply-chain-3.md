
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

<p align="center"><img src="/examples/quadradic/tex/153eab036a17f82b21b7f84570eb9d93.svg?invert_in_darkmode&sanitize=true" align=middle width=676.96246365pt height=78.5391552pt/></p>

1. cost of timber procurement: <img src="/examples/quadradic/tex/9ef2df73999b9e34cebc98b451a23586.svg?invert_in_darkmode&sanitize=true" align=middle width=256.1740203pt height=27.91243950000002pt/>

2. cost of wood production: <img src="/examples/quadradic/tex/a0f688b49aee6538fa36879fc524c813.svg?invert_in_darkmode&sanitize=true" align=middle width=162.26319779999997pt height=27.91243950000002pt/>

3. cost of pulp and paper production: <img src="/examples/quadradic/tex/a530cd9609956ba8e65a443c56475442.svg?invert_in_darkmode&sanitize=true" align=middle width=310.38598469999994pt height=27.6567522pt/>

4. profit of left timbers selling:

<p align="center"><img src="/examples/quadradic/tex/29e061fbccb1cdb13491df5948921c0e.svg?invert_in_darkmode&sanitize=true" align=middle width=721.82700315pt height=59.1786591pt/></p>

5. profit of fuel wood selling: <img src="/examples/quadradic/tex/f624dba7a12f224efaaec04a32aad3fa.svg?invert_in_darkmode&sanitize=true" align=middle width=166.68490904999996pt height=27.91243950000002pt/>

6. profit of wood selling: <img src="/examples/quadradic/tex/0c4e7e23ad978a37aec9bd257668e5ff.svg?invert_in_darkmode&sanitize=true" align=middle width=437.61380849999995pt height=27.91243950000002pt/>

7. profit of pulp selling: <img src="/examples/quadradic/tex/70ac47ca6310863c27a5092a714beac4.svg?invert_in_darkmode&sanitize=true" align=middle width=440.7265269pt height=27.91243950000002pt/>

8. profit of paper selling: <img src="/examples/quadradic/tex/3aa7ad0308485051febfb1dbd22269e8.svg?invert_in_darkmode&sanitize=true" align=middle width=431.52199035pt height=26.76175259999998pt/>

9. cost of capacity expansion:

<p align="center"><img src="/examples/quadradic/tex/42b04216e12a859680f3ba69e0318d4e.svg?invert_in_darkmode&sanitize=true" align=middle width=732.42427005pt height=86.50267889999999pt/></p>

## 4, Constraints

Besides the constraints that all variables are non-negative, there many ten sets of constraints:

1. limit of timber amount in wood production:

<p align="center"><img src="/examples/quadradic/tex/84d301a60a213be364e66b5ed77689c1.svg?invert_in_darkmode&sanitize=true" align=middle width=266.16246689999997pt height=41.9486826pt/></p>

2. limit of timber amount in pulp and paper production:

<p align="center"><img src="/examples/quadradic/tex/032abd4d20e696a69e2b4706ce7a9d9b.svg?invert_in_darkmode&sanitize=true" align=middle width=506.44621829999994pt height=59.1786591pt/></p>

3. limit of pulp amount in paper production:

<p align="center"><img src="/examples/quadradic/tex/bf2ad5901b00c22350eff8fe62496778.svg?invert_in_darkmode&sanitize=true" align=middle width=256.4499696pt height=21.469790099999997pt/></p>

4. limit of wood amount in selling:

<p align="center"><img src="/examples/quadradic/tex/ba92ba5ca127dfd696d7378a84b2773c.svg?invert_in_darkmode&sanitize=true" align=middle width=229.83205575pt height=37.90293045pt/></p>

5. limit of pulp amount in selling:

<p align="center"><img src="/examples/quadradic/tex/bfad9e837928c6b95cee808a7e0c7644.svg?invert_in_darkmode&sanitize=true" align=middle width=347.85936075pt height=37.90293045pt/></p>

6. limit of paper amount in selling:

<p align="center"><img src="/examples/quadradic/tex/13a029c6d928d57f76e9447e7de78312.svg?invert_in_darkmode&sanitize=true" align=middle width=213.94654379999997pt height=37.90293045pt/></p>

7. limit of capacity in saw mill:

<p align="center"><img src="/examples/quadradic/tex/161b50a8d5880c70e720faea41a2e242.svg?invert_in_darkmode&sanitize=true" align=middle width=201.34612575pt height=37.775108249999995pt/></p>

8. limit of capacity in plywood mill:

<p align="center"><img src="/examples/quadradic/tex/1a4d177cdf3eef267931af94fbf2ff37.svg?invert_in_darkmode&sanitize=true" align=middle width=251.7210234pt height=38.90747685pt/></p>

9. limit of capacity in pulp production:

<p align="center"><img src="/examples/quadradic/tex/82647487eda6cf4aa1cb82ea61248bbc.svg?invert_in_darkmode&sanitize=true" align=middle width=206.1748491pt height=20.95157625pt/></p>

10. limit of capacity in paper production:

<p align="center"><img src="/examples/quadradic/tex/a87f0eeebd6e3b5251b085afe08f65fd.svg?invert_in_darkmode&sanitize=true" align=middle width=184.25809544999998pt height=15.805440749999999pt/></p>

11. relation between capacity expansion factors

<p align="center"><img src="/examples/quadradic/tex/093c5077d93657dcfaddcfd524d62a28.svg?invert_in_darkmode&sanitize=true" align=middle width=155.37469695pt height=88.58448225pt/></p>
