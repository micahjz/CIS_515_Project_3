% Function for LU Factorization of Tridiagonal Matrices

%Ex: A = [[1,1,0,0,0];[1,2,3,0,0];[0,1,2,3,0]; [0,0,1,2,3]; [0,0,0,1,2]];
function [L,U] = LU_factorize(A)
    % for row i: a_i = A(i, i-1), b_i = A(i, i), c_i = A(i, i+1)
    n = size(A, 1);
    a = NaN(1, n);
    b = NaN(1, n);
    c = NaN(1, n);

    % Read values into a, b, and c
    for i = 1:n
        if i == 1
            b(i) = A(i, i);
            c(i) = A(i, i+1);
        elseif i == n
            a(i) = A(i, i-1);
            b(i) = A(i, i);
        else
            a(i) = A(i, i-1);
            b(i) = A(i, i);
            c(i) = A(i, i+1);
        end
    end

    % Solve for values of z
    z = NaN(1,n);
    z(1) = c(1)/b(1);
    for k = 2:(n-1)
        z(k) = c(k) / (b(k) - a(k)*z(k-1));
    end
    z(n) = b(n) - a(n)*z(n-1);

    % Facotrize into LU
    L = zeros(size(A));
    U = zeros(size(A));

    for i = 1:n
        if i == 1
            L(i,i) = c(i)/z(i);
            U(i,i) = 1;
            U(i,i+1) = z(i);
        elseif i == n
            L(i,i) = z(n);
            L(i, i-1) = a(n);
            U(i,i) = 1;
        else
            L(i,i) = c(i)/z(i);
            L(i, i-1) = a(i);
            U(i,i) = 1;
            U(i, i+1) = z(i);
        end
    end
end          