function [pop] = selecao(pop_filhos, pop_filhos_mutados, tam_pop_filho, n, n_populacao)
	pop_filhos = sortrows(pop_filhos, -(n*2+1));
	pop_filhos_mutados =  sortrows(pop_filhos_mutados, -(n*2+1));
	sucesso = 0;
	for i = 1: tam_pop_filho
		if (pop_filhos(i, n*2+1) > pop_filhos_mutados(i, n*2+1))
			pop_selecao(i,:) = pop_filhos(i,:);
		else
			pop_selecao(i,:) = pop_filhos_mutados(i,:);
			sucesso = sucesso+1;
		end
	end
	%regra de 1/5 Mutação dos sigmas
	k = sucesso/tam_pop_filho;
	if(k < .2)
		for i = 1: tam_pop_filho
			for j = n+1: n*2
				pop_selecao(i, j) = pop_selecao(i, j)*.82;
			end
		end
	else
		for i = 1: tam_pop_filho
			for j = n+1: n*2
				pop_selecao(i, j) = pop_selecao(i, j)*1.22;
			end
		end
	end
	pop_selecao = restricao_v3(pop_selecao,tam_pop_filho,n);
	pop_selecao = sortrows(pop_selecao, -(n*2+1));
	for i = 1 : n_populacao
		pop(i,:) = pop_selecao(i, :);
	end
end

