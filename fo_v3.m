function[pop] = fo(pop, CL, CDo, CDf, n_populacao, n)
	for i = 1:n_populacao
		soma = 0;
		S = ((pop(i, 1)+pop(i, 2))*pop(i, 3))/2;
		A = (pop(i, 3)^2)/S;
		CDi = CL^2/(pi*A);
		CD = CDo+CDf+CDi;
		res = CL^(3/2)/CD;
		pop(i, (2*n)+1) = res;
	end  