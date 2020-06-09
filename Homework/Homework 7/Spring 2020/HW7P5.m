clear all
close all
clc

% --------- Part a) --------- %
s_1 = 0.884; %[kJ/kg-K]
u_1 = 168.1; %[kJ/kg]

s_2 = 5.712; %[kJ/kg-K]
u_2 = 1332.1; %[kJ/kg]

q = u_2 - u_1;
ds = s_2 - s_1;

fprintf('The change in specific entropy for ammonia is: ds=%.4f [kJ/kg-K]\n',ds)
fprintf('The heat removed from the ammonia is: q=%.2f [kJ/kg]\n\n',q) 

% --------- Part b) --------- %
s_1 = 0.963; %[kJ/kg-K]
u_1 = 189.3; %[kJ/kg]

s_2 = 1.824; %[kJ/kg-K]
u_2 = 393.1; %[kJ/kg]

q = u_2 - u_1;
ds = s_2 - s_1;

fprintf('The change in specific entropy for R-410a is: ds=%.4f [kJ/kg-K]\n',ds)
fprintf('The heat removed from the R-410a is: q=%.2f [kJ/kg]\n\n',q) 

% --------- Part c) --------- %
s_1 = 0.119; %[kJ/kg-K]
u_1 = 29.6; %[kJ/kg]

s_2 = 0.700; %[kJ/kg-K]
u_2 = 167.7; %[kJ/kg]

q = u_2 - u_1;
ds = s_2 - s_1;

fprintf('The change in specific entropy for R-12 is: ds=%.4f [kJ/kg-K]\n',ds)
fprintf('The heat removed from the R-12 is: q=%.2f [kJ/kg]\n\n',q) 
