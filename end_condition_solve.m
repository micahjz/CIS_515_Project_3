function de_boor_points = end_condition_solve(x)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    tic
    [rows, ~] = size(x);
    rows = rows-2;
    
    A = zeros(rows, rows);
    for i=1:1:rows
        A(i, i) = 4;
        if i < rows
            A(i+1, i) = 1;
            A(i, i+1) = 1;
        end
    end
    
    solutions = 6*x(2:rows+1, 1);
    solutions(1, 1) = solutions(1, 1) - x(1, 1);
    solutions(rows, 1) = solutions(rows, 1) - x(rows+2, 1);
   
    dbp = gaussian_backprop(A, solutions);
    de_boor_points = zeros(rows+4, 1);
    de_boor_points(3:rows+2, 1) = dbp;
    de_boor_points(2, 1) = (2.0/3.0)*x(1, 1) + (1.0 / 3.0)*dbp(1, 1);
    de_boor_points(rows+3, 1) = (1.0/3.0)*dbp(rows, 1) + (2.0 / 3.0)*x(rows+2, 1);
    de_boor_points(1, 1) = x(1, 1);
    de_boor_points(rows+4, 1) = x(rows+2, 1);
    toc
end

