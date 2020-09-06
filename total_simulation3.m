% % fix (m,n), the success percentage versus attack percentage

P_points = 100;                            % number of Pa
Pa = linspace(0,1,P_points);
n = 10;
m = 2*n;
Tr =0.6;

R2_1 = zeros(1,P_points);               % ratio of success  % without prior
R2_2 = zeros(1,P_points);                                   % with oracle
R2_3 = zeros(1,P_points);                                   % with pruning

T = n;               % time horizon
tot = 10000;           % times for calculating ratio of success

 %% generate system

 [A,C]= sysGen(m,n);    % observation pair
parfor i = 1:P_points
     e1 = zeros(tot,1);
     e2 = zeros(tot,1);
     e3 = zeros(tot,1);
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
        [q_eta_hat,q_hat] = pruning_algorithm(q,Tr);


        %% resilient estimation with oracle  
        e2(ii) =  Weighted_L1_solver(H,y,x0,q_hat);
        
        %% resilient estimation  
        e3(ii) =  Weighted_L1_solver(H,y,x0,q_eta_hat);
    end
    tol = norm(x0)*0.01;
    R2_1(i) = sum(e1<=tol)/tot;
    R2_2(i) = sum(e2<=tol)/tot;
    R2_3(i) = sum(e3<=tol)/tot;
end