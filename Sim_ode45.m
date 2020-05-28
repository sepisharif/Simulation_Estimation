
clc
clear all
%% Initialise environment variables
minTime=0.1;
maxTime=24;
dose = 2;
y0=[dose 0];
options=odeset('RelTol',1e-6);
T=[0.1 0.25 0.5 0.75 1 2 4 6 8 12 16 24];
%% set up ODE solution and simulation by ode45 for different timepoints
Getparameters
%% error
eps=normrnd(0, 0.1,1,length(T));

 %% simulation by ode45 
 
[t,y]=ode45(@odefunction,[minTime  maxTime], [y0],options,ka,v,vmax,km);
sol=ode45(@odefunction,[minTime  maxTime], [y0],options,ka,v,vmax,km);

rspl=deval(sol,T);

y_ode=y(:,2);
y_sim=rspl(2,:);
y_observed=y_sim+eps;

plot(t,y_ode)
hold on
plot(T, rspl(2,:), 'ro');
hold on
plot(T,y_observed,'bo');
legend('yode45','ySimode45','yObservedode45')
y_out=[y_observed;y_sim];
save('y_out.mat')
 xlabel('time')
 ylabel('concentration')
