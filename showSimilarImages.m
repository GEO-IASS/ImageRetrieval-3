function showSimilarImages(Pz_d, queryIds, k)

for q = queryIds
    t = query(Pz_d(:,q), Pz_d, k+1, q);
%     ids = setdiff(query(Pz_d(:,q), Pz_d, k+1, q), q);
    figure
    showImages(Pz_d, q)
%     subtitle(
    showImages(Pz_d, t);
end
end
