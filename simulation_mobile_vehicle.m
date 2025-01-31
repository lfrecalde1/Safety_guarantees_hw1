%% Clear variables
clc, clear all, close all


%% DEFINITION OF TIME VARIABLES
ts = 0.05;
t_f = 20;
to = 0;
t = (to:ts:t_f);

%% Initial conditions of the system
x1 = 5;
y1 = 5;
theta1 = 90*(pi/180);
v1 = 0;
w = 0;

x = zeros(5, length(t) + 1);
x(:, 1) = [x1;y1;theta1;v1;w];

%% Control actions
u_c = zeros(2, length(t));

%% Define control gains
k1 = 1;
k2 = 1;

%% Simulation Loop
for k=1:length(t)
    u_c(:, k) = control_law(x(:, k), k1, k2);
    
    %% SIMULATION
    x(:, k+1) = system_vehicle(x(:, k), u_c(:, k), ts);
end

%% Figures Colors Definition
lw = 1; % linewidth 1
lwV = 2; % linewidth 2zz
fontsizeLabel = 11; %11
fontsizeLegend = 11;
fontsizeTicks = 11;
fontsizeTitel = 11;
sizeX = 1500; % size figure
sizeY = 800; % size figure

% color propreties
c1 = [80, 81, 79]/255;
c2 = [244, 213, 141]/255;
c3 = [242, 95, 92]/255;
c4 = [112, 141, 129]/255;

C18 = [0 0 0];
c5 = [130, 37, 37]/255;
c6 = [205, 167, 37]/255;
c7 = [81, 115, 180]/255;

C1 = [246 170 141]/255;
C2 = [51 187 238]/255;
C3 = [0 153 136]/255;
C4 = [238 119 51]/255;
C5 = [204 51 17]/255;
C6 = [238 51 119]/255;
C7 = [187 187 187]/255;
C8 = [80 80 80]/255;
C9 = [140 140 140]/255;
C10 = [0 128 255]/255;
C11 = [234 52 89]/255;
C12 = [39 124 252]/255;
C13 = [40 122 125]/255;
C14 = [252 94 158]/255;
C15 = [244 171 39]/255;
C16 = [100 121 162]/255;
C17 = [255 0 0]/255;

% Location Plots
dimension_x = [0.05, 0.50, 0.71];
dimension_y = [0.68, 0.53,  0.33, 0.20, 0.10, 0.0];
dimension_control = [0.88, 0.765,  0.645, 0.53];

dual_color = [70, 130, 180]/255;
baseline_color = [250, 128, 114]/255;

blue  = [0.00, 0.4470, 0.7410];
red   = [0.85, 0.3250, 0.0980];
green = [0.4660, 0.6740, 0.1880];

%% plot Results
figure('Position', [500 500 sizeX sizeY])
set(gcf, 'Position', [500 500 sizeX sizeY]);
fig1_comps.fig = gcf;


%% Plot xy
axes('Position',[dimension_x(1) dimension_y(1)-0.01 .4 .2]);
%% Real Trajectory Dual
h_plot_cbf = line(x(1,:),x(2,:));
set(h_plot_cbf, 'LineStyle', '-', 'Color', dual_color, 'LineWidth', 1.3*lw);
set(gca,'ticklabelinterpreter','latex',...
    'fontsize',1.3*fontsizeTicks)


%% Legend nomeclature
set(gca,'ticklabelinterpreter','latex',...
        'fontsize',1.0*fontsizeTicks)
title({'$\textrm{(a)}$'}, 'fontsize', 14, 'interpreter', 'latex', 'Color', 'black');
ylabel('$y_{L}~[m]$','fontsize',14,'interpreter','latex', 'Color',C18);
xlabel('$x_{L}~[m]$','fontsize',14,'interpreter','latex', 'Color',C18);

ax_1 = gca;
ax_1.Box = 'on';
ax_1.BoxStyle = 'full';
ax_1.TickLength = [0.01;0.01];
ax_1.TickDirMode = 'auto';
ax_1.YMinorTick = 'on';
ax_1.XMinorTick = 'on';
ax_1.XMinorGrid = 'on';
ax_1.YMinorGrid = 'on';
ax_1.MinorGridAlpha = 0.15;
ax_1.LineWidth = 0.8;
ax_1.XLim = [min(x(1,:))-0.1 max(x(1,:))+0.1];
ax_1.YLim = [min(x(2,:))-0.1 max(x(2,:))+0.1];


%% PLot x
axes('Position',[dimension_x(1) dimension_y(3)+0.17 .4 .08]);
%% Desired Trajectory
h_cbf = line(t, x(1,1:length(t)));
set(h_cbf, 'LineStyle', '-', 'Color', red, 'LineWidth', 1.3*lw);
%% Legend nomeclature
set(gca,'ticklabelinterpreter','latex',...
    'fontsize',1.3*fontsizeTicks)


%% Legend nomeclature
set(gca,'ticklabelinterpreter','latex',...
        'fontsize',1.0*fontsizeTicks)
title({'$\textrm{(b)}$'}, 'fontsize', 14, 'interpreter', 'latex', 'Color', 'black');
ylabel('$x~[m]$','fontsize',14,'interpreter','latex', 'Color',C18);


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
ax_1.XLim = [t(1), t(end)]; % Set limits for x-axis

%% PLot y
axes('Position',[dimension_x(1) dimension_y(4)+0.20 .4 .08]);
%% Desired Trajectory
h_cbf = line(t, x(2,1:length(t)));
set(h_cbf, 'LineStyle', '-', 'Color', green, 'LineWidth', 1.3*lw);
%% Legend nomeclature
set(gca,'ticklabelinterpreter','latex',...
    'fontsize',1.3*fontsizeTicks)


%% Legend nomeclature
set(gca,'ticklabelinterpreter','latex',...
        'fontsize',1.0*fontsizeTicks)
ylabel('$y~[m]$','fontsize',14,'interpreter','latex', 'Color',C18);


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
ax_1.XLim = [t(1), t(end)]; % Set limits for x-axis

%% PLot theta
axes('Position',[dimension_x(1) dimension_y(5)+0.20 .4 .08]);
%% Desired Trajectory
h_cbf = line(t, x(3,1:length(t)));
set(h_cbf, 'LineStyle', '-', 'Color', blue, 'LineWidth', 1.3*lw);
%% Legend nomeclature
set(gca,'ticklabelinterpreter','latex',...
    'fontsize',1.3*fontsizeTicks)


%% Legend nomeclature
set(gca,'ticklabelinterpreter','latex',...
        'fontsize',1.0*fontsizeTicks)
ylabel('$\theta~[rad]$','fontsize',14,'interpreter','latex', 'Color',C18);


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
ax_1.XLim = [t(1), t(end)]; % Set limits for x-axis

%% PLot nu
axes('Position',[dimension_x(1) dimension_y(6)+0.20 .4 .08]);
%% Desired Trajectory
h_cbf = line(t, x(4,1:length(t)));
set(h_cbf, 'LineStyle', '-', 'Color', dual_color, 'LineWidth', 1.3*lw);
%% Legend nomeclature
set(gca,'ticklabelinterpreter','latex',...
    'fontsize',1.3*fontsizeTicks)


%% Legend nomeclature
set(gca,'ticklabelinterpreter','latex',...
        'fontsize',1.0*fontsizeTicks)
ylabel('$\nu~[m/s]$','fontsize',14,'interpreter','latex', 'Color',C18);


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
ax_1.XLim = [t(1), t(end)]; % Set limits for x-axis

%% PLot omega
axes('Position',[dimension_x(1) dimension_y(6)+0.1 .4 .08]);
%% Desired Trajectory
h_cbf = line(t, x(5,1:length(t)));
set(h_cbf, 'LineStyle', '-', 'Color', baseline_color, 'LineWidth', 1.3*lw);
%% Legend nomeclature
set(gca,'ticklabelinterpreter','latex',...
    'fontsize',1.3*fontsizeTicks)


%% Legend nomeclature
set(gca,'ticklabelinterpreter','latex',...
        'fontsize',1.0*fontsizeTicks)
ylabel('$\omega~[rad/s]$','fontsize',14,'interpreter','latex', 'Color',C18);
xlabel('$\textrm{Time}[s]$','fontsize',14,'interpreter','latex','Color',C18);


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
ax_1.XLim = [t(1), t(end)]; % Set limits for x-axis

set(gcf, 'Color', 'w'); % Sets axes background
export_fig Simulation_initial_states.pdf -q101