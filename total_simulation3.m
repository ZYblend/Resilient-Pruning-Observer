% % fix (m,n), the success percentage versus attack percentage

P_points = 100;                            % number of Pa
Pa = linspace(0,1,P_points);
n = 10;
m = 2*n;
Tr = [0.4, 0.5, 0.6, 0.7, 0.8, 0.9];

R2_1 = zeros(1,P_points);               % ratio of success  % without prior
R2_2_40 = zeros(1,P_points);                                   % with oracle
R2_2_50 = zeros(1,P_points);                                   % with oracle
R2_2_60 = zeros(1,P_points);                                   % with oracle
R2_2_70 = zeros(1,P_points);                                   % with oracle
R2_2_80 = zeros(1,P_points);                                   % with oracle
R2_2_90 = zeros(1,P_points);                                   % with oracle
R2_3_40 = zeros(1,P_points);                                   % with pruning
R2_3_50 = zeros(1,P_points);                                   % with pruning
R2_3_60 = zeros(1,P_points);                                   % with pruning
R2_3_70 = zeros(1,P_points);                                   % with pruning
R2_3_80 = zeros(1,P_points);                                   % with pruning
R2_3_90 = zeros(1,P_points);                                   % with pruning

T = n;               % time horizon
tot = 10000;           % times for calculating ratio of success

 %% generate system

 [A,C]= sysGen(m,n);    % observation pair
parfor i = 1:P_points
     e1 = zeros(tot,1);
     e2_40 = zeros(tot,1);
     e2_50 = zeros(tot,1);
     e2_60 = zeros(tot,1);
     e2_70 = zeros(tot,1);
     e2_80 = zeros(tot,1);
     e2_90 = zeros(tot,1);
     e3_40 = zeros(tot,1);
     e3_50 = zeros(tot,1);
     e3_60 = zeros(tot,1);
     e3_70 = zeros(tot,1);
     e3_80 = zeros(tot,1);
     e3_90 = zeros(tot,1);
     x0 =randn(n,1);
     H = zeros(m*(T+1),n);
     for index=1:(T+1)
        H(((index-1)*m+1):(index*m),:) = C*A^(index-1); 
    end
    for ii = 1:tot  
        % inject FDIA
        n_attack = fix(m*Pa(i));
        if n_attack == 0
            y=H*x0;
            I_attack =[];
        else 
            I_attack_local = randperm(m,n_attack);

            max_attack = 500;  % maximum allowable attack
            tau = .1;   % escape parameter for BDD
            I_attack = zeros(n_attack*(T+1),1);

            for index=1:(T+1)
                I_attack(((index-1)*n_attack+1):(index*n_attack)) = (index-1)*m + I_attack_local;    
            end
            ya = gen_attack_channel(H,max_attack,I_attack,tau);
            y = H*x0+ya;
        end
        
        %% resilient estimation  without prior
        e1(ii) = L1_noprior_solver(H,y,x0,n_attack*(T+1));


        %% Pruning algorithm based on oracle
        N = m*(T+1);
        q = ones(N,1);
        q(I_attack) = 0;  % define indicator of actual support
        [q_eta_hat40,q_hat40] = pruning_algorithm(q,Tr(1));
        [q_eta_hat50,q_hat50] = pruning_algorithm(q,Tr(2));
        [q_eta_hat60,q_hat60] = pruning_algorithm(q,Tr(3));
        [q_eta_hat70,q_hat70] = pruning_algorithm(q,Tr(4));
        [q_eta_hat80,q_hat80] = pruning_algorithm(q,Tr(5));
        [q_eta_hat90,q_hat90] = pruning_algorithm(q,Tr(6));


        %% resilient estimation with oracle  
        e2_40(ii) =  Weighted_L1_solver(H,y,x0,q_hat40);
        e2_50(ii) =  Weighted_L1_solver(H,y,x0,q_hat50);
        e2_60(ii) =  Weighted_L1_solver(H,y,x0,q_hat60);
        e2_70(ii) =  Weighted_L1_solver(H,y,x0,q_hat70);
        e2_80(ii) =  Weighted_L1_solver(H,y,x0,q_hat80);
        e2_90(ii) =  Weighted_L1_solver(H,y,x0,q_hat90);
        
        %% resilient estimation  
        e3_40(ii) =  Weighted_L1_solver(H,y,x0,q_eta_hat40);
        e3_50(ii) =  Weighted_L1_solver(H,y,x0,q_eta_hat50);
        e3_60(ii) =  Weighted_L1_solver(H,y,x0,q_eta_hat60);
        e3_70(ii) =  Weighted_L1_solver(H,y,x0,q_eta_hat70);
        e3_80(ii) =  Weighted_L1_solver(H,y,x0,q_eta_hat80);
        e3_90(ii) =  Weighted_L1_solver(H,y,x0,q_eta_hat90);
    end
    tol = norm(x0)*0.01;
    R2_1(i) = sum(e1<=tol)/tot;
    R2_2_40(i) = sum(e2_40<=tol)/tot;
    R2_2_50(i) = sum(e2_50<=tol)/tot;
    R2_2_60(i) = sum(e2_60<=tol)/tot;
    R2_2_70(i) = sum(e2_70<=tol)/tot;
    R2_2_80(i) = sum(e2_80<=tol)/tot;
    R2_2_90(i) = sum(e2_90<=tol)/tot;
    R2_3_40(i) = sum(e3_40<=tol)/tot;
    R2_3_50(i) = sum(e3_50<=tol)/tot;
    R2_3_60(i) = sum(e3_60<=tol)/tot;
    R2_3_70(i) = sum(e3_70<=tol)/tot;
    R2_3_80(i) = sum(e3_80<=tol)/tot;
    R2_3_90(i) = sum(e3_90<=tol)/tot;
end