module supply_allocation

using JuMP
using Cbc
using CSV

function solve_supply_allocation()

    #------
    # DATA
    #------

    n = 4;
    m = 3;
    Q = [30 15 20 35];
    d = [40 10 35];

    c = [
        40	39	40;
        35	36	31;
        33	43	42;
        37	35	38
    ];

    #------
    # MODEL
    #------

    model = Model(with_optimizer(Cbc.Optimizer));

    @variable(model, x[1:n,1:m] >= 0)

    @objective(model, Min, sum(c[i,j] * x[i,j] for i in 1:n, j in 1:m));

    @constraint(model,[j = 1:m],sum(x[i,j] for i in 1:n) == d[j]);

    @constraint(model,[i = 1:n],sum(x[i,j] for j in 1:m) <= Q[i]);

    f = open("supply_allocation.lp", "w")
    print(f, model)
    close(f)

    #-------
    # SOLVE
    #-------

    optimize!(model)

    #------------------------
    # WRITE SOLUTION TO FILE
    #------------------------

    f = open("supply_allocation.csv","w");

    print(f,",");
    print(f,"Munich,Salzburg,Prague");
    println(f,"");

    ports = ["Rotterdam" "Wilhelmshaven" "Bremerhaven" "Hamburg" ];

    for i = 1:n
        print(f,ports[i],",");
        for j = 1:m
            print(f,value(x[i,j]),",");
        end
        println(f,"");
    end

    close(f);

end

solve_supply_allocation();

end
