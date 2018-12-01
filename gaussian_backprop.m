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
    for i=1:1:rows
        [~, index] = max(augmented_matrix(i:rows, i));
        pivot = i+index-1;
        extra_row = augmented_matrix(i, :);
        augmented_matrix(i, :) = augmented_matrix(pivot, :);
        augmented_matrix(pivot, :) = extra_row;
        for j=i+1:1:rows
            factor = augmented_matrix(j, i) / augmented_matrix(i, i);
            factor_row = factor * augmented_matrix(i, :);
            augmented_matrix(j, :) = augmented_matrix(j, :) - factor_row;
        end
    end
    variable_vals = zeros(rows+1, 1);
    for i=rows:-1:1
        row_v1 = zeros(1, cols+1);
        row_v1(1, 1:cols) = augmented_matrix(i, 1:cols);
        d = dot(row_v1, variable_vals);
        variable_vals(i, 1) = (augmented_matrix(i, cols+1) - d) / augmented_matrix(i, i);
    end
    variable_vals = variable_vals(1:rows, 1);
end

