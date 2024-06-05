syms x  y theta alpha beta gamma;
syms l r;
variables = [x  y theta alpha beta gamma];

A_T = [sqrt(3)/2*cos(theta)-1/2*sin(theta)  1/2*cos(theta)+sqrt(3)/2*sin(theta) l r 0 0
       sin(theta)                           -cos(theta)                         l 0 r 0
       -sqrt(3)/2*cos(theta)-1/2*sin(theta) 1/2*cos(theta)-sqrt(3)/2*sin(theta) l 0 0 r];

G = [ null(A_T)];
F = G;
new_added = true;

while new_added
    new_added = false;
    for i = 1:size(F,2)
        for j = i+1:size(F,2)
            vec = lie_bracket(F(:,i), F(:,j), variables);
            if rank([F vec]) > rank(F)
                F = [F vec];
                new_added = true;
            end
        end
    end
end

rank(F)