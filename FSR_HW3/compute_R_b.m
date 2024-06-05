function R_b = compute_R_b(eta_b)

    R_b = [cos(eta_b(2))*cos(eta_b(3)) sin(eta_b(1))*sin(eta_b(2))*cos(eta_b(3))-cos(eta_b(1))*sin(eta_b(3)) cos(eta_b(1))*sin(eta_b(2))*cos(eta_b(3))+sin(eta_b(1))*sin(eta_b(3));
          cos(eta_b(2))*sin(eta_b(3))  sin(eta_b(1))*sin(eta_b(2))*sin(eta_b(3))+cos(eta_b(1))*cos(eta_b(3)) cos(eta_b(1))*sin(eta_b(2))*sin(eta_b(3))-sin(eta_b(1))*cos(eta_b(3));
          -sin(eta_b(2))               sin(eta_b(1))*cos(eta_b(2))                                           cos(eta_b(1))*cos(eta_b(2))];

end