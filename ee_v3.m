% Utilizano estrategia evoutiva 
%Tipo (mi,lambda) onde o numero de filhos e´ maior q o numero dos pais

clear
n_populacao = 20; %tamanho da população  
n = 3; %dimensão do array / colunas hehe
prob_cruzamento = .6; %probabilidade de cruzamento
prob_mutacao = .2; %probabilidade de mutacao
tam_pop_filho = 30;

%Constantes do problema
CDo = 0.0125; %(Coeficiente de arrasto parasita da asa para α = 0°, aproximado do perfil TKV2008)
p = 1.0915; %kg/m 3 (Massa específica do ar a 1100m de altitude)
v = 15; %m/s (Considera-se com se a aeronave estivesse parada e o vento passando-se por ela)
CL = 0.8; %(Coeficiente de sustentação para ângulo da asa ‘α’ de 0°)
CDf = 0.02; %(Coeficiente de arrasto da fuselagem para α = 0°)
W = 100; %N (Peso da aeronave + carga carregada)
T = 12; %N (Tração, supondo comportamento motor O.S 61FX, hélice 13x4”)


% intervalo de variaveis que determinam uma solucao viavel
CrMin = 0.3; %Corda de raiz da asa mínima
CrMax = 0.6; %Corda de raiz da Asa Máxima
CtMin = 0.15; %Corda de ponta da asa mínima
CtMax = 0.3; %Corda de ponta da asa Máxima
bMin = 2; %Envergadura da asa mínima;
bMax = 3.5; %Envergadura da asa máxima;



%janela = 15;%janela de melhores fitness/O melhor+janela
pop = gera_populacao(n_populacao, n, CrMin, CrMax, CtMin, CtMax, bMin, bMax);
RUNTIME = 60;
iter = 1;
timerID = tic;
m = 0;
%iter < 10000 || 
toc(timerID) < RUNTIME
while (iter < 100)
	for geracoes = 1: 50
		pop = fo_v3(pop, CL, CDo, CDf,n_populacao, n);
		pop = restricao_v3(pop, n_populacao, n);
%
		pop_filhos = recombinacao_v3(pop, n, tam_pop_filho, CrMin, CrMax, CtMin, CtMax, bMin, bMax, n_populacao);	%recombinação
		pop_filhos = restricao_v3(pop_filhos, tam_pop_filho,n);
		pop_filhos = fo_v3(pop_filhos, CL, CDo, CDf,tam_pop_filho, n);

		pop_filhos_mutados = mutacao_v3(pop_filhos, tam_pop_filho, n); %Nova população com os filhos mutados
		pop_filhos_mutados = restricao_v3(pop_filhos_mutados, tam_pop_filho,n); %calcula fitness da pop dos filhos
		pop_filhos_mutados = fo_v3(pop_filhos_mutados, CL, CDo, CDf,tam_pop_filho, n);

%
		pop = selecao_v3(pop_filhos, pop_filhos_mutados, tam_pop_filho, n, n_populacao);%faz a regra de 1/5 e seleciona os melhores para a prox geração
		pop=fo_v3(pop, CL, CDo, CDf,n_populacao, n);

		pop = sortrows(pop, -(n*2+1));
		resmed_g(geracoes) = mean(pop(:,n*2+1));
		resmin_g(geracoes) = min(pop(:,n*2+1));
		resmax_g(geracoes) = max(pop(:,n*2+1));
		if resmax_g(geracoes) > m
			m = resmax_g(geracoes);
			melhor = pop(1,:);
		end
	end
	resmed(iter) = mean(resmed_g);
	resmin(iter) = min(resmin_g);
	resmax(iter) = max(resmax_g);
	
	iter = iter+1;
end
toc(timerID)
plot(resmin, 'g')
hold on
plot(resmed, 'b')
hold on
plot(resmax, 'r')
legend('Minimo','Medio', 'Maximo')
media = mean(resmin)
minimo = min(resmin)
maximo = max(resmax)
dpmed = std(resmed)
dpmin = std(resmin)
melhor


%pop = calculo_sigma(pop, n_populacao, n);

%atualiza x e sigma