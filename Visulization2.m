
figure (2),
plot(100*Pa,100*R2_1,':k',100*Pa,100*R2_2,'--k',100*Pa,100*R2_3,'-k','linewidth',2)
legend('without prior','with prior','prior with pruning')
xlabel('Attack percentage','Fontsize',20)
ylabel('Success percentage','Fontsize',20)
grid on