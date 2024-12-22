 clear;
%parameters
clear;
close all;
ag=0;
sd=0.5;
rt=2;
ht=100 - sd;
lh=3;
rh=3;
lb=50 + sd;
db=5;
h=2*rh;
a=h/sqrt(3);
xa=rt+sd; ya=-(a+lb*abs(sin(30))); za=ht-lb*cos(30);
xb=xa; yb=a+lb*abs(sin(30)); zb=za;
xc=xa; yc=0; zc=ht + 2*rh + lb;
xd=xa; yd=-a; zd=ht;
xe=xa; ye=a; ze=ht;
xf=xa; yf=0; zf=ht+h;
va=xa-2;
% Define points
points = [
    xa,  0, 0;     % p0
    xa,  0, ht;    % p1
    xa, yd, zd;   % p2
    xa, ya, za;   % p3
    va, ya, za;   % p4
    va, yd, zd;   % p5
    va, yf, zf;   % p6
    va, yc, zc;   % p7
    xa, yc, zc;   % p8
    xa, yf, zf;   % p9
    xa, xe, ze;   % p10 
    xa, yb, zb;   % p11
    va, yb, zb;   % p12
    va, ye, ze;   % p13
   -xa, 0, ht;  % p14
   -xa, 0, 0;     % p15
];

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
