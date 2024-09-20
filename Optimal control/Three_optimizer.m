clc
clear
close all
warning('off')
%% initial
Ts = 0.05;
Tf = 24;
t = Ts:Ts:Tf;
N = numel(t);
x = zeros(9,N);
u = zeros(3,N);
%[A,B,C,D] = dlinmod('VPP',Ts);
[A,B,C,D] = linmod2('VPP');
PL = [0.5*ones(N/6,1);0.8*ones(N/6,1);1.5*ones(N/6,1);...
      1*ones(N/6,1);2*ones(N/6,1);1.6*ones(N/6,1)]'*(1.1/1.6);
%% Upper and lower
UpperInput11= [.1;0.1;0.1;0.1;0.1;.1;
    0.1;.1;.9;1;.9;.9;
    .3;.2;.4;1;0.1;0.1;
    0.1;0.1;0.1;0.1;0.1;0.1];
UpperInput1 = repelem(UpperInput11,N/24)';
LowerInput1 = zeros(1,N);
%
UpperInput2 = 1*ones(1,N);
LowerInput2 = -1*ones(1,N);
%
UpperInput33 = [0;0;0;0;0;0;
    0;0;.1;.2;.4;.5;
    1;.9;0.3;.15;0;0;
    0;0;0;0;0;0];
UpperInput3 = repelem(UpperInput33,N/24)';
LowerInput3 = zeros(1,N);
upperbound = [UpperInput1 UpperInput2 UpperInput3];
lowerbound = [LowerInput1 LowerInput2 LowerInput3];
%% 5398.064884 seconds
% iterr=750;
% popp=2000;
% tic
% fitnessfcn = @(xxx)VPP_fitness(xxx,A,B,C,D,PL,N,Ts);
% opt = gaoptimset('Generations',iterr,'PopulationSize',popp,'Display','iter');
% x_opt = ga(fitnessfcn,3*480,[],[],[],[],lowerbound,upperbound,[],opt);
% save('ga_24_005_100_2000','PL','x_opt','u','t','LowerInput1','LowerInput2','LowerInput3',...
%     'UpperInput1','UpperInput2','UpperInput3')
% toc
%% 7656.456375 seconds
iterr=10000;
popp=5000;
tic
opti = optimoptions('particleswarm','SwarmSize',popp,'MaxIterations',iterr,'Display','iter');
fitnessfcn = @(xxx)VPP_fitness(xxx,A,B,C,D,PL,N,Ts);
x_opt = particleswarm(fitnessfcn,3*480,lowerbound,upperbound,opti);
save('pso_24_005_10000_5000','PL','x_opt','u','t','LowerInput1','LowerInput2','LowerInput3',...
    'UpperInput1','UpperInput2','UpperInput3')
toc
