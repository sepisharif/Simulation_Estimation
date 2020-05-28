function [sse]= sse(P)
ka=1; v=1; vmax=0.0734; km=0.3672;
P(1)=ka;P(2)=v;P(3)=vmax;P(4)=km;

%% Initialise environment variables
minTime=0.1;
maxTime=24;
dose = 2;
y0=[dose 0];
options=odeset('RelTol',1e-6);
T=[0.1 0.25 0.5 0.75 1 2 4 6 8 12 16 24];

%% error
%R = normrnd(MU,SIGMA,M,N,...) or R = normrnd(MU,SIGMA,[M,N,...])
eps=normrnd(0, 0.1,1,length(T));

 %% simulation by ode45 
 
[t,y]=ode45(@odefunction,[minTime  maxTime], [y0],options,ka,v,vmax,km);
sol=ode45(@odefunction,[minTime  maxTime], [y0],options,ka,v,vmax,km);

rspl=deval(sol,T);

y_ode=y(:,2);
y_sim=rspl(2,:);
y_observed=y_sim+eps;

% plot(t,y_ode)
% hold on
% plot(T, rspl(2,:), 'ro');
% hold on
% plot(T,y_observed,'bo');

y_out=[y_observed;y_sim];
save('y_out.mat')



%ds=This quantity indicates the variation of the estimated values of the response variable of the model
 sse=sum((y_observed-y_sim).^2);
 