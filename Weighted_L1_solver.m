function error = Weighted_L1_solver(H,y,x0,q)
% function error = Weighted_L1_solver(H,y,x0,k)
% Description:
%              min||y-Hx||_{l1}
% Inputs: 
%          H:   [N-by-n]   system parameters
%          y:   [T*m-by-1] measurements in T time horizon
%          x0:  [n-by-1]   actual initial state
%          q:   [N-by-1]   indicator of support of attack location
% Outputs:
%          e:   [scalar]   estimation error
%
% @Written by Yu Zheng, Tallahassee, Florida, Aug. 2020


[N,n] = size(H);

w = ones(1,N);
w(q<0.5) =0;


f = [zeros(1,n) w];
A = [H -eye(N,N);
     -H -eye(N,N)];
b = [y -y];
t = linprog(f,A,b);
if length(t)~=N+n
    error = norm(x0);
else
    x_hat = t(1:n);

    %% calculate the estimate error measured by l2 norm
    error = norm(x_hat-x0);
end
end