function[pop] = gera_populacao(n_populacao, n, CrMin, CrMax, CtMin, CtMax, bMin, bMax)
    b = bMin + (bMax-bMin)*rand(n_populacao,1);
    cr = CrMin + (CrMax-CrMin)*rand(n_populacao,1);
    ct = CtMin + (CtMax-CtMin)*rand(n_populacao,1);
    
    pop(:,1) = cr(:,:);
    pop(:,2) = ct(:,:);
    pop(:,3) = b(:,:);
    pop(:, n+1:n*2) = rand(n_populacao,n); %colunas dos sigmas
    pop(:, n*2+1)= 0; % zera a coluna do fitness e dos sigmas

end
