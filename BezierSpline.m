function Cpoints = BezierSpline(n_control_points)
    close all;
    % make empty coordinate matrix
    coordinates = zeros(n_control_points,2);
    hold on
    axis([0 100 0 100])
    % request and plot points
    for i=1:n_control_points
        [x, y] = ginput(1);
        coordinates(i,:) = [x, y];
        plot(coordinates(:,1), coordinates(:,2), '+');
    end
    hold off
    
    % find size of coordinate matrix
    [c_rows, ~] = size(coordinates);
    
    % there will be zero added points if there are 4 or de Boor control points
    interp_points_size = 0;
    % if there are more than 4 de Boor points, we know we must add more Bezier control points
    % at various segment midpoints and thirds
    if c_rows > 4
        interp_points_size = 2 * (c_rows - 4);
    end
    % create an empty matrix for the new Bezier points we need to calculate
    interpPoints = zeros(interp_points_size, 2);
    
    % if there are more than 4 de Boor points, we need to add more Bezier
    % control points. This routine calculates the new midpoint and 
    % one-third/two-third Bezier control points
    if c_rows > 4
        interpPoints(1, :) = (coordinates(2, :) + coordinates(3, :)) / 2;
        interpPoints(interp_points_size, :) = (coordinates(c_rows-2, :) + coordinates(c_rows-1, :)) / 2;
        counter = 2;
        for i=3:1:c_rows-3
            interpPoints(counter, :) =  ((2 / 3)*coordinates(i, :)) + ((1 / 3)*coordinates(i+1, :));
            counter = counter + 1;
            interpPoints(counter, :) =  ((1 / 3)*coordinates(i, :)) + ((2 / 3)*coordinates(i+1, :));
            counter = counter + 1;
        end
    end
    
    hold on;
    % scatter plot the de Boor and Bezier control points
    scatter(coordinates(:, 1), coordinates(:,2));
    if length(interpPoints) > 0
        hold on;
        scatter(interpPoints(:, 1), interpPoints(:,2), 'm');
    end
    
    % get size of new Bezier points matrix
    [i_rows, ~] = size(interpPoints);
    final_rows = c_rows;
    if c_rows > 4
        % final matrix of Bezier control points will have this many 
        % rows
        final_rows = c_rows + i_rows;
    end
    
    % create an empty matrix for all final Bezier control points
    points_to_connect = zeros(final_rows, 2);
    
    % create counter for number of Bezier points we've added
    counter = 1;
    % add the first two de Boor control points
    for i=1:1:min(2, c_rows)
        points_to_connect(i, :) = coordinates(i, :);
        counter = counter + 1;
    end
    if c_rows > 4
        % add the new Bezier control points
        interp_counter = 0;
        for i=1:1:i_rows
            points_to_connect(counter, :) = interpPoints(i, :);
            counter = counter + 1;
            interp_counter = interp_counter + 1;
            if mod(interp_counter, 3) == 1
                points_to_connect(counter, :) = (interpPoints(i, :) + interpPoints(i+1, :)) / 2;
                counter = counter + 1;
                interp_counter = interp_counter + 1;
            end
        end
    end
    % add the last two de Boor control points
    for i=max(c_rows-1, 3):1:c_rows
       points_to_connect(counter, :) = coordinates(i, :);
       counter = counter + 1;
    end
    
    % plot splines
    Cpoints = points_to_connect;
    if length(Cpoints) <= 4
        plotUserSpline(Cpoints, 4);
    else
        for i=4:3:length(Cpoints)
            buildBezierCurve(Cpoints(i-3:i,:), 4);
            hold on;
        end
    end
    % color in lines between original control points
    line(coordinates(:,1),coordinates(:,2), 'Color', 'red')
end
