clear all; clc; close all;
x = [0, 6, 14, 21, 25, 33, 38, 44];
x = reshape(x, [8, 1]);
y = [0, 20, 24, 16, 12, 13, 18, 5];
y = reshape(y, [8, 1]);

% Formulate data points for interpolation problem
data_pts = formulate_interpolation_problems();
solutions = cell(2,4);
% first row = solns from elimination
% second row = solns from LU
% columns = [general 1 | general 2 | quadratic 1| quadratic 2]

% Solve each interpolation problem with different end conditions
for i = 1:2
    disp(strcat("Trial ", num2str(i)));
    x = data_pts{i}(:,1);
    y = data_pts{i}(:,2);
    
    disp("x=")
    disp(x)
    disp("y=")
    disp(y)
    
    % General end conditions, with elimination
    disp("Computing de Boor points with elimination: general end conditions")
    tic
    dbp_x = end_condition_solve(x);
    dbp_y = end_condition_solve(y);
    toc
    
    solutions{1,i} = [dbp_x, dbp_y];
    
    %scatter(x, y)
    %scatter(dbp_x, dbp_y, 10, [1 0 0])
    
    % General end conditions, with LU
    disp("Computing de Boor points with LU: general end conditions")
    tic
    dbp_x = end_condition_solve_with_LU(x);
    dbp_y = end_condition_solve_with_LU(y);
    toc
    
    solutions{2,i} = [dbp_x, dbp_y];
    disp("[Solutions_With_Elim, Solutions_With_LU]")
    disp([solutions{1,i}, solutions{2,i}])
end

% Quadratic end conditions
for i = 1:2
    disp(strcat("Trial ", num2str(i)));
    x = data_pts{i}(:,1);
    y = data_pts{i}(:,2);
    
    % General end conditions, with elimination
    disp("Computing de Boor points with elimination: quadratic conditions")
    tic
    dbp_x = end_condition_solve(x);
    dbp_y = end_condition_solve(y);
    toc
    
    solutions{1,i+2} = [dbp_x, dbp_y];
    
    %scatter(x, y)
    %scatter(dbp_x, dbp_y, 10, [1 0 0])
    
    % General end conditions, with LU
    disp("Computing de Boor points with LU: quadratic conditions")
    tic
    dbp_x = end_condition_solve_with_LU(x);
    dbp_y = end_condition_solve_with_LU(y);
    toc
    
    solutions{2,i+2} = [dbp_x, dbp_y];
    
    disp("[Solutions_With_Elim, Solutions_With_LU]")
    disp([solutions{1,i+2}, solutions{2,i+2}])
end

% Now plot bezier curves
for i = 1:4
    
    % this algorithm runs with default 3 control points
    control_points = size(solutions{1,i},1);

    % empty matrix for coordinates
    coordinates = solutions{1,i};
    %axis([0 100 0 100])
    % ask for user input and plot points
    %h
    %for i=1:control_points
    %    [x, y] = ginput(1);
    %    coordinates(i,:) = [x, y];
    %    plot(coordinates(:,1), coordinates(:,2), '+');
    %end
    %hold off
    plot(coordinates(:,1), coordinates(:,2));

    figure;
    plotn = 1;
    % for 1 through 6 subdivisions, plot the Bezier curves
    for j=1:1:6
        subplot(3,2,plotn)
        plotn = plotn + 1;
        plot(coordinates(:,1), coordinates(:,2), '+');
        buildBezierCurve(coordinates, j);
        title(strcat(num2str(j),' subdivisions'));
    end
end



