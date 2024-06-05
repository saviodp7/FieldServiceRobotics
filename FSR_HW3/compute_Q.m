function Q = compute_Q(RPY_angles)

    Q = [1 0                   -sin(RPY_angles(2));
         0 cos(RPY_angles(1))  cos(RPY_angles(2))*sin(RPY_angles(1))
         0 -sin(RPY_angles(1)) cos(RPY_angles(1))*cos(RPY_angles(2))];
    
end