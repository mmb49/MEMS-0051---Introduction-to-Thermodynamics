clear all
close all
clc

% Problem #4

% State 1:
m_1 = 1; %[kg]
P_1 = 100; %[kPa]
T_1 = 298.15; %[K]
R = 0.287; %[kJ/kg-K]

% State 2:
P_2 = 1200; %[kPa]

% Input
W = -200; %[kJ]

% Relating temperatures and pressure of isentropic  to work for an ideal
% gas to determine the polytropic index:
eqn = @(n) T_1*(P_2/P_1)^((n-1)/n) - ((1-n)*W)/(m_1*R) - T_1;

% We have two solutions (one about 0.8)
x0=[0.9];
soln1 = fsolve(eqn, x0);
n1 = soln1;

% and one about 1.9
x0=[1.9];
soln2 = fsolve(eqn, x0);
n2 = soln2;

clc

fprintf('The first polytropic index is: n_1 = %.3f\n',n1)
fprintf('The second polytropic index is: n_2 = %.3f\n\n',n2)

T_21 = T_1*(P_2/P_1)^((n1-1)/n1);
fprintf('The temperature at State 2 based upon n1 is: %.3f [K]\n',T_21)
T_2 = T_1*(P_2/P_1)^((n2-1)/n2);
fprintf('The temperature at State 2 based upon n1 is: %.3f [K]\n\n',T_2)

% The use of the first polytropic index does not make physical sense, for
% the temperature at State 2 is less than that at State 1 (while we
% underwent a compression process). Thus, we can evaluate the change of
% entropy as follows. The first term in the RHS is the integral of the
% specific heat per temperature with respsect to temperature:
C_0 = 1.05;
C_1 = -0.365;
C_2 = 0.85;
C_3 = -0.39;
% The integral of C_PO/T dT is, in terms of T (not theta):
CP0 = @ (x) C_0*log(x)+ (C_1.*x)/1000 + (C_2.*x.^2)/(2*(1000)^2) + (C_3.*x.^3)/(3*(1000)^3);
% The second term in the RHS is the gas constant times the natural log of
% P2 per P1. Thus, the change of entropy is:

ds = m_1*((CP0(T_2) - CP0(T_1)) - R*log(P_2/P_1));
fprintf('The change of entropy is: %.3f [kJ/K]\n',ds)

% Checking this using standard entropy:
s_T1 = 6.86305; %[kJ/kg-K]
s_T2 = 8.24449; %[kJ/kg-K]

ds_check = m_1*(s_T2 - s_T1 - R*log(P_2/P_1));
fprintf('the change of entropy using standard entropy isis: %.3f [kJ/K]\n',ds)





