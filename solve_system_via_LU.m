% Solves system Ax = b via LU factorization
function variable_vals = solve_system_via_LU(mtx, solns)
    % Ax = b
    % LUx = b. 
    % (1) First solve Lw = b for w
    % (2) Then solve Ux = w for x

    [L, U] = LU_factorize(mtx);
    % Solve Lw=b for w
    w = lower_triangular_backprop([L, solns]);
    
    % Solve Ux = w
    variable_vals = upper_triangular_backprop([U, w]);
end