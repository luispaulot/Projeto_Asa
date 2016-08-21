function[pop] = restricao_v3(pop, n_populacao,n)
	quantidade = 0;
	
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

	
	%Verificando REstrições
	for i = 1:n_populacao
		S = ((pop(i, 1)+pop(i, 2))*pop(i, 3))/2;
		A = (pop(i, 3)^2)/S;
		CDi = CL^2/(pi*A);
		CD = CDo+CDf+CDi;
		D = 0.5*p*v^2*S*CD;
		L = 0.5*p*v^2*S*CL;

		penal=rand;

		
		%Restrição D<=T
			if (D > T)
				pop(i, (2*n)+1) = -1;%desclassificado
			end
		%Restrição L>=W
			if (L < W)
				pop(i, (2*n)+1) = -1;%desclassificado
			end

			%Penaliza as vari´aveis q fugiram do intervalo
		%Verifica intervalo Cr
			if (CrMin > pop(i,1)) | (CrMax < pop(i,1))
				pop(i,(2*n)+1) = -1;%desclassificado
				pop(i,1)= CrMin + (CrMax-CrMin)*rand(1,1);
			end 
		%Verifica intervalo Ct
			if (CtMin > pop(i,2)) | (CtMax < pop(i,2))
				pop(i, (2*n)+1) = -1;%desclassificado
				pop(i,2)=CtMin + (CtMax-CtMin)*rand(1,1);;
			end 
		%Verifica intervalo b
			if (bMin > pop(i,3)) | (bMax < pop(i,3))
				pop(i, (2*n)+1) = -1;%desclassificado
				pop(i,1)= bMin + (bMax-bMin)*rand(1,1);
			end 

	end
	

