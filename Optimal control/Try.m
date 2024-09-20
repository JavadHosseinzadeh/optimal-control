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
%%
dimension=size(lowerbound,2);
SearchAgents=5*dimension;                      % number of Tasmanian Devil (population members) 
Max_iterations=10000;                  % maximum number of iteration
fitnessfcn = @(xxx)VPP_fitness(xxx,A,B,C,D,PL,N,Ts);
tic
start_time = fix(clock)
[Best_score,Best_pos,TDO_curve]=TDO(SearchAgents,Max_iterations,lowerbound,upperbound,dimension,fitnessfcn);  % Calculating the solution of the given problem using TDO 
stop_time = fix(clock)
toc
%%
dimension=3*480;
dim = dimension/3;
% u(1,:) = Best_pos(1,1:dim);
% u(2,:) = Best_pos(1,dim + 1:2*dim);
% u(3,:) = Best_pos(1,2*dim + 1 : 3*dim);
x(:,1) = [0.1;0.1;0.1;0;0;0;0;0;0];
PL = [0.5*ones(N/6,1);0.8*ones(N/6,1);1.5*ones(N/6,1);...
    1*ones(N/6,1);2*ones(N/6,1);1.6*ones(N/6,1)]'*(1.1/1.6);

for k = 1:N-1
    x(:,k+1) = x(:,k) + Ts*(A*x(:,k) + B*u(:,k));
end

J = (C*x - PL).^2;
save('result_24_005_5dim_10000)','PL','u','t','J','LowerInput1','LowerInput2','LowerInput3',...
    'UpperInput1','UpperInput2','UpperInput3','start_time','stop_time')

figure(1);
plot(t,J,'r');
%legend('Cost function');
xlabel('Time [h]');
ylabel('Cost [w]');
%xlim([0 23.9]);
grid;
title('Cost function of VPP power control');
set(0,'DefaultAxesFontName', 'Times New Roman','DefaultAxesFontWeight','bold')
set(0,'DefaultAxesFontSize', 12,'DefaultLineLineWidth', 2.5);
colormap(copper)
%%
figure(2);
plot(t,x(1,:),'Color',[1 1 0]); hold on
plot(t,x(2,:),'Color',[1 0 0]); hold on
plot(t,x(3,:),'Color',[0 1 1]); hold on
plot(t,x(4,:),'Color',[1 0 1]); hold on
plot(t,x(5,:),'Color',[0 1 0]); hold on
plot(t,x(6,:),'Color',[0 0 1]); hold on
plot(t,x(7,:),'Color',[0 0 0]); hold on
plot(t,x(8,:),'Color',[0.75 0.5 0.75]); hold on
plot(t,x(9,:),'Color',[.25 .75 .25]); hold on
%legend('States trajectory');
legend('$x_1$','$x_2$','$x_3$','$x_4$','$x_5$','$x_6$','$x_7$','$x_8$','$x_9$','Interpreter','Latex','FontSize', 15);
xlabel('Time [h]');
ylabel('State value');
%xlim([0 23.9]);
grid;
title('States trajectory of VPP power control');
set(0,'DefaultAxesFontName', 'Times New Roman','DefaultAxesFontWeight','bold')
set(0,'DefaultAxesFontSize', 12,'DefaultLineLineWidth', 2.5);
colormap(copper)
%%
figure(3);
subplot(3,1,1);
plot(t,u(2,:));
xlabel('Time [h]');
ylabel('EV input');
%xlim([0 23.9]);
grid;
title('optimal Inputs of VPP''s power control');
set(0,'DefaultAxesFontName', 'Times New Roman','DefaultAxesFontWeight','bold')
set(0,'DefaultAxesFontSize', 12,'DefaultLineLineWidth', 2.5);
colormap(copper)
subplot(3,1,2);
plot(t,u(1,:));
xlabel('Time [h]');
ylabel('WTG input');
%xlim([0 23.9]);
grid;
set(0,'DefaultAxesFontName', 'Times New Roman','DefaultAxesFontWeight','bold')
set(0,'DefaultAxesFontSize', 12,'DefaultLineLineWidth', 2.5);
colormap(copper)
subplot(3,1,3);
plot(t,u(3,:));
xlabel('Time [h]');
ylabel('STS input');
%xlim([0 23.9]);
grid;
set(0,'DefaultAxesFontName', 'Times New Roman','DefaultAxesFontWeight','bold')
set(0,'DefaultAxesFontSize', 12,'DefaultLineLineWidth', 2.5);
colormap(copper)
%%
figure(4),
plot(t,C*x)
hold on
plot(t,PL,'r')
legend('$P_G$','$P_L$','Interpreter','Latex','FontSize', 15);
xlabel('Time [h]');
ylabel('Power [w]');
%xlim([0 23.9]);
grid;
title('Comparison between generated power and load');
set(0,'DefaultAxesFontName', 'Times New Roman','DefaultAxesFontWeight','bold')
set(0,'DefaultAxesFontSize', 12,'DefaultLineLineWidth', 2.5);
colormap(copper)
%% input bounds
figure(5);
subplot(3,1,1);
plot(t,LowerInput2);
hold on 
plot(t,UpperInput2);
xlabel('Time [h]');
ylabel('EV input');
%xlim([0 23.9]);
grid;
legend('Lower bound of EV','Upper bound of EV','Interpreter','Latex','FontSize', 12);
title('Upper bound and lower bound of power generators in VPP model');
set(0,'DefaultAxesFontName', 'Times New Roman','DefaultAxesFontWeight','bold')
set(0,'DefaultAxesFontSize', 12,'DefaultLineLineWidth', 2.5);
colormap(copper)
subplot(3,1,2);
plot(t,LowerInput1);
hold on 
plot(t,UpperInput1);
xlabel('Time [h]');
ylabel('WTG input');
%xlim([0 23.9]);
grid;
legend('Lower bound of WTG','Upper bound of WTG','Interpreter','Latex','FontSize', 12);
set(0,'DefaultAxesFontName', 'Times New Roman','DefaultAxesFontWeight','bold')
set(0,'DefaultAxesFontSize', 12,'DefaultLineLineWidth', 2.5);
colormap(copper)
subplot(3,1,3);
plot(t,LowerInput3);
hold on 
plot(t,UpperInput3);
xlabel('Time [h]');
ylabel('STS input');
%xlim([0 23.9]);
grid;
legend('Lower bound of STS','Upper bound of STS','Interpreter','Latex','FontSize', 12);
set(0,'DefaultAxesFontName', 'Times New Roman','DefaultAxesFontWeight','bold')
set(0,'DefaultAxesFontSize', 12,'DefaultLineLineWidth', 2.5);
colormap(copper)