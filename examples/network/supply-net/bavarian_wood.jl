module bavarian_wood

using JuMP
using Cbc
using CSV

function solve_bavarian_wood()

    n = 10;

    Q = 25;
    h = 5;

    K = 8;
    o = [ 1  1  2  2  3  3  4  4  ];
    d = [ 9  10 9  10 9  10 9  10 ];
    L = [ 28 14 42 35 39 18 19 31 ];

    R = [
        (1,5) (1,7) (1,8) (1,9) (1,10) #=	why this #= =# stuff? because otherwise
    =#  (2,5) (2,7) (2,8) (2,9) (2,10) #=	Julia interprets it as 8 different rows
    =#  (3,5) (3,7) (3,8) (3,9) (3,10) #=	but it is just one row of pairs. I want
    =#  (4,6) (4,7) (4,8) (4,9) (4,10) #=	to display it in 8 rows in the code to
    =#  (5,7) (5,8) (5,9) (5,10)       #=	increase readability. See further dis-
    =#  (6,7) (6,8) (6,9) (6,10)       #=    cussion here: https://github.com/JuliaLang/julia/issues/27533
    =#  (7,8) (7,9) (7,10)             #=
    =#  (8,10)
    ];

    N = [5 6 7 8];

    N_out = [
    #=  1 =# (5, 7, 8, 9, 10)
    #=  2 =# (5, 7, 8, 9, 10)
    #=  3 =# (5, 7, 8, 9, 10)
    #=  4 =# (6, 7, 8, 9, 10)
    #=  5 =# (7, 8, 9, 10)
    #=  6 =# (7, 8, 9, 10)
    #=  7 =# (8, 9, 10)
    #=  8 =# (10)
    #=  9 =# ()
    #= 10 =# ()
    ];

    N_in = [
    #=  1 =# ()
    #=  2 =# ()
    #=  3 =# ()
    #=  4 =# ()
    #=  5 =# (1, 2, 3)
    #=  6 =# (4)
    #=  7 =# (1, 2, 3, 4, 5, 6)
    #=  8 =# (1, 2, 3, 4, 5, 6, 7)
    #=  9 =# (1, 2, 3, 4, 5, 6, 7)
    #= 10 =# (1, 2, 3, 4, 5, 6, 7, 8)
    ];

    c = [
        Inf	Inf	Inf	Inf	280	Inf	530	830	780	1000;
        Inf	Inf	Inf	Inf	245	Inf	495	795	745	965;
        Inf	Inf	Inf	Inf	175	Inf	425	725	675	895;
        Inf	Inf	Inf	Inf	Inf	220	670	680	920	850;
        Inf	Inf	Inf	Inf	Inf	Inf	250	550	500	720;
        Inf	Inf	Inf	Inf	Inf	Inf	450	460	700	630;
        Inf	Inf	Inf	Inf	Inf	Inf	Inf	300	250	470;
        Inf	Inf	Inf	Inf	Inf	Inf	Inf	Inf	Inf	170;
        Inf	Inf	Inf	Inf	Inf	Inf	Inf	Inf	Inf	Inf;
        Inf	Inf	Inf	Inf	Inf	Inf	Inf	Inf	Inf	Inf;
    ]

    model = Model(with_optimizer(Cbc.Optimizer));

    @variable(model, x[1:n,1:n,1:K] >= 0)
    @variable(model, y[1:n,1:n] >= 0, Int)

    @objective(model, Min, sum( c[i,j]*y[i,j] for (i,j) in R ) +
        sum(
            sum(
                sum(
                    h*x[j,i,k]
                for j in N_in[i] )
            for i in N )
        for k in 1:K ));

    @constraint(model,[k in 1:K,i = o[k]], sum(x[i,j,k] for j in N_out[i]) == L[k]);
    @constraint(model,[k in 1:K,j = d[k]], sum(x[i,j,k] for i in N_in[j]) == L[k]);
    @constraint(model,[(i,j) in R], sum(x[i,j,k] for k in 1:K) <= Q*y[i,j]);

    f = open("bavarian_wood.lp", "w")
    print(f, model)
    close(f)

    #-------
    # SOLVE
    #-------

    optimize!(model)

    #------------------------
    # WRITE SOLUTION TO FILE
    #------------------------

    f = open("bavarian_wood.csv","w");

    for k in 1:K
        print(f,"commodity ",o[k],"-",d[k]," - qty = ",L[k]);
        for (i,j) in R
            if (value(x[i,j,k]) > 0)
                println(f,",route ",i,"-",j,",",value(x[i,j,k]));
            end
        end
    end

    for (i,j) in R
        if (value(y[i,j]) != 0)
            print(f,"route ",i,"-",j," - ",value(y[i,j])," trucks");
            for k in 1:K
                if (value(x[i,j,k]) != 0)
                    println(f,",commodity ",o[k],"-",d[k],",",value(x[i,j,k]));
                end
            end
        end
    end

    close(f);

end

solve_bavarian_wood();

end
