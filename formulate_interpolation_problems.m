% Formulate interpolation problems
% Returns a 1x2 cell of data points for 2 problems
function data_points = formulate_interpolation_problems

    % we will do one N = 5 case and one N=8 case
    n1 = 5;
    n2 = 8;

    % Formulate control points
    % we will arbitrarily choose these to be (x, y) to be incremented by 2 then
    % decremented by 1
    data_points = {zeros(n1, 2), zeros(n2, 2)};
    data_points{1}(:,1) = [0;1;2;3;4];
    data_points{1}(:,2) = [0;1;1;1;0];

    % we will arbitrarily choose our other one to be decremented by 1 then
    % incremented by 3
    data_points{2}(:,1) = [0; 1.5; 3; 3.5; 4; 5.5; 7; 8.5];
    data_points{2}(:,2) = [0; 1;   3; 3.5; 3;   1; 0; 2];
    

end


