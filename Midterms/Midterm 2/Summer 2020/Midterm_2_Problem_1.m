%Midterm #2 - Problem #1

%We have been asked to plot the entropy generated as a function of
%temperature for the given process. Per the 2nd Law of Thermodynamics, we
%know that the entropy generated is equivalent to the change of entropy for
%the system, which in this case is the two sections within the tank. 

%When it comes to plotting, we know that the two sections do not have the
%same temperatures (one begins at 75 [K] and one begins at 125 [K]).
%Because of changes in the Cp values (if you assumed a solution resembling
%a constant pressure process) and changes in phase and Cv (if you assumed a
%constant volume process), the temperatures also do not move at a 1 to 1
%ratio. This means, for example, that for every 0.1 [K] change in section
%B, section A has a 0.162 [K] change. Therefore, to accurately plot entropy
%generation, we need to plot the change of the system with respect to the
%temperature of one of the sections.

%Clear variables and screen
clear all;
clc;

%Setup variables
m_a = 1;
m_b = 1.5;
CpA = 1.708;
CpB = 1.851;
dT = 0.1;

%We will first solve the problem using the constant pressure specific heat
%approach.

%Define temperatures and calculate change of entropy for section B
T_B(1) = 125;
for i = 2:501
    T_B(i) = T_B(i-1) - dT;
    S_B(i) = m_b*CpB*log(T_B(i)/T_B(1));
end
%Define temperatures and calculate change of entropy for section A
T_A(1) = 75;
for i = 2:501
    T_A(i) = T_A(i-1) + dT*((m_b*CpB)/(m_a*CpA));
    S_A(i) = m_a*CpA*log(T_A(i)/T_A(1));
end
%Calculate the entropy generated vs temperature for the process
S_gen = S_A + S_B;

%Plot the entropy generated for the process with respect to the temperature
%in section B. 
figure
plot(T_B,S_gen)
title('Entropy Generation vs. Temperature')
xlabel('Temperature [K]')
ylabel('Entropy [kJ/K]')

%We know for an isolated system that when a system reaches equilibrium the
%entropy generated within the system is at a maximum. Assuming our
%temperature averaged Cp values are sufficiently accurate, we should find
%the maximum entropy occurs at approximately the same equilibrium
%temperature we found using the Conservation of Energy.

%Find and display the equilbrium temperature based on maximum entropy.
[M,I] = max(S_gen);
disp("The maximum entropy is " + M + " [kJ/K]")
disp("The equilibrium temperature based on maximum entropy then is " + T_B(I) + " [K]")

%Note that both of these values are very close to what we determined EES.

%Now, we will solve the problem assuming constant volume.

%Setup variables
CvA = 0.9895;
Cv_eq = 1.713;

%Define temperatures for section B and the change in entropy for section B.
%Note that individual entropy values come from the EES tables.

%Load specific entropy data
load('s')

T_B2(1) = 125;
s_ref = s(1);
S_B2(1) = 0;
for i = 2:501
    T_B2(i) = T_B2(i-1) - dT;
    S_B2(i) = m_b*(s(i) - s_ref);
end

%Define temperatures and calculate change of entropy for section A
T_A2(1) = 75;
for i = 2:501
    T_A2(i) = T_A2(i-1) + dT*((m_b*Cv_eq)/(m_a*CvA));
    S_A2(i) = m_a*CvA*log(T_A2(i)/T_A2(1));
end
%Calculate the entropy generated vs temperature for the process
S_gen2 = S_A2 + S_B2;

%Plot the entropy generated for the process with respect to the temperature
%in section B. 
figure
plot(T_B2,S_gen2)
title('Entropy Generation vs. Temperature')
xlabel('Temperature [K]')
ylabel('Entropy [kJ/K]')

%We know for an isolated system that when a system reaches equilibrium the
%entropy generated within the system is at a maximum. Assuming our
%temperature averaged Cv values are sufficiently accurate, we should find
%the maximum entropy occurs at approximately the same equilibrium
%temperature we found using the Conservation of Energy.

%Find and display the equilbrium temperature based on maximum entropy.
[M2,I2] = max(S_gen2);
disp("The maximum entropy is " + M2 + " [kJ/K]")
disp("The equilibrium temperature based on maximum entropy then is " + T_B2(I2) + " [K]")

%Note that the temperature and entropy found here are slightly off from
%their EES values, with a percent error for entropy and temperature of
%-1.8% and 1.4%, respectively. Most of this error is introduced from using
%an equivalent Cv value as opposed to loading the internal energy values
%and moving piecemeal through the CoE with that instead.