function q_near_index = get_closest_index(q_i, NODES)   
%%% Return the index of the closest node from q_i in NODES
    for i = 1:size(NODES, 1)
        distances(i) = norm(q_i-NODES(i,:));
    end
    [~, q_near_index] = min(distances);
end