function variable_vals = gaussian_backprop(mtx, solutions)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    [rows, cols] = size(mtx);
    [rows2, cols2] = size(solutions);
    
    if rows ~= rows2
        % assert equal
    end
    if cols2 ~= 1
        % assert equal
    end
    augmented_matrix = zeros(rows, cols+1);
    augmented_matrix(:, 1:cols) = mtx;
    augmented_matrix(:, cols+1) = solutions;
    augmented_matrix = gaussian(augmented_matrix);
    
    variable_vals = upper_triangular_backprop(augmented_matrix);
end

