% f = @(x,y) x.*exp(-x.^2-y.^2)+(x.^2+y.^2)/20;
% fsurf(f,[-2,2],'ShowContours','on')
% fun = @(x) f(x(1),x(2));
% x0 = [-.5; 0];
% options = optimoptions('fminunc','Algorithm','quasi-newton');
% options.Display = 'iter';
% [x, fval, exitflag, output] = fminunc(fun,x0,options);
% uncx = x
% uncf = fval
load('Data.mat')
P = Data(:,1);
m = Data(:,2)/1000;
numglobe = 2;
fglobe = 400;
rho_g = 0.59;
rho_l = 1000;
sfff = 0.0074;
g = 9.8;
L = 1.2;
K = 10;
hfg = 2260;
area = 0.0005;
cp = 4.184;
m_dot = 0.1;
% q_dot = 1;
q_dot = P;
left = @(m_dot,q_dot) ((rho_l-rho_g)/(1+((1-(q_dot/(m_dot*hfg)))/(q_dot./(m_dot*hfg))*(rho_g/rho_l))))*g*L;
right = @(m_dot,q_dot) (1+(q_dot./(m_dot*hfg))*((rho_l/rho_g)-1))*((K*(m_dot.^2))/(2*rho_l*(area^2)));
right2 = @(m_dot) ((fglobe*(m_dot/(rho_l*area))^2)/(2*g)*numglobe)*rho_l*g;
% f = @(m_dot,K) ((((rho_l-rho_g)/(1+((1-(q_dot/(m_dot*hfg)))/(q_dot/(m_dot*hfg))*(rho_g/rho_l))))*g*L)-...
%     (1+(q_dot/(m_dot*hfg))*((rho_l/rho_g)-1))*((K*(m_dot^2))/(2*rho_l*(area^2))))^2;
% error = @(x) abs(right(x(1),x(2))-left(x(1)))^2;
n=9;
values = zeros(n,2);
for i=1:n
% error = @(x) sum((right(x(1),q_dot(i))+right2(x(1))-left(x(1),q_dot(i)))).^2+sum((m(i)-x(1))).^2;
error = @(x) sum((right(x(1),q_dot(i))+right2(x(1))-left(x(1),q_dot(i)))).^2;

% fun = @(x) f(x(1),x(2));
% x0 = [1, 3];
x0 = 0.1*ones(n,1);
% x0(:,2) = 2;
% x0 = 0.1;
A = [];
b = [];
Aeq =[];
beq = [];
lb = [0];
ub = [20];
% lb = zeros(n,1);
% ub = 10*ones(n,1);
% options = optimoptions('fmincon','Algorithm','interior-point','Display','iter');
% options.Display = 'iter';
% [x, fval, exitflag, output] = fmincon(fun,x0,A,b,Aeq,beq,lb,ub);
[x, fval, exitflag, output] = fmincon(error,x0(i),A,b,Aeq,beq,lb,ub);
values(i,:) = x;
end
fval
plot(q_dot,values(:,1))
hold on 
plot(P,m,'o')
% [x,resnorm,~,exitflag,output] = lsqcurvefit(fun,x0,P,m);
% hold on
% plot(t,F(x,t))
% hold off