function[filho] = recombinacaov3(pop, n, tam_pop_filho, CrMin, CrMax, CtMin, CtMax, bMin, bMax, n_populacao)
% utilizando o (mi + lambda)
%xi=1;
%sigmai=n+1;
sucesso=0;
maior=-1;
it=1;
%filho=gera_populacao(tam_pop_filho, n, CrMin, CrMax, CtMin, CtMax, bMin, bMax)
[g k] = max(pop(:,n*2+1));
filho(1,:) = pop(k, :);
for i = 2:tam_pop_filho
	new = gera_populacao(1, n, CrMin, CrMax, CtMin, CtMax, bMin, bMax);
	pai1 = randi(n_populacao,1,1); %rand de 1 a tamanho
	pai2 = randi(n_populacao,1,1); %rand de 1 a tamanho
	b = rand;
	
	% Faz a selecao de pais viaveis
	while pop(pai1,(2*n)+1)<0 
		pai1 = randi(n_populacao,1,1); %rand de 1 a tamanho
	end
	
	while pop(pai2,(2*n)+1)<0 
		pai2 = randi(n_populacao,1,1); %rand de 1 a tamanho
	end

	if (pop(pai1,(2*n+1)) > pop(pai2,(2*n+1)))
			new(1, 1:2) = pop(pai1, 1:2);
			new(1, 3:n*2+1) = pop(pai2, 3:n*2+1);
	else
			new(1, 1:2) = pop(pai1, 1:2);
			new(1, 3:n*2+1) = pop(pai2, 3:n*2+1);
	end
	filho(i,:) = new(1,:);
end
