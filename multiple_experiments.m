%% Clear variables
clc; clear all; close all;

%% DEFINITION OF TIME VARIABLES
ts = 0.05;
t_f = 20;
to = 0;
t = (to:ts:t_f);
Nt = length(t);   % number of discrete time steps

%% Number of experiments
N_exp = 10;  % you can change this as you wish

%% Allocate arrays for storing simulation results
% Format desired: (number_experiments) x 5 x (time_length + 1)
X_data = zeros(N_exp, 5, Nt + 1);

% Control actions: (number_experiments) x 2 x time_length
U_data = zeros(N_exp, 2, Nt);

% Optional: If you do not need any control at all (v=0, w=0 are forced),
% you might not need a control_law() function. But we show how to store zeros.
%% Define control gains
k1 = 1;
k2 = 1;
%% Loop over number of experiments
for iExp = 1:N_exp
    
    % 1) Generate random initial conditions
    %    x and y in [-5, 5], theta in [0, 2*pi], v=0, w=0
    x1 = -5 + 10*rand(1);     % random in [-5, 5]
    y1 = -5 + 10*rand(1);     % random in [-5, 5]
    theta1 = 2*pi*rand(1);    % random in [0, 2*pi]
    v1 = 0;                   % always zero
    w1 = 0;                   % always zero
    
    % Put them into the state vector
    x = zeros(5, Nt + 1);   
    x(:, 1) = [x1; y1; theta1; v1; w1];
    
    % 2) We will store the control inputs (which are zero in this case)
    u_c = zeros(2, Nt);  % 2 x time_length
    
    % If you have a custom control law, comment it out or ensure it returns [0;0].
    % For purely zero velocities, you can skip calling any control function:
    % e.g., u_c(:, k) = [0; 0];
    
    %% Simulation Loop for a single experiment
    for k = 1:Nt
        
        % Force v = 0, w = 0
        u_c(:, k) = control_law(x(:, k), k1, k2);
        
        % Update system
        x(:, k+1) = system_vehicle(x(:, k), u_c(:, k), ts);
    end
    
    % 3) Store results of this experiment
    X_data(iExp, :, :) = x;       % shape: 1 x 5 x (Nt+1)
    U_data(iExp, :, :) = u_c;     % shape: 1 x 2 x Nt
    
end

% Assuming you have already loaded or generated the following variables:
%   X_data of size (N_exp x 5 x (Nt+1))
%   t of size (1 x Nt+1)
%   N_exp = number of experiments
%   Nt = length(t) - 1
%
% Each experiment iExp has the states:
%   X_data(iExp,1,:) = x(t)
%   X_data(iExp,2,:) = y(t)
%   X_data(iExp,3,:) = theta(t)
%   X_data(iExp,4,:) = nu(t)
%   X_data(iExp,5,:) = omega(t)

%% Figures Colors Definition (your original color palettes)
lw = 1; % linewidth
lwV = 2; 
fontsizeLabel = 11;
fontsizeLegend = 11;
fontsizeTicks = 11;
fontsizeTitel = 11;
sizeX = 1500; % figure size (width)
sizeY = 800;  % figure size (height)

c1 = [80, 81, 79]/255;
c2 = [244, 213, 141]/255;
c3 = [242, 95, 92]/255;
c4 = [112, 141, 129]/255;
c5 = [130, 37, 37]/255;
c6 = [205, 167, 37]/255;
c7 = [81, 115, 180]/255;
c8 = [80 80 80]/255;
c9 = [140 140 140]/255;
c10 = [0 128 255]/255;

C18 = [0 0 0];  % black
dual_color = [70, 130, 180]/255;
baseline_color = [250, 128, 114]/255;
blue  = [0.00, 0.4470, 0.7410];
red   = [0.85, 0.3250, 0.0980];
green = [0.4660, 0.6740, 0.1880];

dimension_x = [0.05, 0.50, 0.71];
dimension_y = [0.68, 0.53,  0.33, 0.20, 0.10, 0.0];
dimension_control = [0.88, 0.765,  0.645, 0.53];

% A cell array of colors to cycle through for each experiment
colorExp = {c1,c2,c3,c4,c5,c6,c7,c8,c9,c10};

%% A helper function to apply uniform axis styling
% (mimics your original axis style in a single function call)
applyAxisStyle = @(axHandle) set(axHandle, ...
    'Box','on', ...
    'BoxStyle','full', ...
    'TickLength',[0.01;0.01], ...
    'TickDirMode','auto', ...
    'YMinorTick','on', ...
    'XMinorTick','on', ...
    'XMinorGrid','on', ...
    'YMinorGrid','on', ...
    'MinorGridAlpha',0.15, ...
    'LineWidth',0.8, ...
    'FontSize',1.3*fontsizeTicks, ...
    'TickLabelInterpreter','latex');

%%%%%%%%%% 2) Plot x(t) for all experiments  %%%%%%%%%%
figure('Position', [500 500 sizeX sizeY])
set(gcf, 'Position', [500 500 sizeX sizeY]);
fig1_comps.fig = gcf;
%% PLot x
axes('Position',[dimension_x(1) dimension_y(3)+0.17 .4 .08]);
for iExp = 1:N_exp
    thisColor = colorExp{mod(iExp-1,numel(colorExp))+1};
    
    h_plot = line(t, squeeze(X_data(iExp,1,1:Nt)));
    set(h_plot, 'LineStyle','-', 'Color', thisColor, 'LineWidth',1.3*lw);
end

title({'$\textrm{Experiments}$'}, ...
      'Interpreter','latex','Color','black','FontSize',14);
ylabel('$x\,[m]$','Interpreter','latex','Color',C18,'FontSize',14);

xlim([t(1) t(end)]);
ax_1 = gca;
ax_1.Box = 'on';
ax_1.BoxStyle = 'full';
ax_1.TickLength = [0.01;0.01];
ax_1.XTickLabel = [];
ax_1.TickDirMode = 'auto';
ax_1.YMinorTick = 'on';
ax_1.XMinorTick = 'on';
ax_1.XMinorGrid = 'on';
ax_1.YMinorGrid = 'on';
ax_1.MinorGridAlpha = 0.15;
ax_1.LineWidth = 0.8;



%%%%%%%%%% 3) Plot y(t) for all experiments  %%%%%%%%%%
%% PLot y
axes('Position',[dimension_x(1) dimension_y(4)+0.20 .4 .08]);
for iExp = 1:N_exp
    thisColor = colorExp{mod(iExp-1,numel(colorExp))+1};
    
    h_plot = line(t, squeeze(X_data(iExp,2,1:Nt)));
    set(h_plot, 'LineStyle','-', 'Color', thisColor, 'LineWidth',1.3*lw);
end

ylabel('$y\,[m]$','Interpreter','latex','Color',C18,'FontSize',14);

xlim([t(1) t(end)]);
ax_1 = gca;
ax_1.Box = 'on';
ax_1.BoxStyle = 'full';
ax_1.TickLength = [0.01;0.01];
ax_1.XTickLabel = [];
ax_1.TickDirMode = 'auto';
ax_1.YMinorTick = 'on';
ax_1.XMinorTick = 'on';
ax_1.XMinorGrid = 'on';
ax_1.YMinorGrid = 'on';
ax_1.MinorGridAlpha = 0.15;
ax_1.LineWidth = 0.8;


%%%%%%%%%% 4) Plot theta(t) for all experiments  %%%%%%%%%%
%% PLot theta
axes('Position',[dimension_x(1) dimension_y(5)+0.20 .4 .08]);

for iExp = 1:N_exp
    thisColor = colorExp{mod(iExp-1,numel(colorExp))+1};
    
    h_plot = line(t, squeeze(X_data(iExp,3,1:Nt)));
    set(h_plot, 'LineStyle','-', 'Color', thisColor, 'LineWidth',1.3*lw);
end


ylabel('$\theta\,[rad]$','Interpreter','latex','Color',C18,'FontSize',14);

xlim([t(1) t(end)]);
ax_1 = gca;
ax_1.Box = 'on';
ax_1.BoxStyle = 'full';
ax_1.TickLength = [0.01;0.01];
ax_1.XTickLabel = [];
ax_1.TickDirMode = 'auto';
ax_1.YMinorTick = 'on';
ax_1.XMinorTick = 'on';
ax_1.XMinorGrid = 'on';
ax_1.YMinorGrid = 'on';
ax_1.MinorGridAlpha = 0.15;
ax_1.LineWidth = 0.8;



%%%%%%%%%% 5) Plot nu(t) for all experiments  %%%%%%%%%%
%% PLot nu
axes('Position',[dimension_x(1) dimension_y(6)+0.20 .4 .08]);
for iExp = 1:N_exp
    thisColor = colorExp{mod(iExp-1,numel(colorExp))+1};
    
    h_plot = line(t, squeeze(X_data(iExp,4,1:Nt)));
    set(h_plot, 'LineStyle','-', 'Color', thisColor, 'LineWidth',1.3*lw);
end


ylabel('$\nu\,[m/s]$','Interpreter','latex','Color',C18,'FontSize',14);

xlim([t(1) t(end)]);
ax_1 = gca;
ax_1.Box = 'on';
ax_1.BoxStyle = 'full';
ax_1.TickLength = [0.01;0.01];
ax_1.XTickLabel = [];
ax_1.TickDirMode = 'auto';
ax_1.YMinorTick = 'on';
ax_1.XMinorTick = 'on';
ax_1.XMinorGrid = 'on';
ax_1.YMinorGrid = 'on';
ax_1.MinorGridAlpha = 0.15;
ax_1.LineWidth = 0.8;


%% PLot omega
axes('Position',[dimension_x(1) dimension_y(6)+0.1 .4 .08]);

for iExp = 1:N_exp
    thisColor = colorExp{mod(iExp-1,numel(colorExp))+1};
    
    h_plot = line(t, squeeze(X_data(iExp,5,1:Nt)));
    set(h_plot, 'LineStyle','-', 'Color', thisColor, 'LineWidth',1.3*lw);
end


xlabel('$\textrm{Time}[s]$','fontsize',14,'interpreter','latex','Color',C18);
ylabel('$\omega\,[rad/s]$','Interpreter','latex','Color',C18,'FontSize',14);

xlim([t(1) t(end)]);
applyAxisStyle(gca);
set(gcf, 'Color', 'w');
export_fig Simulation_multiple.pdf -q101