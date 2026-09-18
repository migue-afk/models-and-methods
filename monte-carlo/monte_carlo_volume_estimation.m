clear all;
close all;

%% ========================================================================
%  MONTE CARLO VOLUME ESTIMATION
%  ========================================================================
%
%  This script estimates the volume under the surface
%
%       f(x,y) = 3x^2 - sin(y)
%
%  using the Hit-or-Miss Monte Carlo method.
%
%  Two square integration regions are considered:
%
%       Outer region: [-2, 2] x [-2, 2]
%       Inner region: [-1, 1] x [-1, 1]
%
%  For each region, random points are generated inside a bounding
%  rectangular prism. Points located below the surface are counted as
%  successful samples.
%
%  The Monte Carlo approximation is compared with MATLAB's integral2()
%  numerical integration result.
%
%  Finally, the difference between the outer and inner estimated volumes
%  is calculated.
%
% ========================================================================


%% ========================================================================
%  OUTER REGION
%  Integration domain: [-2, 2] x [-2, 2]
%  ========================================================================

% Define integration limits
a = -2;
b = 2;      % Outer integral limits

c = -2;
d = 2;      % Inner integral limits


% -------------------------------------------------------------------------
% Define the surface
% -------------------------------------------------------------------------

f = @(x,y) 3.*x.^2 - sin(y);

x = linspace(a,b,100);
y = linspace(c,d,100);

% Upper bound of the surface
h = max(f(x,y));


% -------------------------------------------------------------------------
% Define the volume of the bounding rectangular prism R
% -------------------------------------------------------------------------

R = (b-a)*(d-c)*h;


% -------------------------------------------------------------------------
% Initialize the Monte Carlo experiment
% -------------------------------------------------------------------------

nc = 0;             % Number of successful samples
n = 20000;          % Total number of random samples


% -------------------------------------------------------------------------
% Generate n uniformly distributed random numbers between 0 and 1
% -------------------------------------------------------------------------

r = rand(n,3);


% -------------------------------------------------------------------------
% Generate a cloud of n random points inside:
%
%       R = [a,b] x [c,d] x [0,h]
%
% The generated points follow a uniform distribution over each interval.
% -------------------------------------------------------------------------

x = a + r(:,1)*(b-a);
y = c + r(:,2)*(d-c);
z = r(:,3)*h;


% -------------------------------------------------------------------------
% Identify points located below the surface
%
% A point is considered successful when:
%
%       z <= f(x,y)
% -------------------------------------------------------------------------

idx = z <= f(x,y);


% -------------------------------------------------------------------------
% Count successful samples and estimate the volume
% -------------------------------------------------------------------------

nc = sum(idx);

vol_esti_r2 = R*nc/n


% -------------------------------------------------------------------------
% Compute the reference value using numerical integration
% -------------------------------------------------------------------------

vol_real_r2 = integral2(f,a,b,c,d)


% Absolute error
error_r2 = abs(vol_real_r2-vol_esti_r2)


% -------------------------------------------------------------------------
% Plot the Monte Carlo experiment
%
% Red points   : points below the surface
% Green points : points above the surface
% -------------------------------------------------------------------------

figure()

fsurf(f,[-2 2 -2 2]);

hold on

plot3( ...
    x(idx,1), ...
    y(idx,1), ...
    z(idx,1), ...
    'rx', ...
    'MarkerSize',2 ...
) % Points that satisfy the condition

plot3( ...
    x(~idx,1), ...
    y(~idx,1), ...
    z(~idx,1), ...
    'gx', ...
    'MarkerSize',2 ...
) % Points that do not satisfy the condition

title('Volume under the surface with r_e = 2')

xlabel('X')
ylabel('Y')
zlabel('Z')


%% ========================================================================
%  INNER REGION
%  Integration domain: [-1, 1] x [-1, 1]
%  ========================================================================

% Define integration limits
a = -1;
b = 1;      % Outer integral limits

c = -1;
d = 1;      % Inner integral limits


% -------------------------------------------------------------------------
% Define the surface
% -------------------------------------------------------------------------

f = @(x,y) 3.*x.^2 - sin(y);

x = linspace(a,b,100);
y = linspace(c,d,100);

% Upper bound of the surface
h = max(f(x,y));


% -------------------------------------------------------------------------
% Define the volume of the bounding rectangular prism R
% -------------------------------------------------------------------------

R = (b-a)*(d-c)*h;


% -------------------------------------------------------------------------
% Initialize the Monte Carlo experiment
% -------------------------------------------------------------------------

nc = 0;             % Number of successful samples
n = 20000;          % Total number of random samples


% -------------------------------------------------------------------------
% Generate n uniformly distributed random numbers between 0 and 1
% -------------------------------------------------------------------------

r = rand(n,3);


% -------------------------------------------------------------------------
% Generate a cloud of n random points inside:
%
%       R = [a,b] x [c,d] x [0,h]
%
% The generated points follow a uniform distribution over each interval.
% -------------------------------------------------------------------------

x = a + r(:,1)*(b-a);
y = c + r(:,2)*(d-c);
z = r(:,3)*h;


% -------------------------------------------------------------------------
% Identify points located below the surface
% -------------------------------------------------------------------------

idx = z <= f(x,y);


% -------------------------------------------------------------------------
% Count successful samples and estimate the volume
% -------------------------------------------------------------------------

nc = sum(idx);

vol_esti = R*nc/n


% -------------------------------------------------------------------------
% Compute the reference value using numerical integration
% -------------------------------------------------------------------------

vol_real = integral2(f,a,b,c,d)


% Absolute error
error = abs(vol_real-vol_esti)


% -------------------------------------------------------------------------
% Plot the Monte Carlo experiment
%
% Red points   : points below the surface
% Green points : points above the surface
% -------------------------------------------------------------------------

figure()

fsurf(f,[-2 2 -2 2]);

hold on

plot3( ...
    x(idx,1), ...
    y(idx,1), ...
    z(idx,1), ...
    'r+', ...
    'MarkerSize',2 ...
) % Points that satisfy the condition

plot3( ...
    x(~idx,1), ...
    y(~idx,1), ...
    z(~idx,1), ...
    'g+', ...
    'MarkerSize',2 ...
) % Points that do not satisfy the condition

title('Volume under the surface with r_i = 1')

xlabel('X')
ylabel('Y')
zlabel('Z')


%% ========================================================================
%  FINAL APPROXIMATION
%  ========================================================================
%
% Difference between the estimated volume of the outer region and the
% estimated volume of the inner region.
% ========================================================================

Aproximation = vol_esti_r2-vol_esti