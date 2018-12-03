function reduced_row_matrix = gaussian(augmented_matrix)
    [rows, cols] = size(augmented_matrix);
    
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
    
    reduced_row_matrix = augmented_matrix;
end
