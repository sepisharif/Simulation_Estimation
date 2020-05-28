
% Initialise environment variables
%% set up ODE solution
options=odeset('RelTol',1e-6);
[t,y]=ode45(@odefunction,[0  maxTime], [y0],options,ka,v,vmax,km);
%y=deval(sol,time );
c_ode=y(:,2)/v;
t_ode=t;
