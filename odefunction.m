function dxdt = odefunction(~,y,ka,v,vmax,km)
%ODE45 solution for non linear elimination model, michealis menten

c=y(2)/v;
CLt=vmax/(km+c);
dxdt= [-ka*y(1)
  ka*y(1)-CLt/v*y(2)];      
end
