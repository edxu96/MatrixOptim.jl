
# Metsa-Oy Production and Supply Chain 2: Dynamic

## 1, Introduction

It is assumed that all the products produced are sold in the current year. For example, wood products produced in the first year are sold in the first year only.

## 2, Definition of Mathematical Expressions

<p align="center"><img src="/examples/quadradic/tex/563cda82815e6e35d5d6d9c125bc476d.svg?invert_in_darkmode&sanitize=true" align=middle width=679.5676040999999pt height=377.24512319999997pt/></p>

_Table 1, summary of sets_

<p align="center"><img src="/examples/quadradic/tex/645c3ad049b948ae45c914cb0b0c4d9f.svg?invert_in_darkmode&sanitize=true" align=middle width=723.7834098pt height=243.95743514999998pt/></p>

_Table 2, summary of decision variables_

<p align="center"><img src="/examples/quadradic/tex/8d312b8cee0d06f6ccb8e359ea8bf77e.svg?invert_in_darkmode&sanitize=true" align=middle width=759.1170212999999pt height=704.8848939pt/></p>

_Table 3, summary of constants_

## 3, Objective Function

The Objective function composes of seven parts:

<p align="center"><img src="/examples/quadradic/tex/1ac1da39bc183d4319251012fea9fc08.svg?invert_in_darkmode&sanitize=true" align=middle width=590.4896695499999pt height=37.775108249999995pt/></p>

1. cost of timber procurement: <img src="/examples/quadradic/tex/9ef2df73999b9e34cebc98b451a23586.svg?invert_in_darkmode&sanitize=true" align=middle width=256.1740203pt height=27.91243950000002pt/>

2. cost of wood production: <img src="/examples/quadradic/tex/a0f688b49aee6538fa36879fc524c813.svg?invert_in_darkmode&sanitize=true" align=middle width=162.26319779999997pt height=27.91243950000002pt/>

3. cost of pulp and paper production: <img src="/examples/quadradic/tex/a530cd9609956ba8e65a443c56475442.svg?invert_in_darkmode&sanitize=true" align=middle width=310.38598469999994pt height=27.6567522pt/>

4. profit of left timbers selling:

<p align="center"><img src="/examples/quadradic/tex/29e061fbccb1cdb13491df5948921c0e.svg?invert_in_darkmode&sanitize=true" align=middle width=721.82700315pt height=59.1786591pt/></p>

5. profit of fuel wood selling: <img src="/examples/quadradic/tex/f624dba7a12f224efaaec04a32aad3fa.svg?invert_in_darkmode&sanitize=true" align=middle width=166.68490904999996pt height=27.91243950000002pt/>

6. profit of wood selling: <img src="/examples/quadradic/tex/8354474e12e69ee942aa8eeac3c58182.svg?invert_in_darkmode&sanitize=true" align=middle width=370.7204588999999pt height=27.91243950000002pt/>

7. profit of pulp selling: <img src="/examples/quadradic/tex/e6af97183aa4d9f14e6a3171e2069e80.svg?invert_in_darkmode&sanitize=true" align=middle width=373.83317565pt height=27.91243950000002pt/>

8. profit of paper selling: <img src="/examples/quadradic/tex/18be2a997b4160a88336457a53778454.svg?invert_in_darkmode&sanitize=true" align=middle width=395.76655304999997pt height=26.76175259999998pt/>

9. cost of capacity expansion:

<p align="center"><img src="/examples/quadradic/tex/78e55a113a4226335119bad2aa000c1f.svg?invert_in_darkmode&sanitize=true" align=middle width=862.1789005499999pt height=59.1786591pt/></p>

## 4, Constraints

Besides the constraints that all variables are non-negative, there are ten sets of constraints:

1. limit of timber amount in wood production:

<p align="center"><img src="/examples/quadradic/tex/84d301a60a213be364e66b5ed77689c1.svg?invert_in_darkmode&sanitize=true" align=middle width=266.16246689999997pt height=41.9486826pt/></p>

2. limit of timber amount in pulp and paper production:

<p align="center"><img src="/examples/quadradic/tex/713bfb223a5e9fced1b09fde481e1497.svg?invert_in_darkmode&sanitize=true" align=middle width=506.44621829999994pt height=59.1786591pt/></p>

3. limit of pulp amount in paper production:

<p align="center"><img src="/examples/quadradic/tex/bf2ad5901b00c22350eff8fe62496778.svg?invert_in_darkmode&sanitize=true" align=middle width=256.4499696pt height=21.469790099999997pt/></p>

4. limit of wood amount in selling:

<p align="center"><img src="/examples/quadradic/tex/82468c6f348b4c6e9b73e74691394258.svg?invert_in_darkmode&sanitize=true" align=middle width=241.00219275pt height=37.90293045pt/></p>

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

11. relation between capacities

<p align="center"><img src="/examples/quadradic/tex/093c5077d93657dcfaddcfd524d62a28.svg?invert_in_darkmode&sanitize=true" align=middle width=155.37469695pt height=88.58448225pt/></p>

## 4, Result

obj = <img src="/examples/quadradic/tex/2189081c08ea8c2f5e78942c32592c1c.svg?invert_in_darkmode&sanitize=true" align=middle width=61.535618099999986pt height=21.18721440000001pt/>

```
m = 1 ;
[66.65, 10.15, 10.23, 12.98]
[83.55, 0.0, 5.31, 11.14]
[0.0, 9.47, 33.6, 56.93]
[100.0, 0.0, 0.0, 0.0]
[100.0, 0.0, 0.0, 0.0]
[11.15, 43.77, 2.23, 42.84]
[14.48, 79.32, 0.0, 6.2]
[31.06, 34.24, 7.7, 26.99]

m = 2 ;
[65.95, 10.8, 10.33, 12.92]
[88.24, 0.0, 0.0, 11.76]
[0.0, 0.0, 0.0, 100.0]
[92.96, 7.04, 0.0, 0.0]
[89.25, 10.75, 0.0, 0.0]
[3.32, 48.15, 0.66, 47.87]
[14.15, 79.78, 0.0, 6.07]
[33.71, 29.85, 14.46, 21.98]

m = 3 ;
[65.29, 11.41, 10.42, 12.87]
[88.24, 0.0, 0.0, 11.76]
[0.0, 0.0, 0.0, 100.0]
[93.18, 6.82, 0.0, 0.0]
[88.56, 11.44, 0.0, 0.0]
[9.06, 44.94, 1.81, 44.18]
[15.37, 78.05, 0.0, 6.59]
[33.71, 29.85, 14.46, 21.98]
```
