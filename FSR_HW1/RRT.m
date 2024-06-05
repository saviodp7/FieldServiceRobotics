load("image_map.mat");
imshow(image_map)
hold on

rows_number = size(image_map, 1);
cols_number = size(image_map, 2);

q_s = [30, 125];
q_f = [135 400];
scatter(q_s(2), q_s(1), 7, "red", "filled")
scatter(q_f(2), q_f(1), 5, "red", "filled")

N_ITERATIONS = 50;
MAX_N_TRIES = 10;
n_tries = 0;

delta = 10;
NODES = q_s;
solved = 0;

while ~solved && n_tries < MAX_N_TRIES
    % Try to generate N_ITERATIONS nodes 
    for i = 1:N_ITERATIONS
    
        q_rand = [randi(rows_number), randi(cols_number)];
        
        q_near_index = get_closest_index(q_rand, NODES);
        q_near = NODES(q_near_index,:);
    
        direction = q_rand-NODES(q_near_index,:);
        normalized_direction = direction/norm(direction)*delta;
        q_new = q_near + round(normalized_direction);
        
        % If q_new is feasible and there are no collisions draw a blue line
        if q_new(1) > 0 && q_new(2) >0 && q_new(1) < rows_number && q_new(2) < cols_number
            if ~check_collisions(image_map, q_near, q_new, delta)
                NODES(end+1,:) = q_new;
                scatter(q_new(2), q_new(1), 10, "green", "filled")
                line([q_near(2),q_new(2)], [q_near(1), q_new(1)], "linestyle", "-", "color", "blue")
            end
        end
    end
    
    % check if there is a node that can be connected to q_f
    % and report the failure or success of the algorithm
    NEW_NODES = NODES;
    while size(NEW_NODES, 1) && ~solved
    
        q_best_index = get_closest_index(q_f, NEW_NODES);
        q_best = NEW_NODES(q_best_index,:);
    
        if ~check_collisions(image_map, q_best, q_f, 10*delta)
            line([q_best(2),q_f(2)], [q_best(1), q_f(1)], "linestyle", "-", "color", "green")
            solved = 1;
        else
            NEW_NODES(q_best_index,:) = [];
        end
    end
    n_tries = n_tries+1;
    if solved
        sprintf("Solution found")
    else
        sprintf("Try #%d: No solution found!", n_tries)
    end
end
