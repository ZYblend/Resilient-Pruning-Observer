
figure (2),
plot(100*Pa,100*R2_1, 100*Pa,100*R2_2_40, 100*Pa,100*R2_2_50, 100*Pa,100*R2_2_60, 100*Pa,100*R2_2_70, 100*Pa,100*R2_2_80, 100*Pa,100*R2_2_90,'linewidth',2)
legend('without prior','40% precision prior','50% precision prior','60% precision prior','70% precision prior','80% precision prior','90% precision prior')
xlabel('Attack percentage','Fontsize',20)
ylabel('Success percentage','Fontsize',20)
grid on