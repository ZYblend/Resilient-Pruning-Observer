% This file is to simulate three resilient estimation to calculate success
% ratio for different (m,n), Pa and Tr setting


%% fix Pa, generate ratio of success in different (m,n) with different Tr
% be careful, in this simulation, you only have freedom to modify n_points, and the range of (m,n).
% when you change other parameters, you should change some codes correspondly only in this file

% generate data
n_points = 20;
n_start   = 5;
n_spacing = 2;                                  % the spacing between each n
n_end     = n_start + (n_points-1)*n_spacing;
n = n_start:n_spacing:n_end;                    % number of states
m = 2*n;                                        % number of measurements
[m_grid,n_grid] = meshgrid(m,n);
m_grid_new = max(n_grid+1,m_grid);




Pa = 0.6;                                  % attack percentage
T_points = 3;                              % number of Tr
% Tr = Pa*linspace(1.1,1.5,T_points);      % agreement percentage
                                           % please make Tr > Pa
Tr = linspace(0.3,0.6,T_points);
                                         
R1 = zeros(1,n_points^2);
R2 = zeros(T_points,n_points^2);                              % with oracle
R3 = zeros(T_points,n_points^2);                              % with pruning
tic
parfor iter = 1:n_points^2  
    R1(iter) = resilient_estimation_Withoutprior(m_grid_new(iter),n_grid(iter),Pa);
    for iter2 = 1:T_points
        R2(iter2,iter) = resilient_estimation_Withoracle(m_grid_new(iter),n_grid(iter),Pa,Tr(iter2));
        
        R3(iter2,iter) = resilient_estimation_Withpruning(m_grid_new(iter),n_grid(iter),Pa,Tr(iter2));
    end
end
toc