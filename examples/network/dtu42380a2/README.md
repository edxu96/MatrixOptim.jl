---
for: MatrixOptim.jl/examples/network/dtu42380a2
author: Edward J. Xu
date: April 9, 2020
---

# DTU42380a2: Supply Networks and Inventory

## 1. Tables

<p align="center"><img src="/examples/network/dtu42380a2/tex/a3158c98a89c87e55d5211ccb6b0168a.svg?invert_in_darkmode&sanitize=true" align=middle width=358.31081385pt height=120.32873654999999pt/></p>

_Table 1. symbols and definitions of sets._

<p align="center"><img src="/examples/network/dtu42380a2/tex/63ba5bd96a565805246786ca412ce656.svg?invert_in_darkmode&sanitize=true" align=middle width=296.98673565pt height=120.32873654999999pt/></p>

_Table 2. symbols and definitions of plans._

<p align="center"><img src="/examples/network/dtu42380a2/tex/46a2ca15b7d7adbec7edb8efe6a89b19.svg?invert_in_darkmode&sanitize=true" align=middle width=541.0358745pt height=84.10510679999999pt/></p>

_Table 3. symbols and definitions of decision variables._

<p align="center"><img src="/examples/network/dtu42380a2/tex/5956bf7924dc62634933540139d96ef4.svg?invert_in_darkmode&sanitize=true" align=middle width=356.34182925pt height=165.0311784pt/></p>

_Table 4. symbols and definitions of constants_

## 2. the Model

<p align="center"><img src="/examples/network/dtu42380a2/tex/064c60b18fbd20544577b8931205977a.svg?invert_in_darkmode&sanitize=true" align=middle width=734.63708505pt height=290.38941195pt/></p>

## 3. Results

<p align="center"><img src="/examples/network/dtu42380a2/tex/83392464efb5527966438a929263f534.svg?invert_in_darkmode&sanitize=true" align=middle width=441.46196819999994pt height=80.87668215pt/></p>

_Table 5. optimized leasing decisions for small warehouses._

<p align="center"><img src="/examples/network/dtu42380a2/tex/81fa81213308fbece09bd7ee30250db8.svg?invert_in_darkmode&sanitize=true" align=middle width=441.46196819999994pt height=80.87668215pt/></p>

_Table 6. optimized leasing decisions for large warehouses_

<p align="center"><img src="/examples/network/dtu42380a2/tex/0eb1d72224447312935f052564e7e22c.svg?invert_in_darkmode&sanitize=true" align=middle width=463.51677075000003pt height=80.87668215pt/></p>

_Table 7. optimized inventory decisions for large warehouses_

```
objective_value(model) = -1.034e7
3×5 Array{Float64,2}:
 0.0  0.0  0.0  0.0  0.0
 0.0  0.0  0.0  0.0  0.0
 0.0  0.0  0.0  0.0  0.0
3×5 Array{Float64,2}:
 0.0  0.0  0.0  1.0  0.0
 1.0  0.0  0.0  1.0  0.0
 1.0  0.0  0.0  1.0  1.0
3×5 Array{Float64,2}:
 0.0  0.0  0.0  0.0  0.0
 0.0  0.0  0.0  0.0  0.0
 0.0  0.0  0.0  0.0  0.0
3×5 Array{Float64,2}:
 0.0  0.0  0.0  1.0  0.0
 1.0  0.0  0.0  1.0  0.0
 1.0  0.0  0.0  1.0  1.0
x = 2.85e6 when s = 1 and l = 4.
x = 1.976e6 when s = 2 and l = 1.
x = 3.439e6 when s = 2 and l = 4.
x = 3.7544e6 when s = 3 and l = 1.
x = 4.0e6 when s = 3 and l = 4.
x = 2.5341e6 when s = 3 and l = 5.
```
