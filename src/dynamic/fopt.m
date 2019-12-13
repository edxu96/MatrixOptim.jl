

function loss = fopt(u)
	loss = sum((u - [1; 3]).^2) + 1;
end
