function [pop_mutados] = mutacao(pop_filhos, n_populacao, n)
	pop_mutados = pop_filhos;
	for j = 1:n_populacao
		normal = randn;
		for i = 1:n
			pop_mutados(j, i) = pop_filhos(j, i)+(pop_filhos(j, n+i)*normal);
			%pop_mutados(j, i) = pop_mutados(j, i)+.5;
		end
	end
end