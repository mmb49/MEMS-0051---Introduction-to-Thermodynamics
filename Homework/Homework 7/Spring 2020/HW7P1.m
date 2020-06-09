clear all 
close all
clc

T_H = linspace(300,1400,100);
T_L = [253 263 273 283 293 303 313];

for i = 1:length(T_L)
    for j = 1:length(T_H) 
        eta_carnot(j) = 1 - (T_L(i)/T_H(j)); 
    end
    plot(T_H,eta_carnot);
    hold on  
end

xlabel('T_h [K]');
ylabel('\eta_{Carnot}');
ylim([0 0.9])
set(gcf,'color','white')
legend('T_L = 253 [K]', 'T_L = 263 [K]', 'T_L = 273 [K]', 'T_L = 283 [K]', 'T_L = 293 [K]', 'T_L = 303 [K]', 'T_L = 313 [K]','Location','southeast');