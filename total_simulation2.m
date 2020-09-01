% fix (m,n), the success percentage versus attack percentage

P_points = 100;                            % number of Pa
Pa2 = linspace(0,1,P_points);
n = 128;
m = 2*n;
% Tr = 1.1*Pa2;
% if Tr >1
%     Tr =1;
% end
% if Tr==0
%     Tr =0.1;
% end
Tr2 =0.5;

R2_1 = zeros(1,P_points);               % ratio of success  % without prior
R2_2 = zeros(1,P_points);                                   % with oracle
R2_3 = zeros(1,P_points);                                   % with pruning

parfor i = 1:P_points
     R2_1(i) = resilient_estimation_Withoutprior(m,n,Pa2(i));
     R2_2(i) = resilient_estimation_Withoracle(m,n,Pa2(i),Tr2);
     R2_3(i) = resilient_estimation_Withpruning(m,n,Pa2(i),Tr2);     
end