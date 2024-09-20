%%
clc
clear all
close all
load ('pso_24_005_3000_3000.mat')
Ts = 0.05;
Tf = 24;
t = Ts:Ts:Tf;
N = numel(t);
[A,B,C,D] = linmod2('VPP');
u(1,:) = x_opt(1,1:N);
u(2,:) = x_opt(1,N + 1:2*N);
u(3,:) = x_opt(1,2*N + 1 : 3*N);
%%
x(:,1) = [0.1;0.1;0.1;0;0;0;0;0;0];
PL = [0.5*ones(N/6,1);0.8*ones(N/6,1);1.5*ones(N/6,1);...
    1*ones(N/6,1);2*ones(N/6,1);1.6*ones(N/6,1)]'*(1.1/1.6);
for k = 1:N-1
    x(:,k+1) = x(:,k) + Ts*(A*x(:,k) + B*u(:,k));
end
J = (C*x - PL).^2;

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