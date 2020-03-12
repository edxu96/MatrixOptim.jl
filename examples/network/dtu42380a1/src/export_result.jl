## Optimization Model for dtu42380a1
## Mar 11, 2020

f = open("prod_plan.csv","w");

println(f, ",,Demand,,,Production,,,Inventory,,,Capacity,,,,Unmet demand,,,");
println(f, "DC,Period,Product 1,Product 2,Product 3,Product 1,Product 2,Product 3,Product 1,Product 2,Product 3,Blend (RT),Blend (OT), Pack(RT), Pack(OT),Product 1,Product 2,Product 3");

for i = 1:L
    for t = 1:T
        print(f,i,",",t,",");
        for p = 1:P
            print(f, D[i,p,t],",");
        end
        for p = 1:P
            print(f,value(x[i,p,t]),",");
        end
        for p = 1:P
            print(f,value(I[i,p,t]),",");
        end
        print(f, sum(value(mBR[i,p,t]) for p = 1:P) ,",");
        print(f, sum(value(mBO[i,p,t]) for p = 1:P) ,",");
        print(f, sum(value(mPR[i,p,t]) for p = 1:P) ,",");
        print(f, sum(value(mPO[i,p,t]) for p = 1:P) ,",");
        for p = 1:P
            print(f,value(delta[i,p,t]),",");
        end
        println(f,"");
    end
end

close(f);
