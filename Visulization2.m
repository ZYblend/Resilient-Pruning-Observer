
figure (2),
plot(100*Pa2,100*R2_1,100*Pa2,100*R2_2,100*Pa2,100*R2_3,'linewidth',2)
legend('without prior','with prior','prior with pruning')
xlabel('Attack percentage','Fontsize',20)
ylabel('Success percentage','Fontsize',20)
grid on