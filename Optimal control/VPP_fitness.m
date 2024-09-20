function Cost = VPP_fitness(Input,A,B,C,D,PL,N,Ts)
% Ts = 1;
% Tf = 864;
% t = Ts:Ts:Tf;
% N = numel(t);
%[A,B,C,D] = linmod2('VPP');
dim = size(Input,2)/3;
u(1,:) = Input(1,1:dim);
u(2,:) = Input(1,dim + 1:2*dim);
u(3,:) = Input(1,2*dim + 1 : 3*dim);
x(:,1) = [0.1;0.1;0.1;0;0;0;0;0;0];
for k = 1:N-1
    x(:,k+1) = x(:,k) + Ts*(A*x(:,k) + B*u(:,k));
end
Cost = sum((C*x - PL).^2);
end

