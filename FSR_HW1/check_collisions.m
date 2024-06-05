function collision = check_collisions(grid, q_i, q_f, delta)
%%% Return 0 if there are not collisions with an obstacle bewtween q_i and
%   q_f, otherwise, 1 is returned
collision = 0;
    path = [linspace(q_i(1), q_f(1), delta)' linspace(q_i(2), q_f(2), delta)'];
    for i = 1:size(path,1)
        cell = round(path(i,:));
        if grid(cell(1), cell(2)) == 0
                collision = 1;
        end
    end
end