clear;
% Parameters
clear;
close all;
ag = pi/2; % wind turbine blade orientation angle from z axis 
sd = 0.5; % safety distance from the structure
rt = 2; % wind tower raius
ht = 100 - sd; % the maximum distance the drone moves  
lh = 3; % length of the hub
rh = 3; % radius of wind turbine hub
lb = 50 + sd; % wind blade length plus safety distance
db = 5; 
h = 2 * rh; % diameter of the hub
a = h / 3; % distance from the centeroid of th hub to each wind blade starting point 
xa = rt + sd; % assuming the wind turbine axis of rotation align with x axis
ya = -(2 * a + lb) * sin(ag + pi - pi / 3);  % the y position of first blade end point
za = ht + a + (2 * a + lb) * cos(ag + pi - pi / 3); %the z position of first blade end point
xb = xa; 
yb = -(2 * a + lb) * sin(ag + pi + pi / 3);  % the y position of second blade end point
zb = ht + a + (2 * a + lb) * cos(ag + pi + pi / 3); % the z position of second blade end point
xc = xa; 
yc = -(2 * a + lb) * sin(ag); % the y position of third blade end point
zc = ht + a + (2 * a + lb) * cos(ag);% the z position of third blade end point
xd = xa; 
yd = -2 * a * sin(ag + pi - pi / 3); % the y position of first blade starting point
zd = ht + a + (2 * a) * cos(ag + pi - pi / 3);% the z position of first starting end point
xe = xa; 
ye = -2 * a * sin(ag + pi + pi / 3); % the y position of second blade starting point
ze = ht + a + (2 * a) * cos(ag + pi + pi / 3);% the z position of second starting end point
xf = xa; 
yf = -2 * a * sin(ag); % the y position of third blade starting point
zf = ht + a + 2 * a * cos(ag);% the z position of third starting end point
va = xa - 2;

% Define points
if ag <= pi / 3
    points = [
        xa,  0, 0;     % p0
        xa,  0, ht;    % p1
        xa, yd, zd;    % p2
        xa, ya, za;    % p3
        va, ya, za;    % p4
        va, yd, zd;    % p5
        va, yf, zf;    % p6
        va, yc, zc;    % p7
        xa, yc, zc;    % p8
        xa, yf, zf;    % p9
        xa, xe, ze;    % p10 
        xa, yb, zb;    % p11
        va, yb, zb;    % p12
        va, ye, ze;    % p13
       -xa, 0, ht;    % p14
       -xa, 0, 0;     % p15
    ];
else
    points = [
        xb,  0, 0;     % p0
        xb,  0, ht;    % p1
        xc, yd, zd;    % p2
        xa, ya, za;    % p3
        va, ya, za;    % p4
        va, yd, zd;    % p5
        va, yf, zf;    % p6
        va, yc, zc;    % p7
        xb, yc, zc;    % p8
        xb, yf, zf;    % p9
        xb, xe, ze;    % p10 
        xb, yb, zb;    % p11
        va, yb, zb;    % p12
        va, ye, ze;    % p13
       -xb, 0, ht;    % p14
       -xb, 0, 0;     % p15
    ];
end

% Extract x, y, and z coordinates
x = points(:, 1)';
y = points(:, 2)';
z = points(:, 3)';
% Determine initial and final points for each segment
a_x = x(1:end-1);     
a_y = y(1:end-1);     
a_z = z(1:end-1);
b_x = x(2:end);        
b_y = y(2:end);       
b_z = z(2:end);

[a_theta, a_phi, a_si] = deal(zeros(1, length(a_x)));
[b_theta, b_phi, b_si] = deal(zeros(1, length(a_x)));

% Determine required time for each segment and total required time
T_r = abs([b_x - a_x; b_y - a_y; b_z - a_z]);
T = 2 * max(T_r);
T_s = sum(T);
% Initialize T_r with the first element of T
T_r = zeros(1, length(T));
% Calculate cumulative sums for T_r (time segment)
for i = 1:length(T)
    T_r(i) = sum(T(1:i));
end
