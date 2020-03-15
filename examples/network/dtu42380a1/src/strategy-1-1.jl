## Optimization Model for dtu42380a1
## Strategy I: New production lines
## Mar 11, 2020

using JuMP, Gurobi, CSV

include("./get_data.jl")

model = Model(with_optimizer(Gurobi.Optimizer, Presolve=0, OutputFlag=0));

## PRODUCTION VARIABLES
@variable(model, x[1:L,1:P,1:T] >= 0)
## SOURCE VARIABLES (PREBLENDING AND PACKAGING)
@variable(model, y[1:L,1:S,1:P,1:T] >= 0);
## MACHINE FLOW VARIABLES (ALLOCATION OF REGULAR TIME AND OVERTIME FOR BLENDING AND PACKAGING MACHINES)
@variable(model, mBR[1:L, 1:P, 1:T] >= 0);
@variable(model, mBO[1:L, 1:P, 1:T] >= 0);
@variable(model, mPR[1:L, 1:P, 1:T] >= 0);
@variable(model, mPO[1:L, 1:P, 1:T] >= 0);
## INVENTORY VARIABLES
@variable(model, I[1:L,1:P,1:T] >= 0);
## DEMAND NOT MET VARIABLES
@variable(model, delta[1:L,1:P,1:T] >= 0);

## New decision variables regarding promotion or not
@variable(model, whe_pro[1:L, 1:2], Bin);

## OBJECTIVE FUNCTION
@objective(model, Min, sum( #=
=#           sum(y[i,s,p,t]*c[s] for s = 1:S)    #=  material cost
=#         + mBR[i,p,t]*cBR                      #= regular time blending machine cost
=#         + mBO[i,p,t]*cBO                      #= overtime blending machine cost
=#         + mPR[i,p,t]*cPR                      #= regular time packaging machine cost
=#         + mPO[i,p,t]*cPO                      #= overtime time packaging machine cost
=#         + I[i,p,t]*h[p]                       #= inventory cost
=#         + PI*delta[i,p,t]                     #= unsatisfied demand penalty
=#         for i = 1:L, p = 1:P, t = 1:T)
);

## PROCESS CONSTRAINTS - material and machine inflow must match (according to
##   the requirements) product outflow
@constraint(model, [i = 1:L, p = 1:P, t = 1:T,s = 1:S],
  y[i,s,p,t] == pi[p,s]*x[i,p,t]);
@constraint(model, [i = 1:L, p = 1:P, t = 1:T],
  mBR[i,p,t] + mBO[i,p,t] ==  muB[p]*x[i,p,t]);
@constraint(model, [i = 1:L, p = 1:P, t = 1:T],
  mPR[i,p,t] + mPO[i,p,t] ==  muP[p]*x[i,p,t]);
## CAPACITY CONSTRAINTS
@constraint(model, [i = 1:L, t = 1:T],
  sum(mBR[i,p,t] for p = 1:P) <= 24*5*60*60);
@constraint(model, [i = 1:L, t = 1:T],
  sum(mPR[i,p,t] for p = 1:P) <= 24*5*60*60);
@constraint(model, [i = 1:L, t = 1:T],
  sum(mBO[i,p,t] for p = 1:P) <= 28*60*60);
@constraint(model, [i = 1:L, t = 1:T],
  sum(mPO[i,p,t] for p = 1:P) <= 28*60*60);
## STORAGE CONSTRAINTS - inflow (production and start-of-period inventory) must
##   equal outflow (demand and end-of-period inventory) at each DC

## Constraints regarding promotion
@constraint(model, [i = 1:L, p = 3, t = 1],
  x[i,p,t] + I0[i,p] == I[i,p,t] + D[i,p,t] + 0.3 * whe_pro[i, 1] * D[i,p,t] - delta[i,p,t]);
@constraint(model, [i = 1:L, p = 3, t = 2],
  x[i,p,t] + I[i,p,t-1] == I[i,p,t] + D[i,p,t] + 0.3 * whe_pro[i, 2] * D[i,p,t] - delta[i,p,t]);
@constraint(model, [i = 1:L], whe_pro[i, 1] + whe_pro[i, 2] >= 1)

@constraint(model, [i = 1:L, p = 1:2, t = 1],
  x[i,p,t] + I0[i,p] == I[i,p,t] + D[i,p,t] - delta[i,p,t]);
@constraint(model, [i = 1:L, p = 1:2, t = 2],
  x[i,p,t] + I[i,p,t-1] == I[i,p,t] + D[i,p,t] - delta[i,p,t]);
@constraint(model, [i = 1:L, p = 1:P, t = 3:4],
  x[i,p,t] + I[i,p,t-1] == I[i,p,t] + D[i,p,t] - delta[i,p,t]);

@constraint(model, [i = 1:L, p = 1:P, t = 1:T],
  I[i,p,t] >= ss[i,p,t]);

optimize!(model)
println(value(whe_pro[1, 1]))
println(value(whe_pro[1, 2]))
println(value(whe_pro[2, 1]))
println(value(whe_pro[2, 2]))
println(value(whe_pro[3, 1]))
println(value(whe_pro[3, 2]))
println(objective_value(model))

include("./export_result.jl")
