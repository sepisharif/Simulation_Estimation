%% Code written by Sepi
% This code intends to show how inductive method can use to describes
%the concentration of a drug with first-order input and Michaelis-Menten output,.
% Date: 06 August 2019

%% Initialise environment variables
clc
clear all

N_iterations_linearisation = 10;
StepSize  = 0.01; % ME
maxTime=48;
time=[0:StepSize: maxTime];


%% Initialise design variables

dose = 2; % mg

%% Initial conditions
y0=[dose 0];
C0=zeros(size(time));

%% Get parametes
Getparameters

%% Get ODE45 solution for original nonlinear problem
tic
ODE45Solution
ode_time=toc

y0_update=C0;

tic
for Loop1=1:N_iterations_linearisation % this updates C0

    %% ME solution

    for Loop2=1:length(time)
        CLt=vmax/(km + y0_update(Loop2));
        % define eigenvalue decomposition
        k20=-CLt/v;

        K=[-ka          0
            ka          k20];

        [P_m,Lam_m]=eig(K);
        Pinv=inv(P_m);
        MPart=P_m* (exp(Lam_m*StepSize).*eye(2)) * Pinv;
        if Loop2==1
            y_me = MPart*y0';
        else
            y_me = MPart*y_me_prev;
        end
        y_me_prev=y_me;
        % calculate new initial values
        y0_new(Loop2)=y_me(2);
    end
    
    y0_update=y0_new;
    y0_keep(Loop1,:) = y0_update;

end
me_time=toc


%% plot Me iterations
figure (1)
plot(time, y0_keep)
hold on
 plot(t,c_ode,'r','LineWidth',2)
hold off
% title('Inductive method for Michealis-Menten elimination nonlinear ODe system')
 xlabel('Time')
 ylabel('Concentartion')
% legend('Inductive method','ode45')
 legend('inductive','ode45')
% % 
% % figure (2)
% % semilogy(time, y0_keep)
% % hold on
% % semilogy(t_ode,c_ode,'r-')
% % hold off
% % 
% % ODE45Solution_atTIME
% % 
%  reldiff=abs((y0_keep(N_iterations_linearisation,:)-c_ode)./c_ode);
%  
%  figure (3)
%  
% semilogy(c_ode, reldiff)
%  
%  figure (4)
%  semilogy(time, reldiff)
%  
