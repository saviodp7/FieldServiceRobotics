function M = compute_M(eta_b, I_b)

    Q = compute_Q(eta_b);
    M = Q'*I_b*Q;
    
end