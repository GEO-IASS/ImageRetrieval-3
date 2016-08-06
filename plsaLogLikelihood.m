function ll = plsaLogLikelihood(V,Pz,Pw_z, Pd_z)

ltemp = zeros(size(V));
for i=1:numel(Pz)
    ltemp = ltemp + Pz(i) * (Pw_z(:,i) * Pd_z(:,i)');
%     ll = ll + V(:,i)'*log(Pd_z*diag(Pz)*Pw_z(i,:)'+1);
end
ll = V .* log(ltemp);
ll = sum(ll(:));
end