% This file is to visulize the relationship of sucess ratio versus (m,n)                                     

% put R into matrix
ratio1 = zeros(n_points,n_points);
for i = 1:n_points
    ratio1(:,i)=R1((n_points*(i-1)+1):(n_points*i));
end

ratio21 = zeros(n_points,n_points);
ratio22 = zeros(n_points,n_points);
ratio23 = zeros(n_points,n_points);
for i=1:n_points
        ratio21(:,i)=R2(1,(n_points*(i-1)+1):(n_points*i));
        ratio22(:,i)=R2(2,(n_points*(i-1)+1):(n_points*i));
        ratio23(:,i)=R2(3,(n_points*(i-1)+1):(n_points*i));
end

ratio31 = zeros(n_points,n_points);
ratio32 = zeros(n_points,n_points);
ratio33 = zeros(n_points,n_points);
for i=1:n_points
        ratio31(:,i)=R3(1,(n_points*(i-1)+1):(n_points*i));
        ratio32(:,i)=R3(2,(n_points*(i-1)+1):(n_points*i));
        ratio33(:,i)=R3(3,(n_points*(i-1)+1):(n_points*i));
end

% 2d-Visulization
figure (1),
subplot(3,3,1)
image(m,n,ratio1,'CDataMapping','scaled')
colormap (gray)
% xlabel('m','Fontsize',20)
% ylabel('n','Fontsize',20)
title('Without prior','Fontsize',20)
xticks(m)
yticks(n)
colorbar
caxis([0 1])
set(gca,'xticklabel',{[]})
set(gca,'yticklabel',{[]})

figure (1),
subplot(3,3,2)
image(m,n,ratio1,'CDataMapping','scaled')
colormap (gray)
% xlabel('m','Fontsize',20)
% ylabel('n','Fontsize',20)
title('Without prior','Fontsize',20)
xticks(m)
yticks(n)
colorbar
caxis([0 1])
set(gca,'xticklabel',{[]})
set(gca,'yticklabel',{[]})

figure (1),
subplot(3,3,3)
image(m,n,ratio1,'CDataMapping','scaled')
colormap (gray)
% xlabel('m','Fontsize',20)
% ylabel('n','Fontsize',20)
title('Without prior','Fontsize',20)
xticks(m)
yticks(n)
colorbar
caxis([0 1])
set(gca,'xticklabel',{[]})
set(gca,'yticklabel',{[]})

figure (1),
subplot(3,3,4)
image(m,n,ratio21,'CDataMapping','scaled')
colormap (gray)
% xlabel('m','Fontsize',20)
% ylabel('n','Fontsize',20)
title('With prior','Fontsize',20)
xticks(m)
yticks(n)
colorbar
caxis([0 1])
set(gca,'xticklabel',{[]})
set(gca,'yticklabel',{[]})


figure (1),
subplot(3,3,5)
image(m,n,ratio22,'CDataMapping','scaled')
colormap (gray)
% xlabel('m','Fontsize',20)
% ylabel('n','Fontsize',20)
title('With prior','Fontsize',20)
xticks(m)
yticks(n)
colorbar
caxis([0 1])
set(gca,'xticklabel',{[]})
set(gca,'yticklabel',{[]})

figure (1),
subplot(3,3,6)
image(m,n,ratio23,'CDataMapping','scaled')
colormap (gray)
% xlabel('m','Fontsize',20)
% ylabel('n','Fontsize',20)
title('With prior','Fontsize',20)
xticks(m)
yticks(n)
colorbar
caxis([0 1])
set(gca,'xticklabel',{[]})
set(gca,'yticklabel',{[]})

figure (1),
subplot(3,3,7)
image(m,n,ratio31,'CDataMapping','scaled')
colormap (gray)
% xlabel('m','Fontsize',20)
% ylabel('n','Fontsize',20)
title('prior with Pruning','Fontsize',20)
xticks(m)
yticks(n)
colorbar
caxis([0 1])
set(gca,'xticklabel',{[]})
set(gca,'yticklabel',{[]})

figure (1),
subplot(3,3,8)
image(m,n,ratio32,'CDataMapping','scaled')
colormap (gray)
% xlabel('m','Fontsize',20)
% ylabel('n','Fontsize',20)
title('prior with Pruning','Fontsize',20)
xticks(m)
yticks(n)
colorbar
caxis([0 1])
set(gca,'xticklabel',{[]})
set(gca,'yticklabel',{[]})

figure (1),
subplot(3,3,9)
image(m,n,ratio33,'CDataMapping','scaled')
colormap (gray)
% xlabel('m','Fontsize',20)
% ylabel('n','Fontsize',20)
title('prior with Pruning','Fontsize',20)
xticks(m)
yticks(n)
colorbar
caxis([0 1])
set(gca,'xticklabel',{[]})
set(gca,'yticklabel',{[]})






