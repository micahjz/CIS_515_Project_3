function new_matrix = getDiagonalControlPoints(control_points)
    % get dimension of set of control points
    [rows, cols] = size(control_points);
    % build empty matrix for final control points,
    % which will have two sets
    new_matrix = zeros(rows, cols, 2);
    % we will use a 3D matrix to carry out the 
    % triangular process of de Casteljau's algorithm
    triangle_matrix = zeros(rows, cols, rows);
    triangle_matrix(:, :, 1) = control_points;
    for i=2:1:rows
        for j=1:1:rows-1
            triangle_matrix(j, :, i) = (triangle_matrix(j, :, i-1) + triangle_matrix(j+1, :, i-1)) / 2;
        end
    end
    % find the upper and lower diagonals from the 
    % de Casteljau's process and load them into the 
    % final matrix to be returned
    for i=1:1:rows
        new_matrix(i, :, 1) = triangle_matrix(1, :, i);
        new_matrix(rows + 1 - i, :, 2) = triangle_matrix(rows + 1 - i, :, i);
    end
