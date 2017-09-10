% Function to calculate the distance defined in the problem of the right
% part of two spectra
% INPUT:
% spectra f1,f2 [1 * n], n is the length of wavelength vector
% OUTPUT:
% distance d, scalar

function d = distance(f1, f2)
    d = sum((f1(151:end) - f2(151:end)) .^ 2);
end