clear all
close all
clc

% Problem #3

% State 1:
m_1 = 10; %[kg]
P_1 = 105; %[kPa]
T_1 = 300; %[K]
R = 0.287; %[kJ/kg-K]
V_1 = (m_1*R*T_1)/P_1; %[m^3]

% State 2:
P_2 = 1250; %[kPa]

% Input
W = -2000; %[kJ]

% Relating temperatures and pressure of isentropic  to work for an ideal
% gas to determine the polytropic index:
eqn = @(n) T_1*(P_2/P_1)^((n-1)/n) - ((1-n)*W)/(m_1*R) - T_1;

% We have two solutions (one about 0.8)
x0=[0.8];
soln1 = fsolve(eqn, x0);
n1 = soln1;

% and one about 1.9
x0=[2.3];
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
% underwent a compression process). 

fprintf('******************************************************\n\n')
fprintf('a) The temperature at the final state is: %.3f [K]\n',T_2)

V_2 = (m_1*R*T_2)/P_2; % use for check

% Call R = C_P0 - C_V0, which means C_V0 = C_P0 - R. Since We can construct
% an expresion for C_P0 from Table A.6, we can therefore construct an
% expression for C_V0 as a function of temperature

C_0 = 1.05;
C_1 = -0.365;
C_2 = 0.85;
C_3 = -0.39;
% The C_P0 in terms of T (not theta), used for part d):
CP0 = @ (x) C_0 + (C_1.*x)/1000 + (C_2.*x.^2)/((1000)^2) + (C_3.*x.^3)/((1000)^3);

% Therefore, C_V0 in terms of theta is:
CV0 = @ (x) C_0 + (C_1.*x) + (C_2.*x.^2) + (C_3.*x.^3) - R;

% The integral of C_V0 is then
CV0 = @ (x) C_0.*x + (C_1.*x^2)/(2*1000) + (C_2.*x.^3)/(3*(1000)^2) + (C_3.*x.^4)/(4*(1000)^3) - R.*x;

% Therefore, the heat removed by using Table A.6 is:
Q = m_1*(CV0(T_2) - CV0(T_1)) + W;

fprintf('b) The heat rejected calculated using Table A.6 is: %.3f [kJ]\n',Q)

% The heat removed is calculated using Table A.7.1:
u_1 = 214.36; % [kJ/kg]
u_2 = ((1260.442 - 1250)/(1300 - 1250))*(1022.75 - 977.89) + 977.89; % [kJ/kg]

Q_12 = m_1*(u_2 - u_1) + W;

fprintf('c) The heat rejected calculated using Table A.7.1 is: %.3f [kJ]\n',Q_12)

fprintf('The percent difference of heat rejected via method b) and c) is: %.3f [per.]\n',((Q-Q_12)/((Q+Q_12)/2))*100)


% We can calculate the change of entropy using Gibb's equation, based upon
% the functional description of C_P0 we created for part b). The change of
% entropy is as follows. The first term in the RHS is the integral of the
% specific heat per temperature with respsect to temperature. The second 
% term in the RHS is the gas constant times the natural log of P2 per P1. 
% Thus, the change of entropy is:

% The integral of C_PO/T dT is, in terms of T (not theta):
CP0 = @ (x) C_0*log(x)+ (C_1.*x)/1000 + (C_2.*x.^2)/(2*(1000)^2) + (C_3.*x.^3)/(3*(1000)^3);

ds = m_1*((CP0(T_2) - CP0(T_1)) - R*log(P_2/P_1));
fprintf('d) The change of entropy using Table A.6 is: %.3f [kJ/K]\n',ds)

% Checking this using standard entropy:
s_T1 = 6.86926; %[kJ/kg-K]
s_T2 = ((1260.442 - 1250)/(1300 - 1250))*(8.44046 - 8.39402) + 8.39402; %[kJ/kg-K]

ds_check = m_1*(s_T2 - s_T1 - R*log(P_2/P_1));
fprintf('e) The change of entropy using Table A.7.1: %.3f [kJ/K]\n',ds_check)

fprintf('The percent difference of change of entropy via method d) and e) is: %.3f [per.]\n',((ds-ds_check)/((ds+ds_check)/2))*100)


