clear all; clc; close all;
x = [0, 6, 14, 21, 25, 33, 38, 44];
x = reshape(x, [8, 1]);
y = [0, 20, 24, 16, 12, 13, 18, 5];
y = reshape(y, [8, 1]);

dbp_x = end_condition_solve(x);
dbp_y = end_condition_solve(y);

scatter(x, y)

scatter(dbp_x, dbp_y, 10, [1 0 0])
