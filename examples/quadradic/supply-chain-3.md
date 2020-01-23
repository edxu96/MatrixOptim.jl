
# Metsa-Oy Production and Supply Chain 3: Stochastic Dynamic

## 1, Introduction

## 2, Definition of Mathematical Expressions

<p align="center"><img src="/examples/quadradic/tex/50220e9df8aa71e1f6400321ad0b7c20.svg?invert_in_darkmode&sanitize=true" align=middle width=679.5676040999999pt height=396.97115204999994pt/></p>

_Table 1, summary of sets_

<p align="center"><img src="/examples/quadradic/tex/cf61a5bb7805cac098934981614a7b21.svg?invert_in_darkmode&sanitize=true" align=middle width=855.4807404pt height=469.3945311pt/></p>

_Table 2, summary of decision variables_

<p align="center"><img src="/examples/quadradic/tex/5b397e525492622299d4993f12ad5f59.svg?invert_in_darkmode&sanitize=true" align=middle width=759.1170212999999pt height=744.9944733pt/></p>

_Table 3, summary of constants_

## 3, Objective Function

The Objective function composes of many parts:

<p align="center"><img src="/examples/quadradic/tex/f510bdb99fec8650c01a20e8bbec9304.svg?invert_in_darkmode&sanitize=true" align=middle width=686.5706594999999pt height=78.5391552pt/></p>

- When m = 1, the variables are here-and-now decisions variables, and this part of the objective function is the same as those in the static model:

1. cost of timber procurement: <img src="/examples/quadradic/tex/75523156026f00a6d598b4ba9ac9fbc1.svg?invert_in_darkmode&sanitize=true" align=middle width=225.03610634999995pt height=27.91243950000002pt/>

2. cost of wood production: <img src="/examples/quadradic/tex/59f0c6e89f79532a2e60684c71947bd5.svg?invert_in_darkmode&sanitize=true" align=middle width=149.35345919999997pt height=27.91243950000002pt/>

3. cost of pulp and paper production: <img src="/examples/quadradic/tex/eb41c7351a74af51cbb40949a8a4fcac.svg?invert_in_darkmode&sanitize=true" align=middle width=242.45478509999998pt height=27.6567522pt/>

4. profit of left timbers selling:

<p align="center"><img src="/examples/quadradic/tex/35099bea2233d526f210f053f46a6fe0.svg?invert_in_darkmode&sanitize=true" align=middle width=659.45019525pt height=59.1786591pt/></p>

5. profit of fuel wood selling: <img src="/examples/quadradic/tex/b477f842f851b9a0d69dd7dcf12b6ca5.svg?invert_in_darkmode&sanitize=true" align=middle width=153.77517044999996pt height=27.91243950000002pt/>

6. profit of wood selling: <img src="/examples/quadradic/tex/fe9d9ea09e3891a788b8bde8f0805149.svg?invert_in_darkmode&sanitize=true" align=middle width=281.8592964pt height=27.91243950000002pt/>

7. profit of pulp selling: <img src="/examples/quadradic/tex/ab9091bad3b8c3d3fe015769854eee38.svg?invert_in_darkmode&sanitize=true" align=middle width=283.33392285pt height=31.780732499999996pt/>

8. profit of paper selling: <img src="/examples/quadradic/tex/35a3eb5f73102153a87eb2d050d6a8e4.svg?invert_in_darkmode&sanitize=true" align=middle width=312.3548339999999pt height=25.70766330000001pt/>

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

<p align="center"><img src="/examples/quadradic/tex/aa5777dad7fc4a20b461c70e45b75ec2.svg?invert_in_darkmode&sanitize=true" align=middle width=744.4544002499999pt height=86.50267889999999pt/></p>

where variables regarding capacities in the first year, like <img src="/examples/quadradic/tex/38083a80fd93637bf89cc3440ee4a046.svg?invert_in_darkmode&sanitize=true" align=middle width=30.36197504999999pt height=21.839370299999988pt/>, are fixed value variables, those in the second year are here-and-now decision variables, and those in the third year are wait-and-see variables. Those here-and-now decision variables are forced to be equal for different scenarios by constraints 7-10 in the following section.  

## 4, Constraints

When <img src="/examples/quadradic/tex/a08aa3f720eb59983ccb69372a8b620d.svg?invert_in_darkmode&sanitize=true" align=middle width=44.56994024999999pt height=21.18721440000001pt/>, the constraints are the same as those in dynamic model, which are neglected here. When <img src="/examples/quadradic/tex/de8eee40443fcbaf76ac873e40ccc291.svg?invert_in_darkmode&sanitize=true" align=middle width=78.40560584999999pt height=21.18721440000001pt/>, besides the constraints that all variables are non-negative, there many ten sets of constraints:

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

<p align="center"><img src="/examples/quadradic/tex/9e5f28e6917906bcdbfb9a1474edfd97.svg?invert_in_darkmode&sanitize=true" align=middle width=329.16755355pt height=69.63788865pt/></p>

9. limit of capacity in pulp production:

<p align="center"><img src="/examples/quadradic/tex/e6052920e5c407b94c09850de256d7a1.svg?invert_in_darkmode&sanitize=true" align=middle width=304.94197965pt height=48.478473449999996pt/></p>

10. limit of capacity in paper production:

<p align="center"><img src="/examples/quadradic/tex/33153e97b3d700fb293e5ff0654c7edf.svg?invert_in_darkmode&sanitize=true" align=middle width=258.96496725pt height=45.634419599999994pt/></p>

11. relation between capacity expansion factors

<p align="center"><img src="/examples/quadradic/tex/093c5077d93657dcfaddcfd524d62a28.svg?invert_in_darkmode&sanitize=true" align=middle width=155.37469695pt height=88.58448225pt/></p>

## 4, Results

obj = <img src="/examples/quadradic/tex/2697d667ebe19821eed939af7ae65c89.svg?invert_in_darkmode&sanitize=true" align=middle width=61.535618099999986pt height=21.18721440000001pt/>
