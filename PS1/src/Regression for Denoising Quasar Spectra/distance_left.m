% Function to calculate the distance defined in the problem of the left
% part of two spectra
% INPUT:
% spectra f1,f2 [1 * n], n is the length of wavelength vector or the length
% of left part prediction vector
% OUTPUT:
% distance d, scalar
function d = distance_left(f1, f2)
    d = sum((f1(1:50) - f2(1:50)) .^ 2);
end