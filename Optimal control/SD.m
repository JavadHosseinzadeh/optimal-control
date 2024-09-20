clc;
clear all;
close all;
%%
[A,B,C,D] = linmod2('VPP');
%
UpperInput1=[.1;0.1;0.1;0.1;0.1;.1;
    0.1;.1;.9;1;.9;.9;
    .3;.2;.4;1;0.1;0.1;
    0.1;0.1;0.1;0.1;0.1;0.1];
LowerInput1=[0;0;0;0;0;0;
    0;0;0;0;0;0;
    0;0;0;0;0;0;
    0;0;0;0;0;0];
%
UpperInput2=1;
LowerInput2=-1;
UpperInput3=[0;0;0;0;0;0;
    0;0;.1;.2;.4;.5;
    1;.9;0.3;.15;0;0;
    0;0;0;0;0;0]
LowerInput3=[0;0;0;0;0;0;
    0;0;0;0;0;0;
    0;0;0;0;0;0;
    0;0;0;0;0;0]

Ts = 0.05;
TT=1/Ts;
Tf = 24;
t = 0:Ts:Tf;
N = numel(t);
alpha = 0.1;
x = zeros(9,N);
u = zeros(3,N);
p = zeros(9,N);% 4000 = 4h
PL = [0.5*ones(80,1);0.8*ones(80,1);1.5*ones(80,1);...
      1*ones(80,1);2*ones(80,1);1.6*ones(81,1)]'*(1.1/1.6);
U1Low=0;
U1High=0.8;

U2Low=0;
U2High=0.8;

U3Low=0;
U3High=0.8;
%%
for M = 1:3000
    
    x(:,1) = [0.1;
        0.1;
        0.1;
        0;
        0;
        0;
        0;
        0;
        0];
    
    for k = 1:N-1
        
        x(:,k+1) = x(:,k) + Ts*(A*x(:,k) + B*u(:,k));
        
    end
    
    p(1,end) = 0;
    p(2,end) = 0;
    p(3,end) = 0;
    p(4,end) = 0;
    p(5,end) = 0;
    p(6,end) = 0;
    p(7,end) = 0;
    p(8,end) = 0;
    p(9,end) = 0;
    
    for k = N:-1:2
        p(1,k-1) = p(1,k) - Ts*(-1.34*(0.67*x(1,k) + 6.67*x(2,k) + x(3,k) - PL(:,k)) + 0.67*p(1,k));
        p(2,k-1) = p(2,k) - Ts*(-13.4*(0.67*x(1,k) + 6.67*x(2,k) + x(3,k) - PL(:,k)) + 6.67*p(2,k));
        p(3,k-1) = p(3,k) - Ts*(-2*(0.67*x(1,k) + 6.67*x(2,k) + x(3,k) - PL(:,k)) + p(3,k));
        p(4,k-1) = p(4,k) - Ts*(-4*p(1,k) + 2*p(4,k));
        p(5,k-1) = p(5,k) - Ts*(-4*p(2,k) + 2*p(5,k));
        p(6,k-1) = p(6,k) - Ts*(2*p(6,k) + 4*p(7,k));
        p(7,k-1) = p(7,k) - Ts*(0.75*p(7,k) - 0.75*p(8,k));
        p(8,k-1) = p(8,k) - Ts*(0.25*p(8,k) - 0.25*p(9,k));
        p(9,k-1) = p(9,k) - Ts*(12.5*p(9,k) - 12.5*p(3,k));
    end
    
    for l = 1:N
        
        u(1,l) = u(1,l) - alpha*(p(4,l) - p(1,l));
        u(2,l) = u(2,l) - alpha*(p(5,l) - p(2,l));
        u(3,l) = u(3,l) - alpha*(p(7,l) - p(6,l));
        % U1 = WT   U2 = EV  U3 = STS
        %0
        if l/TT==0
            U1Low=LowerInput1(1);
            U1High=UpperInput1(1);
            U2Low=LowerInput2;
            U2High=UpperInput2;
            U3Low=LowerInput3(1);
            U3High=UpperInput3(1);
        end
        %1
        if l/TT==1
            U1Low=LowerInput1(2);
            U1High=UpperInput1(2);
            U2Low=LowerInput2;
            U2High=UpperInput2;
            U3Low=LowerInput3(2);
            U3High=UpperInput3(2);
        end
        %2
        if l/TT==2
            U1Low=LowerInput1(3);
            U1High=UpperInput1(3);
            U2Low=LowerInput2;
            U2High=UpperInput2;
            U3Low=LowerInput3(3);
            U3High=UpperInput3(3);
        end
        %3
        if l/TT==3
            U1Low=LowerInput1(4);
            U1High=UpperInput1(4);
            U2Low=LowerInput2;
            U2High=UpperInput2;
            U3Low=LowerInput3(4);
            U3High=UpperInput3(4);
        end
        %4
        if l/TT==4
            U1Low=LowerInput1(5);
            U1High=UpperInput1(5);
            U2Low=LowerInput2;
            U2High=UpperInput2;
            U3Low=LowerInput3(5);
            U3High=UpperInput3(5);
        end
        %5
        if l/TT==5
            U1Low=LowerInput1(6);
            U1High=UpperInput1(6);
            U2Low=LowerInput2;
            U2High=UpperInput2;
            U3Low=LowerInput3(6);
            U3High=UpperInput3(6);
        end
        %6
        if l/TT==6
            U1Low=LowerInput1(7);
            U1High=UpperInput1(7);
            U2Low=LowerInput2;
            U2High=UpperInput2;
            U3Low=LowerInput3(7);
            U3High=UpperInput3(7);
        end
        %7
        if l/TT==7
            U1Low=LowerInput1(8);
            U1High=UpperInput1(8);
            U2Low=LowerInput2;
            U2High=UpperInput2;
            U3Low=LowerInput3(8);
            U3High=UpperInput3(8);
        end
        %8
        if l/TT==8
            U1Low=LowerInput1(9);
            U1High=UpperInput1(9);
            U2Low=LowerInput2;
            U2High=UpperInput2;
            U3Low=LowerInput3(9);
            U3High=UpperInput3(9);
        end
        %9
        if l/TT==9
            U1Low=LowerInput1(10);
            U1High=UpperInput1(10);
            U2Low=LowerInput2;
            U2High=UpperInput2;
            U3Low=LowerInput3(10);
            U3High=UpperInput3(10);
        end
        %10
        if l/TT==10
            U1Low=LowerInput1(11);
            U1High=UpperInput1(11);
            U2Low=LowerInput2;
            U2High=UpperInput2;
            U3Low=LowerInput3(11);
            U3High=UpperInput3(11);
        end
        %11
        if l/TT==11
            U1Low=LowerInput1(12);
            U1High=UpperInput1(12);
            U2Low=LowerInput2;
            U2High=UpperInput2;
            U3Low=LowerInput3(12);
            U3High=UpperInput3(12);
        end
        %12
        if l/TT==12
            U1Low=LowerInput1(13);
            U1High=UpperInput1(13);
            U2Low=LowerInput2;
            U2High=UpperInput2;
            U3Low=LowerInput3(13);
            U3High=UpperInput3(13);
        end
        %13
        if l/TT==13
            U1Low=LowerInput1(14);
            U1High=UpperInput1(14);
            U2Low=LowerInput2;
            U2High=UpperInput2;
            U3Low=LowerInput3(14);
            U3High=UpperInput3(14);
        end
        %14
        if l/TT==14
            U1Low=LowerInput1(15);
            U1High=UpperInput1(15);
            U2Low=LowerInput2;
            U2High=UpperInput2;
            U3Low=LowerInput3(15);
            U3High=UpperInput3(15);
        end
        %15
        if l/TT==15
            U1Low=LowerInput1(16);
            U1High=UpperInput1(16);
            U2Low=LowerInput2;
            U2High=UpperInput2;
            U3Low=LowerInput3(16);
            U3High=UpperInput3(16);
        end
        %16
        if l/TT==16
            U1Low=LowerInput1(17);
            U1High=UpperInput1(17);
            U2Low=LowerInput2;
            U2High=UpperInput2;
            U3Low=LowerInput3(17);
            U3High=UpperInput3(17);
        end
        %17
        if l/TT==17
            U1Low=LowerInput1(18);
            U1High=UpperInput1(18);
            U2Low=LowerInput2;
            U2High=UpperInput2;
            U3Low=LowerInput3(18);
            U3High=UpperInput3(18);
        end
        %18
        if l/TT==18
            U1Low=LowerInput1(19);
            U1High=UpperInput1(19);
            U2Low=LowerInput2;
            U2High=UpperInput2;
            U3Low=LowerInput3(19);
            U3High=UpperInput3(19);
        end
        %19
        if l/TT==19
            U1Low=LowerInput1(20);
            U1High=UpperInput1(20);
            U2Low=LowerInput2;
            U2High=UpperInput2;
            U3Low=LowerInput3(20);
            U3High=UpperInput3(20);
        end
        %20
        if l/TT==20
            U1Low=LowerInput1(21);
            U1High=UpperInput1(21);
            U2Low=LowerInput2;
            U2High=UpperInput2;
            U3Low=LowerInput3(21);
            U3High=UpperInput3(21);
        end
        %21
        if l/TT==21
            U1Low=LowerInput1(22);
            U1High=UpperInput1(22);
            U2Low=LowerInput2;
            U2High=UpperInput2;
            U3Low=LowerInput3(22);
            U3High=UpperInput3(22);
        end
        %22
        if l/TT==22
            U1Low=LowerInput1(23);
            U1High=UpperInput1(23);
            U2Low=LowerInput2;
            U2High=UpperInput2;
            U3Low=LowerInput3(23);
            U3High=UpperInput3(23);
        end
        %23
        if l/TT==23
            U1Low=LowerInput1(24);
            U1High=UpperInput1(24);
            U2Low=LowerInput2;
            U2High=UpperInput2;
            U3Low=LowerInput3(24);
            U3High=UpperInput3(24);
        end

        
        if u(1,l) > U1High
            u(1,l) = U1High;
        end
        if u(1,l) < U1Low
            u(1,l) = U1Low;
        end
        
        if u(2,l) > U2High
            u(2,l) = U2High;
        end
        if u(2,l) < U2Low
            u(2,l) = U2Low;
        end
        
        if u(3,l) > U3High
            u(3,l) = U3High;
        end
        if u(3,l) < U3Low
            u(3,l) = U3Low;
        end
    end
    
end
J = (C*x - PL).^2;
%%
figure(1);
plot(t,J,'r');
%legend('Cost function');
xlabel('Time [h]');
ylabel('Cost [w]');
xlim([0 23.9]);
grid;
title('Cost function of VPP power control');
set(0,'DefaultAxesFontName', 'Times New Roman','DefaultAxesFontWeight','bold')
set(0,'DefaultAxesFontSize', 12,'DefaultLineLineWidth', 2.5);
colormap(copper)
%%
figure(2);
plot(t,x(2,:),'Color',[1 1 0]); hold on
plot(t,x(1,:),'Color',[1 0 0]); hold on
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
xlim([0 23.9]);
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
xlim([0 23.9]);
grid;
title('optimal Inputs of VPP''s power control');
set(0,'DefaultAxesFontName', 'Times New Roman','DefaultAxesFontWeight','bold')
set(0,'DefaultAxesFontSize', 12,'DefaultLineLineWidth', 2.5);
colormap(copper)
subplot(3,1,2);
plot(t,u(1,:));
xlabel('Time [h]');
ylabel('WTG input');
xlim([0 23.9]);
grid;
set(0,'DefaultAxesFontName', 'Times New Roman','DefaultAxesFontWeight','bold')
set(0,'DefaultAxesFontSize', 12,'DefaultLineLineWidth', 2.5);
colormap(copper)
subplot(3,1,3);
plot(t,u(3,:));
xlabel('Time [h]');
ylabel('STS input');
xlim([0 23.9]);
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
xlim([0 23.9]);
grid;
title('Comparison between generated power and load');
set(0,'DefaultAxesFontName', 'Times New Roman','DefaultAxesFontWeight','bold')
set(0,'DefaultAxesFontSize', 12,'DefaultLineLineWidth', 2.5);
colormap(copper)
%% input bounds
figure(5);
subplot(3,1,1);
plot(1:24,LowerInput2'*ones(1,24));
hold on 
plot(1:24,UpperInput2*ones(1,24));
xlabel('Time [h]');
ylabel('EV input');
xlim([0 23.9]);
grid;
legend('Lower bound of EV','Upper bound of EV','Interpreter','Latex','FontSize', 12);
title('Upper bound and lower bound of power generators in VPP model');
set(0,'DefaultAxesFontName', 'Times New Roman','DefaultAxesFontWeight','bold')
set(0,'DefaultAxesFontSize', 12,'DefaultLineLineWidth', 2.5);
colormap(copper)
subplot(3,1,2);
plot(1:24,LowerInput1);
hold on 
plot(1:24,UpperInput1);
xlabel('Time [h]');
ylabel('WTG input');
xlim([0 23.9]);
grid;
legend('Lower bound of WTG','Upper bound of WTG','Interpreter','Latex','FontSize', 12);
set(0,'DefaultAxesFontName', 'Times New Roman','DefaultAxesFontWeight','bold')
set(0,'DefaultAxesFontSize', 12,'DefaultLineLineWidth', 2.5);
colormap(copper)
subplot(3,1,3);
plot(1:24,LowerInput3);
hold on 
plot(1:24,UpperInput3);
xlabel('Time [h]');
ylabel('STS input');
xlim([0 23.9]);
grid;
legend('Lower bound of STS','Upper bound of STS','Interpreter','Latex','FontSize', 12);
set(0,'DefaultAxesFontName', 'Times New Roman','DefaultAxesFontWeight','bold')
set(0,'DefaultAxesFontSize', 12,'DefaultLineLineWidth', 2.5);
colormap(copper)
%%
save('SD_24_005_3000','PL','u');
