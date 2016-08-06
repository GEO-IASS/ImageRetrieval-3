function F = normalize(D, dim)
    if(nargin < 2)
        dim = 1;
    end
    
    F = bsxfun(@rdivide, D , sum(D,dim));
end