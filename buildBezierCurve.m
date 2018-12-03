function P = buildBezierCurve(coordinates, subsections)
    
    % this map contains a mapping from
    % subdivision # ---> 3D matrix of control point sets
    control_points_map = containers.Map(0, coordinates);
   
    % iterate through desired subdivisions
    for i=1:1:subsections
        % grab matrix from last subdivision
        last_matrix = control_points_map(i-1);
        % find the size of the matrix
        [rows, cols, divisions] = size(last_matrix);
        % create a new matrix, which will have twice as many sets of 
        % control points
        new_matrix = zeros(rows, cols, divisions*2);
        % for each set of control points, 
        % we want to 'double' it using de Casteljau's algorithm
        for j=1:1:divisions
            control_points = last_matrix(:,:,j);
            % double the set using the getDiagonalControlPoints subroutine
            doubled_control_points = getDiagonalControlPoints(control_points);
            % build the new matrix for this subdivision
            new_matrix(:, :, (2*j)-1:2*j) = doubled_control_points;
        end
        % add new matrix to the map
        control_points_map(i) = new_matrix;
    end
    
    % access the deepest subdivision
    all_points = control_points_map(subsections);
    % get dimensions
    [rows, ~, divisions] = size(all_points);
    
    % we now want to build a 2D matrix from these sets of 
    % Bezier control points
    all_points_final = zeros(rows*divisions, 2);
    for i=1:1:divisions
        all_points(:, :, i);
        all_points_final(rows*(i-1)+1:rows*i, :) = all_points(:, :, i);
    end
    
    P=all_points_final;
    % draw lines between points
    line(P(:,1),P(:,2))
    line(coordinates(:,1),coordinates(:,2), 'Color', 'magenta') %draw lines between the de Boor Control Points
end
