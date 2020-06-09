clear all
close all
clc

% State 1: 
P_1 = 100; %[kPa]
T_1 = 400; %[K]


% State 2:
P_2 = 500; %[kPa]
T_2 = 900; %[K]

% --------- Part a) --------- %
s_1 = 7.501; %[kJ/kg-K]
s_2 = 8.420; %[kJ/kg-K]
ds = s_2 - s_1;
fprintf('The change in specific entropy using the superheated steam tables is: ds=%f [kJ/kg-K]\n',ds)

% --------- Part b) --------- %
C_P0 = 1.872; %[kJ/kg-K]
R = 0.4615; %[kJ/kg-K]
ds = C_P0*log(T_2/T_1) - R*log(P_2/P_1);
fprintf('The change in specific entropy using Table A.5 is: ds=%f [kJ/kg-K]\n',ds)

% --------- Part c) --------- %
C_0 = 1.79;
C_1 = 0.107;
C_2 = 0.586;
C_3 = -0.20;
T_avg = (T_1 + T_2)/2;
theta = T_avg/1000;
C_P0 = C_0 + C_1*theta + C_2*theta^2 + C_3*theta^3;
ds = C_P0*log(T_2/T_1) - R*log(P_2/P_1);
fprintf('The change in specific entropy using Table A.6 for an average C_P0 is: ds=%f [kJ/kg-K]\n',ds)

% --------- Part d) --------- %
CP0_int = @ (x) 1000*( C_0.*x + (C_1/2).*x.^2 + (C_2/3).*x.^3 + (C_3/4).*x.^4 );
C_P0 = (CP0_int(T_2/1000) - CP0_int(T_1/1000))/(T_2 - T_1);
ds = C_P0*log(T_2/T_1) - R*log(P_2/P_1);
fprintf('The change in specific entropy using Table A.6 for an integral-average C_P0 is: ds=%f [kJ/kg-K]\n',ds)
