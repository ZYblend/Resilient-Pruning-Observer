%% Function1: Inverse CDF for the corresponding Tr-weighted uniform distribution
function p = CDF_inv(X,Tr)
% Inputs:
%  - X  [m-by-n] 
%  - Tr [scalar]: True Rate
% Output:
%  -  p [m-by-n] :  simulated vector of agreements probabilities

p = (0.5/(1-Tr)*X).*double(X<(1-Tr)) + (0.5 + (0.5/Tr)*(X-1+Tr)).*double(X>=(1-Tr));
end