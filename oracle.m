function q_hat = oracle(q,Tr)

P = zeros(N,1);
while sum(P>0.5) == 0
    u = rand(N,1);
    P = CDF_inv(u,Tr);                               % ROC
end

epsilon = double(P>0.5);                         % agreement 
q_hat = (q - (1-epsilon))./(2*epsilon-1);        % estimate support indics

end
