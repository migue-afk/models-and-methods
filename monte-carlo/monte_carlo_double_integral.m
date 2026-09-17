%% Monte Carlo Double Integral Estimation
% This script estimates the volume under a 2D surface using the
% Monte Carlo integration method and compares the result with MATLAB's
% numerical integration using integral2.
%


clear;
close all;
clc;

%rng(42);

%% Integration domain

xMin = 0;
xMax = 3;

yMin = 0;
yMax = 2;

%% Define the surface

f = @(x,y) -(x.^2 - 2*x) .* exp(-x.^2 - y.^2 - x.*y);

%% Estimate an upper bound for the surface

xGrid = linspace(xMin, xMax, 100);
yGrid = linspace(yMin, yMax, 100);

[X, Y] = meshgrid(xGrid, yGrid);
Z = f(X, Y);

h = max(Z, [], 'all');

%% Bounding box volume

% The Monte Carlo experiment is performed inside the rectangular prism:
%
% [xMin, xMax] x [yMin, yMax] x [0, h]

boundingVolume = ...
    (xMax - xMin) * ...
    (yMax - yMin) * h;

%% Monte Carlo experiment

numSamples = 10000;

% Generate uniformly distributed random numbers in [0,1]
randomPoints = rand(numSamples, 3);

% Map the random points to the bounding volume

x = xMin + randomPoints(:,1) * (xMax - xMin);
y = yMin + randomPoints(:,2) * (yMax - yMin);
z = randomPoints(:,3) * h;

%% Determine points below the surface

surfaceValues = f(x, y);

inside = z <= surfaceValues;

% Number of successful samples
numHits = sum(inside);

%% Estimate the integral

estimatedVolume = boundingVolume * numHits / numSamples;

%% Compute the reference value

exactVolume = integral2(f, ...
    xMin, xMax, ...
    yMin, yMax);

%% Calculate absolute error

absoluteError = abs(exactVolume - estimatedVolume);

%% Display results

fprintf('\n========================================\n');
fprintf('   Monte Carlo Integration Results\n');
fprintf('========================================\n');
fprintf('Number of samples : %d\n', numSamples);
fprintf('Monte Carlo result: %.8f\n', estimatedVolume);
fprintf('Reference result  : %.8f\n', exactVolume);
fprintf('Absolute error    : %.8f\n', absoluteError);
fprintf('========================================\n\n');

%% Visualization

figure;

fsurf(f, [xMin xMax yMin yMax]);
hold on;

% Points located below the surface
plot3( ...
    x(inside), ...
    y(inside), ...
    z(inside), ...
    'ro', ...
    'MarkerSize', 2);

% Points located above the surface
plot3( ...
    x(~inside), ...
    y(~inside), ...
    z(~inside), ...
    'go', ...
    'MarkerSize', 2);

xlabel('x');
ylabel('y');
zlabel('z');

title('Monte Carlo Integration');

legend( ...
    'Surface', ...
    'Accepted samples', ...
    'Rejected samples', ...
    'Location', 'best');

grid on;
view(3);

hold off;