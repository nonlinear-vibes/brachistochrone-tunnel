function plotBrachistochroneDisk(R, g, dThetaStep)
% plotBrachistochroneDisk  Brachistochrone arcs inside a disk.
% Draws multiple arcs with endpoint separations Δθ = k*dThetaStep (k=1..).
%
% Inputs
%   R          - disk radius (meters)
%   g          - gravitational acceleration (m/s^2)
%   dThetaStep - step in endpoint separation (radians), e.g. pi/6
%
% Example:
%   plotBrachistochroneDisk(1, 9.81, pi/6)

% List of theta values
dThetaList = dThetaStep:dThetaStep:(pi);
if dThetaList(end) == pi; dThetaList(end) = pi-eps; end
K = numel(dThetaList);

% Colors
c1 = [0.12 0.35 0.90];
    c2 = [0.35 0.85 1.00];
    colors = [linspace(c1(1), c2(1), K)', ...
              linspace(c1(2), c2(2), K)', ...
              linspace(c1(3), c2(3), K)'];

% Discretization
N    = 400;
epsR = 1e-9*R;    % trim to avoid endpoint singularities

figure('Name','Brachistochrone arcs'); hold on; grid on;

% Draw boundary circle
phi = linspace(0, 2*pi, 600);
plot(R*cos(phi), R*sin(phi), 'Color', [0 0 0], 'LineWidth', 1.0, 'HandleVisibility','off');

% Loop through theta
for k = 1:numel(dThetaList)
    dth = dThetaList(k);           % endpoint angular separation
    r0  = R*(1 - dth/pi);          % turning radius (from Δθ = π(1 - r0/R))

    % radial sweep from surface to turning point
    r = linspace(R - epsR, r0 + epsR, N);

    % theta(r): use u = sqrt((r^2 - r0^2)/(R^2 - r^2))
    u     = sqrt( max(r.^2 - r0^2, 0) ./ max(R^2 - r.^2, realmin) );
    theta = atan( (R/r0)*u ) - (r0/R)*atan(u);

    % Place start at top (angle = pi/2)
    rot = (pi/2 - theta(1));
    th1 =  theta + rot;    % right-hand branch
    th2 = -theta + rot;    % left-hand branch (mirror)

    % Cartesian coords for both branches
    x1 = r .* cos(th1); y1 = r .* sin(th1);
    x2 = r .* cos(th2); y2 = r .* sin(th2);

    % Travel time: T = pi * sqrt( (R^2 - r0^2)/(g R) )
    Tsec = pi * sqrt( (R^2 - r0^2) / (g * R) );
    Skm  = (R * dth) / 1000;      % surface distance in km

    col = colors(k,:);

    % Plot both halves with the same color; only first half participates in legend
    plot(x1, y1, 'LineWidth', 1.8, 'Color', col, ...
        'DisplayName', sprintf('s=%.0f km, T=%.1f min', Skm, Tsec/60));
    plot(x2, y2, 'LineWidth', 1.8, 'Color', col, 'HandleVisibility','off');
    
end

axis equal; axis padded;
xlabel('x'); ylabel('y');
title(sprintf('Brachistochrone arcs', R));
legend('Location','northwest');

end