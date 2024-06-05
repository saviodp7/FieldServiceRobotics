function Q_dot = compute_Q_dot(eta_b, eta_dot_b)

    Q_dot=[0 0                           -cos(eta_b(2))*eta_dot_b(2);
           0 -sin(eta_b(1))*eta_dot_b(1) -sin(eta_b(2))*sin(eta_b(1))*eta_dot_b(2)+cos(eta_b(2))*cos(eta_b(1))*eta_dot_b(1);
           0 -cos(eta_b(1))*eta_dot_b(1) -sin(eta_b(2))*cos(eta_b(1))*eta_dot_b(2)-cos(eta_b(2))*sin(eta_b(1))*eta_dot_b(1)];

end