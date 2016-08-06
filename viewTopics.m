function viewTopics(Pw_z, Pz_d)
ntopics = size(Pz_d, 1);
cmap = dlmread('colors.csv');
padding = ones(24,3);


clf
t = figure;
set(gcf,'renderer','opengl');
for z = 1:ntopics
    [ps,idx] = sort(Pw_z(:,z), 'descend');
    C = reshape([cmap(idx,:); padding], 32,32,3);
    subplot(2, 3, z),imagesc(C), axis image off
%     subplot(2, 3* 2, 1 + (z-1) * 2),imagesc(C), axis image off
%     subplot(2, 3* 2, 2 + (z-1) * 2), semilogy(ps), ylim([1e-15, 1])
%     axis square
%     title(sprintf('P(w|z) for z = %d', z));
end
% subtitle('Topic model visualization');
print(t, '-dpng', 'topic_visualization.png') 


for z = 1:ntopics
    k = figure
    [~, idx] = sort(Pz_d(z,:), 'descend');
    showImages(Pz_d, idx(1:9));
    fn = strcat('typ_images', int2str(z),'.png');
    print(k, '-dpng', fn)
    
%     subtitle('Typical imges for topic %d ', z);
end

pause
close all
end