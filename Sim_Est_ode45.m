clc
clear all
clf
%% Initializing

options = optimset('PlotFcns','optimplotfval','TolX',1e-7);
T=[0.1 0.25 0.5 0.75 1 2 4 6 8 12 16 24];
load('y_out.mat');
 %% fminsearch 
[P, fval]=fminsearch(@sse,[1,1,1,1],options); 
%% plot
figure(1)
plot(T,y_observed,'bo')
hold on
plot(T,y_sim)
xlabel('time')
ylabel('concentration')
legend('yModelode45','yObservedode45')

%% estimated parameters
Est_Para=array2table(P)
Res=y_observed-y_sim;%resedual
Resedual=array2table(Res)
SD=sse %sums quared error= standard deviation or sigma
