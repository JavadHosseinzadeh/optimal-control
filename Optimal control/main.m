


%% 
% Tasmanian Devil Optimization: A New Bio-Inspired Optimization Algorithm for Solving Optimization Algorithm
% IEEE access
% Mohammad Dehghani1, Štěpán Hubálovský2, and Pavel Trojovský1
% 1Department of Mathematics, Faculty of Science, University of Hradec Králové, 50003 Hradec Králové, Czech Republic
% 2Department of Applied Cybernetics, Faculty of Science, University of Hradec Králové, 50003 Hradec Králové, Czech Republic 

% " Optimizer"
%%
clc
clear
close all


%%
Fun_name='F1'; % number of test functions: 'F1' to 'F23'

SearchAgents=30;                      % number of Tasmanian Devil (population members) 
Max_iterations=1000;                  % maximum number of iteration
[lowerbound,upperbound,dimension,fitness]=fun_info(Fun_name); % Object function information
[Best_score,Best_pos,TDO_curve]=TDO(SearchAgents,Max_iterations,lowerbound,upperbound,dimension,fitness);  % Calculating the solution of the given problem using TDO 

%%

display(['The best solution obtained by TDO for ' [num2str(Fun_name)],'  is : ', num2str(Best_pos)]);
display(['The best optimal value of the objective funciton found by TDO  for ' [num2str(Fun_name)],'  is : ', num2str(Best_score)]);


        