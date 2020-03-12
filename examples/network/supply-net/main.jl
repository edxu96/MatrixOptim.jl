
using JuMP
using Gurobi
using CSV

function get_data()
  c_ij = CSV.read("supplier_costs.csv"; header = 0);

  return c_ij
end


function optim()
  
end


function main()
  c_ij = get_data()


end
