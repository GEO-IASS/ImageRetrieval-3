function [Pd_z ,Pw_z, Pz, Lt] = plsaFit(V,ntopics,iter)

nwords = size(V, 1);
ndocs = size(V, 2);
Lt = [];

% 3.Randomly initialization and allocation
% ========================================

% P(z), uniform prior distribution
Pz = repmat(1/ntopics, ntopics, 1);

% Pd_z, randomness and normalization
Pd_z = rand(nwords, ntopics);
Pd_z = Pd_z * diag(1./sum(Pd_z, 1));
% Pw_z, randomness and normalization
Pw_z = rand(ndocs, ntopics);
Pw_z = Pw_z * diag(1./sum(Pw_z, 1));

Pz_dw = zeros(nwords, ndocs,ntopics);

% 4.Call EM algorithm to train model and learn parameter
% ======================================================
for i=1:iter
    fprintf('Current iteration:%d...\n', i);
    
    % E-step
    for j = 1:ntopics
       Pz_dw(:,:,j) =  Pz(j) * (Pw_z(:,j) * Pd_z(:,j)');
    end
    
    Pz_dw = bsxfun(@rdivide, (Pz_dw + eps) , sum((Pz_dw + eps),3));
%     Pz_dw = plsaEstep(Pz,Pd_z, Pw_z, Pz_dw);

    % M-step
    for j = 1:ntopics
        temp = V .* Pz_dw(:,:,j);
        Pz(j) = sum(temp(:));
        Pd_z(:,j) = sum(temp,1);
        Pw_z(:,j) = sum(temp,2);
    end
    Pz = normalize(Pz);
    Pw_z = normalize(Pw_z);
    Pd_z = normalize(Pd_z);

    % Likelihood
    le = plsaLogLikelihood(V,Pz,Pw_z, Pd_z);
    Lt = [Lt le];
    fprintf('Likelihood: %f...\n', le);
end



