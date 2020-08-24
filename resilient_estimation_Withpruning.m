function R = resilient_estimation_Withpruning(m,n,Pa,Tr)
% function R = resilient_estimation_Withpruning(m,n,Pa,Tr)
%      inputs:
%             m:  [scalar] number of measurements
%             n:  [scalar] Number of states
%             Pa: [scalar] attack percentage
%             Tr: []
%      Outputs:
%             R: ratio of sucess 
%    parameters: 
%             tot: number of trails
%             T: time horizon
%
% @Written by Yu Zheng, Tallahassee, Florida, Aug. 2020

T = n;               % time horizon
tot = 100;           % times for calculating ratio of success
e = zeros(tot,1);
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
        I_attack =[];
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
        y = H*x0+ya;
    end
    
    %% Pruning algorithm based on oracle
    N = m*(T+1);
    q = ones(N,1);
    q(I_attack) = 0;  % define indicator of actual support
    % perform pruning algorithm
    q_eta_hat = pruning_algorithm(q,Tr);    

    %% resilient estimation  
    e(i) =  Weighted_L1_solver(H,y,x0,q_eta_hat);
end
% e1 = L1_noprior_solver(H,y,x0,n_attack*(T+1));
tol = norm(x0)*0.01;
R = sum(e<=tol)/tot;
end