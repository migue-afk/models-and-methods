%% Monte Carlo Double Integral - GNU Octave
% Monte Carlo estimation of a double integral
% with 3D visualization of random samples.


clear;
clc;
close all;

% Reproducible random sequence
rand("seed", 42);

%% Integration domain

xMin = 0;
xMax = 3;

yMin = 0;
yMax = 2;

%% Define the function

f = @(x,y) -(x.^2 - 2*x) .* exp(-x.^2 - y.^2 - x.*y);

%% Find approximate vertical limits of the surface

xGrid = linspace(xMin, xMax, 20);
yGrid = linspace(yMin, yMax, 20);

[X,Y] = meshgrid(xGrid, yGrid);
Z = f(X,Y);

zMin = min(Z(:));
zMax = max(Z(:));

%% Monte Carlo experiment

N = 10000;

% Generate random points inside the 3D bounding box
x = xMin + (xMax - xMin) .* rand(N,1);
y = yMin + (yMax - yMin) .* rand(N,1);
z = zMin + (zMax - zMin) .* rand(N,1);

% Evaluate the surface at each random (x,y)
surfaceValues = f(x,y);

% Points below and above the surface
below = z <= surfaceValues;
above = ~below;

%% Monte Carlo integral estimation

% Fraction of points below the surface
p = sum(below) / N;

% Area of the XY domain
domainArea = (xMax - xMin) * (yMax - yMin);

% Estimate the integral
monteCarloIntegral = domainArea * ...
    (zMin + (zMax - zMin) * p);

%% Reference numerical integral

exactVolume = integral2(f, xMin, xMax, yMin, yMax);

%% Error

absoluteError = abs(exactVolume - monteCarloIntegral);

relativeError = absoluteError / abs(exactVolume) * 100;

%% Visualization

figure(1);
clf;

% Draw a lightweight surface
mesh(X,Y,Z);

hold on;

% Plot only a subset of samples to avoid Octave Online limits
nPlot = 250;

plotIndex = 1:min(nPlot,N);

belowPlot = below(plotIndex);
abovePlot = above(plotIndex);

xPlot = x(plotIndex);
yPlot = y(plotIndex);
zPlot = z(plotIndex);

% Samples below the surface
plot3( ...
    xPlot(belowPlot), ...
    yPlot(belowPlot), ...
    zPlot(belowPlot), ...
    'r.', ...
    'MarkerSize', 3);

% Samples above the surface
plot3( ...
    xPlot(abovePlot), ...
    yPlot(abovePlot), ...
    zPlot(abovePlot), ...
    'g.', ...
    'MarkerSize', 3);

xlabel("x");
ylabel("y");
zlabel("z");

title("Monte Carlo Double Integration");

legend( ...
    "Surface", ...
    "Below surface", ...
    "Above surface");

grid on;

view(45,30);

hold off;

%% Display result


fprintf("\n");
fprintf("========================================\n");
fprintf(" Monte Carlo Integration\n");
fprintf("========================================\n");
fprintf("Samples: %d\n", N);
fprintf("Estimated Volume: %.8f\n", monteCarloIntegral);
fprintf("Reference Volume: %.8f\n", exactVolume);
fprintf("Absolute Error:   %.8f\n", absoluteError);
fprintf("Relative Error:   %.4f %%\n", relativeError);
fprintf("========================================\n");