function vec_output = lie_bracket(vec1, vec2, variables)
% Compute lie bracket of two vec 
vec_output = jacobian(vec2, variables)*vec1-jacobian(vec1, variables)*vec2;

end