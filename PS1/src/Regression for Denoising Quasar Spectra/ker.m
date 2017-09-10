% Function to calculate the denotation ker
% INPUT:
% t, scalar
% OUTPUT:
% k, max{1-t, 0}
function k = ker(t)
    k = max(1-t,0);
end