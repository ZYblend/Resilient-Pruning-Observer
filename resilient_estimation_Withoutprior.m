function R = resilient_estimation_Withoutprior(m,n,Pa)
% function R = resilient_estimation_Withoutprior(m,n,Pa)
% Description:
%             This function is evaluate the performance of resilient
%             estimation, if estimate error is larger than 1%*x0, the
%             estimation fails, otherwise it successes.
%      inputs:
%             m: [scalar] number of measurements
%             n: [scalar] Number of states
%             Pa: [scalar] attack percentage
%      Outputs:
%             R: ratio of sucess 
%    parameters: 
%             tot: number of trails
%             T: time horizon
%
% @Written by Yu Zheng, Tallahassee, Florida, Aug. 2020

T = n;               % time horizon
tot = 100;           % times for calculating ratio of success
e1 = zeros(tot,1);
x0 =randn(n,1);

%% generate system
H = zeros(m*(T+1),n);
[A,C]= sysGen(m,n);    % observation pair

for i = 1:tot 
    % inject FDIA
    n_attack = fix(m*Pa);
    if n_attack == 0
        for index=1:(T+1)
            H(((index-1)*m+1):(index*m),:) = C*A^(index-1); 
        end
        y=H*x0;
    else            
        I_attack_local = randperm(m,n_attack);

        max_attack = 500;  % maximum allowable attack
        tau = .1;   % escape parameter for BDD
        I_attack = zeros(n_attack*(T+1),1);

        for index=1:(T+1)
            H(((index-1)*m+1):(index*m),:) = C*A^(index-1);  % measurment matrix
            I_attack(((index-1)*n_attack+1):(index*n_attack)) = (index-1)*m + I_attack_local;    
        end
        ya = gen_attack_channel(H,max_attack,I_attack,tau);
    %     lambda = 5;
    %     y = H*x0;
    %     ya = lambda*y(I_attack);

        y = H*x0+ya;
    end

    %% resilient estimation  
    e1(i) = L1_noprior_solver(H,y,x0,n_attack*(T+1));
end
% e1 = L1_noprior_solver(H,y,x0,n_attack*(T+1));
tol = norm(x0)*0.01;
R = sum(e1<=tol)/tot;
end