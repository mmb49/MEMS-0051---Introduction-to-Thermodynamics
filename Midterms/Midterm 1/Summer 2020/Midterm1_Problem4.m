clear all
close all
clc

% Givens
T_steel = [273.2, 280, 288.7, 300, 320, 340, 360, 380, 400, 500, 600, 700, 800, 900, 1100, 1500, 1900]; %[K]
C_steel = [1.006, 1.006, 1.006, 1.006, 1.007, 1.009, 1.01, 1.012, 1.014, 1.03, 1.054, 1.075, 1.099, 1.121, 1.159, 1.21, 1.241]; %[kJ/kg-K]

T_oil = 273.15+[40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190]; %[K]
C_oil = [2.271, 2.420, 2.590, 2.757, 2.852, 2.976, 3.092, 3.197, 3.293, 3.337, 3.483, 3.590, 3.701, 3.778, 3.868, 3.910 ]; %[kJ/kg-K]

% A 2,500 [kg] steel forging is quenched in an 10,000 [kg] bath of oil. 
% If the steel is initially at a temperature of 1,500 [K], and the oil is
% initially at a temperature of 350 [K], determine the final
% temperature, using the integral average of the specific heats. Note, you
% will have to fit the data given using cftool. You should fit the data
% using a polynomial fit. You will increase the order of the fit unitl the
% Adjusted R-squared value is near 0.99


T_steel_array = linspace(T_steel(1),T_steel(end),1000);
CP_steel = @(x) (-9.25e-17).*x.^5 + (6.026e-13).*x.^4 + (-1.502e-09).*x.^3 + (1.699e-06).*x.^2 + (-0.0006496).*x + 1.084;

figure(1)
plot(T_steel,C_steel,'or',T_steel_array,CP_steel(T_steel_array),'-r')

T_oil_array = linspace(T_oil(1),T_oil(end),1000);
CP_oil = @(x) (-2.463e-05).*x.^2 + (0.02993).*x + -4.659;

figure(2)
plot(T_oil,C_oil,'ob',T_oil_array,CP_oil(T_oil_array),'-b')

%%

% From the conservation of energy
% dU = Q_{1 \rightarrow 2} - W_{1 \rightarrow 2}

% If the control surface is placed around both the steel and oil, there
% is no heat transfer. If the oil does not vaporize, there is no boundary
% work. Thus U_{2} - U_{1} = 0

% Recall the change of internal energy is the specific heat times change of
% temperature. Thus, for the oil, we can express the following:
% U_{2,oil} - U_{1,oil} = m_{oil}*C_{oil}*(T_{2} - T_{1,oil})

% For the oil we can express the following:
% U_{2,steel} - U_{1,steel} = m_{steel}*C_{steel}*(T_{2} - T_{1,steel})

% The change of the energy of the steel must be equal to the change of
% energy of the oil such that they reach the same final temperature:
% m_{oil}*C_{oil}*(T_{2} - T_{1,oil}) + m_{steel}*C_{steel}*(T_{2} -
% T_{1,steel}) = 0

% Solving for the final temperature
% T_{2} = ( T_{1,oil}*m_{oil}*C_{oil} +
% T_{1,steel}*m_{steel}*C_{steel} )/ ( m_{oil}*C_{oil} +
% m_{steel}*C_{steel} )

% We will first use constants to initialize our guess, then expand this out
% for the integral-average of specific heat

m_oil = 10000; %[kg]
T_oil = 350; %[K]

m_steel = 2500; %[kg]
T_steel = 1500; %[K]

T_f = (T_oil*m_oil*CP_oil(T_oil) + T_steel*m_steel*CP_steel(T_steel))/(m_oil*CP_oil(T_oil) + m_steel*CP_steel(T_steel));

fprintf('The final temperature assuming constant CP initialized at our given temperature is %.2f [K]\n',T_f)

% Now we have to define the integrals of the specifc heat of steal and oil
CP_steel_int = @(x) ((-9.25e-17)/6).*x.^6 + ((6.026e-13)/5).*x.^5 + ((-1.502e-09)/4).*x.^4 + ((1.699e-06)/3).*x.^3 + ((-0.0006496)/2).*x.^2 + (1.084).*x;

C_0_steel = 1.064;      %coefficients from cftool for steel
C_1_steel = .09189;     %equations x = T
C_2_steel = .009371;
C_3_steel = -.007218;

Csteel_int = @(x) C_0_steel.*x + (C_1_steel/2).*x.^2 + (C_2_steel/3).*x.^3 + (C_3_steel/4).*x.^4;

figure(3)
plot(T_steel_array,CP_steel_int(T_steel_array),'r')
figure(4)
plot(T_steel_array,720*Csteel_int((T_steel_array-643.6)/471.4),'b')

CP_oil_int = @(x) ((-2.463e-05)/3).*x.^3 + ((0.02993)/2).*x.^2 + (-4.659).*x;

% We will initialize our final temperature
T_f_old = T_f;

% Initializing error
error = 1;

% Setting a counter
counter = 0;
while error >= 1e-10
    % We will calclulte the integral-average of the CP of steel between our
    % two temperature bounds, calling this variable C_s
    C_s = (1/(T_f_old - T_steel))*(CP_steel_int(T_f_old) - CP_steel_int(T_steel));
    
    % We will calclulte the integral-average of the CP of oill between our
    % two temperature bounds, calling this variable C_o
    C_o = (1/(T_f_old - T_oil))*(CP_oil_int(T_f_old) - CP_oil_int(T_oil));    
    
    % Now we can calculate our final temperature
    T_f_new = (T_oil*m_oil*C_o + T_steel*m_steel*C_s)/(m_oil*C_o + m_steel*C_s);
    
    % Defining error
    error = abs(T_f_new - T_f_old);
    
    % Redefining our guess
    T_f_old = T_f_new;
    
    % Updating our counter
    counter = counter + 1;
end

fprintf('The final temperature, considering the integral-average specific heats, is %.2f [K]\n',T_f_new)
fprintf('The solution was found in %i iterations',counter)



