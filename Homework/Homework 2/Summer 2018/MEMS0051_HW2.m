clear all % clears workspace variables
close all % closes all windows
clc % clears command window

Temperature = [0.01	5	10	15	20	25	30	35	40	45	50	55	60	65	70	75	80	85	90	95	100	105	110	115	120	125	130	135	140	145	150	155	160	165	170	175	180	185	190	195	200	205	210	215	220	225	230	235	240	245	250	255	260	265	270	275	280	285	290	295	300	305	310	315	320	325	330	335	340	345	350	355	360	365	370	374.1];

Pressure = [0.6113	0.8721	1.2276	1.705	2.339	3.169	4.246	5.628	7.384	9.593	12.35	15.758	19.941	25.03	31.19	38.58	47.39	57.83	70.14	84.55	101.3	120.8	143.3	169.1	198.5	232.1	270.1	313	361.3	415.4	475.9	543.1	617.8	700.5	791.7	892	1002.2	1122.7	1254.4	1397.8	1553.8	1723	1906.3	2104.2	2317.8	2547.7	2794.9	3060.1	3344.2	3648.2	3973	4319.5	4688.6	5081.3	5498.7	5941.8	6411.7	6909.4	7436	7992.8	8581	9201.8	9856.6	10547	11274	12040	12845	13694	14586	15525	16514	17554	18651	19807	21028	22089];

v_f = [0.001	0.001	0.001	0.001001	0.001002	0.001003	0.001004	0.001006	0.001008	0.00101	0.001012	0.001015	0.001017	0.00102	0.001023	0.001026	0.001029	0.001032	0.001036	0.00104	0.001044	0.001047	0.001052	0.001056	0.00106	0.001065	0.00107	0.001075	0.00108	0.001085	0.00109	0.001096	0.001102	0.001108	0.001114	0.001121	0.001127	0.001134	0.001141	0.001149	0.001156	0.001164	0.001173	0.001181	0.00119	0.001199	0.001209	0.001219	0.001229	0.00124	0.001251	0.001263	0.001276	0.001289	0.001302	0.001317	0.001332	0.001348	0.001366	0.001384	0.001404	0.001425	0.001447	0.001472	0.001499	0.001528	0.001561	0.001597	0.001638	0.001685	0.00174	0.001807	0.001892	0.002011	0.002213	0.003155];

v_g = [206.132	147.118	106.377	77.925	57.7897	43.3593	32.8932	25.2158	19.5229	15.2581	12.0318	9.56835	7.67071	6.19656	5.04217	4.13123	3.40715	2.82757	2.36056	1.98186	1.6729	1.41936	1.21014	1.03658	0.89186	0.77059	0.6685	0.58217	0.50885	0.44632	0.39278	0.34676	0.30706	0.27269	0.24283	0.2168	0.19405	0.17409	0.15654	0.14105	0.12736	0.11521	0.10441	0.09479	0.08619	0.07849	0.07158	0.06536	0.05976	0.0547	0.05013	0.04598	0.0422	0.03877	0.03564	0.03279	0.03017	0.02777	0.02557	0.02354	0.02167	0.01995	0.01835	0.01687	0.01549	0.0142	0.013	0.01186	0.0108	0.00978	0.00881	0.00787	0.00694	0.00599	0.00493	0.00315];

figure(1)
semilogx(v_f(:),Temperature(:),'b',v_g(:),Temperature(:),'r')
xlim([1e-4,1e3])
ylabel('Temperature [C]')
xlabel('Specific Volume [m^3/kg]')
title('T-v Diagram')
hold on

plot([1.694 1.694],[99.62 99.62] ,'.k')
text(1.694,90,' 5. initial')

plot([0.001148 0.001148],[99.62 99.62] ,'.k')
text(0.001148,90,' 5. final')
%plot([0.001044 1.694],[99.62 99.62] ,'k')

%%

figure(2)
loglog(v_f(:),Pressure(:),'b',v_g(:),Pressure(:),'r')
xlim([1e-4,1e3])
ylabel('Pressure [kPa]')
xlabel('Specific Volume [m^3/kg]')
title('P-v Diagram')
hold on
% 1.(a)
plot([0.018 0.018],[8581 8581] ,'.k')
text(0.018,8581,' 1.(a)')
% 1.(b)
plot([0.001044 0.001044],[101.3 101.3] ,'.k')
text(0.001044,175,' 1.(b)')
% 1.(c)
plot([0.3 0.3],[500 500] ,'.k')
text(0.3,500,' 1.(c)')
% 1.(d)
plot([0.001330 0.001330],[30000 30000] ,'.k')
text(0.001330,30000,' 1.(d)')
% 1.(e)
plot([0.00108 0.00108],[361.3 361.3] ,'.k')
text(0.00108,361.3,' 1.(e)')
% 1.(f)
plot([0.50885 0.50885],[361.3 361.3] ,'.k')
text(0.50885,361.3,' 1.(f)')
% 3
plot([0.001148 001148],[10000 10000] ,'.k')
text(0.001148,10000,' 3.')
% 5
plot([1.694 1.694],[100 100] ,'.k')
text(1.694,70,' 5. initial')
% 5
plot([0.001148 0.001148],[100 100] ,'.k')
text(0.001148,70,' 5. final')
plot([0.001044 1.694],[100 100] ,'k')

