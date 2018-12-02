function variable_vals = lower_triangular_backprop(augmented_matrix)
    [rows, cols] = size(augmented_matrix)
    
    variable_vals = zeros(rows+1, 1);
    
    for i=1:1:rows
        row_v1 = zeros(1, cols+1);
        row_v1(1, 1:cols) = augmented_matrix(i, 1:cols);
        d = dot(row_v1, variable_vals);
        variable_vals(i, 1) = (augmented_matrix(i, cols+1) - d) / augmented_matrix(i, i);
    end
    variable_vals = variable_vals(1:rows, 1);
end    
