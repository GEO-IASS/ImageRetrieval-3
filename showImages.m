function showImages(Pz_d, ids, nrows)
if~exist('nrows','var')
    nrows = floor(sqrt(numel(ids)));
end

ncols = ceil(numel(ids)/nrows);
ntopics = size(Pz_d, 1);
for i = 1:numel(ids)
    imgId = ids(i);
    I = im2double(imread(sprintf('mirflickr1000/im%d.jpg',imgId)));
    subplot(nrows, ncols * 2, 1+(i-1) * 2)
    imagesc(I)
    axis image off, title(sprintf('%d', imgId))
    subplot(nrows, ncols * 2, 2+(i-1) * 2)
    bar(1:ntopics, Pz_d(:,imgId))
    axis square
    axis([.5 ntopics + 0.5 0 1])
    title(sprintf('P(z|d) for %d', imgId));
end
end
    