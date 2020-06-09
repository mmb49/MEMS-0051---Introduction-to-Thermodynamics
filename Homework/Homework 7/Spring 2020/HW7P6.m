clear all 
close all
clc

m_steel = 2000;  
C_steel = 0.46;  
T_i_steel = 1393;
T_liq = 300;

%------- Part a. ----------%

rho_h2o = 997;
C_h2o = 4.18;
m_h2o = rho_h2o*8;

T_f = (m_h2o*C_h2o*T_liq + m_steel*C_steel*T_i_steel)/(m_h2o*C_h2o + m_steel*C_steel);

del_s_steel = m_steel*C_steel*log(T_f/T_i_steel);
des_s_h2o  = m_h2o*C_h2o*log(T_f/T_liq);

dS_h2o = des_s_h2o - del_s_steel;

fprintf('Net chance of entropy using water: dS = %f [kJ/k]\n',dS_h2o);

%-------- Part b. ---------%

rho_oil = 910;
C_oil = 1.8;
m_oil = rho_oil*8;

T_f = (m_oil*C_oil*T_liq + m_steel*C_steel*T_i_steel)/(m_oil*C_oil + m_steel*C_steel);

del_s_steel = m_steel*C_steel*log(T_f/T_i_steel);
des_s_oil  = m_oil*C_oil*log(T_f/T_liq);

dS_oil = des_s_oil - del_s_steel;

fprintf('Net chance of entropy using oil: dS = %f [kJ/K]\n',dS_oil);

%-------- Part c. ---------%

rho_gly = 1260;
C_gly = 2.42;
m_gly = rho_gly*8;

T_f = (m_gly*C_gly*T_liq + m_steel*C_steel*T_i_steel)/(m_gly*C_gly + m_steel*C_steel);

del_s_steel = m_steel*C_steel*log(T_f/T_i_steel);
des_s_gly  = m_gly*C_gly*log(T_f/T_liq);

dS_gly = des_s_gly- del_s_steel;

fprintf('Net chance of entropy using glycerine: dS = %f [kJ/K]\n',dS_gly);
