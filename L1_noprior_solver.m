function error = L1_noprior_solver(H,y,x0,k)
% function [A,C]= sysGen(m,n)
% Description:
%              min||y-Hx||_{l1}
% Inputs: 
%          H:   [N-by-n]   system parameters
%          y:   [T*m-by-1] measurements in T time horizon
%          x0:  [n-by-1]   actual initial state
%          k:   [scalar]   number of attacks
% Outputs:
%          e:   [scalar]   estimation error
%
% @Written by Yu Zheng, Tallahassee, Florida, Aug. 2020

%% observation matrix
[N,n] = size(H);

%% find matrix F satisfying FH=0 and RIP condition
[U,S,V] = svd(H);

U1 = zeros(N,n);
U2 = U(:,n+1:end);

U_F = [U1.' ; U2.'];

F = V'*S'*U_F;
% normalize the columns
nn = sqrt(sum(F.*conj(F),1));
Fn = bsxfun(@rdivide,F,nn);  % nA is a matrix with normalized columns

% calculate coherence
mu_1 = max(max(triu(abs((Fn')*Fn),1)));
delta_3k = (3*k-1)*mu_1;
if delta_3k<=1/3
    fprintf('F construction success\n');
else
    fprintf('F construction fail\n');
end    


%% linear programming to solve the l1-minimization
% opts = optimset('linprog');
% set( opts, 'TolFun', 1e-12 );
% e = linprog(ones(N,1),[],[],F,F*y,zeros(1,N),[],[],opts);
% e = linprog(ones(N,1),[],[],F,F*y,zeros(1,N),[]);
% x00 = (H'*H)\H'*y;
% e = linprog(ones(N,1),-eye(N,N),(y-H*x00)',[],[],(y-H*x00)',[]);

f = [zeros(1,n) ones(1,N)];
A = [H -eye(N,N);
     -H -eye(N,N)];
b = [y -y];
t = linprog(f,A,b);

x_hat = t(1:n);


%% calculate the estimate error measured by l2 norm
error = norm(x_hat-x0);
end
