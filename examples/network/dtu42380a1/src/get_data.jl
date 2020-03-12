## Optimization Model for dtu42380a1
## Mar 11, 2020

# function get_data(args)
L = 3; # number of locations
P = 3; # number of products
T = 4; # number of periods
S = 11;  # number of materials

pi = [
    0.7	0	0	1.2	0.3 1	0	0	3	2	0
    0	0.6	0	1.2	0   0	1	0	3	2	1
    0	0	0.8	1.2	0.3 0	0	1	3	2	1
]; # pi[p,s] gives amount of material s needed to produce one unit of product p

muB = [4 5 6]; # muB[p] gives the number of seconds of preblend machine time needed to produce one unit of product p
muP = [2 2 2]; # muP[p] gives the number of seconds of packaging machine time needed to package one unit of product p

c = [4 5 4 10 3 20 20 20 15 15 30]; # c[s] gives the cost for sourcing one unit of material s

cBR = 0.07; # Blending machine regular time cost per second
cBO = 0.18; # Blending machine overtime cost per second

cPR = 0.058; # Packaging machine regular time cost per second
cPO = 0.075; # Packaging machine overtime cost  per second

h = [0.2 0.3 0.3]; # h[p] gives the inventory holding cost for product p

## I0[ip] gives the initial inventory of product p at location i
I0 = [
    2368	1834	1940
    1743	1500	2910
    4307	1799	3100
];

## D[i,p,t] gives the demand forecast for product p at location i in period t
D = zeros(L,P,T);
D[1,:,:] = [
    40539	40997	39855	38574
    20854	21562	21925	22315
    9502	8975	9347	9958
];
D[2,:,:] = [
    55948	55804	55292	53866
    38245	39364	39409	39380
    16888	16617	14462	13666
];
D[3,:,:] = [
    49559	50155	48959	46259
    27461	27718	26460	27059
    6738	10495	11565	13377
];

## ss[i,p,t] gives the safety stock needed of product p at location i in period t
ss = [
    2110	1243	814
    1650	1488	3046
    4172	1734	3014
];
# make safety stock for the rest of the periods the same
for t = 2:T
    global ss = cat(ss,ss,dims = 3);
end

## penalty for not satisfying one unit of demand
PI = 1000000; 
