function spline = smoothPlot(n_control_points)
    figure;
    coordinates = zeros(n_control_points,2);
    hold on
    axis([0 100 0 100])
    for i=1:n_control_points
        [x, y] = ginput(1);
        coordinates(i,:) = [x, y];
        plot(coordinates(:,1), coordinates(:,2), '+');
    end
    hold off
    
    interpLines = cell(n_control_points-1, 1) ; 
    
    for i=2:1:n_control_points
        x1 = min(coordinates(i-1, 1), coordinates(i, 1)):0.02:max(coordinates(i-1, 1), coordinates(i, 1));
        lineCoords = zeros(length(x1), 2);
        lineCoords(:, 1) = x1;
        lineCoords(:, 2) = interp1(coordinates(i-1:i, 1), coordinates(i-1:i, 2), x1);
        plot(lineCoords(:, 1), lineCoords(:, 2))
        hold on;
        interpLines{i-1} = lineCoords;
    end
    
    spline = [];
    
    for t=0:0.02:1
        Cpoints = [];
        for i=1:1:length(interpLines)
            line = cell2mat(interpLines(i));
            Cpoints = [Cpoints; line(int64(round(max([length(line)*t, 1]))), :)];
        end
        Cpoints=[Cpoints; coordinates(length(coordinates), :)];
        
%         hold on;
%         scatter(coordinates(:, 1), coordinates(:,2));
%         hold on;
%         scatter(Cpoints(:, 1), Cpoints(:,2), '+');

        cInterp = {};
        cIndex = 1;
        for i=2:1:length(Cpoints)
            x1 = min(Cpoints(i-1, 1), Cpoints(i, 1)):0.02:max(Cpoints(i-1, 1), Cpoints(i, 1));
            lineCoords = zeros(length(x1), 2);
            lineCoords(:, 1) = x1;
            lineCoords(:, 2) = interp1(Cpoints(i-1:i, 1), Cpoints(i-1:i, 2), x1);
            plot(lineCoords(:, 1), lineCoords(:, 2))
            hold on;
            cInterp{cIndex} = lineCoords;
            cIndex = cIndex + 1;
        end
        
        for i=1:1:length(cInterp)
            line = cell2mat(cInterp(i));
            row = min([length(line), int64(round(max([length(line)*t, 1])))]);
            spline = [spline; line(row, :)];
        end        
      
    end
    
    plot(spline(:, 1), spline(:,2));
    
        
    