close all
clc

% Plots 

figure('Name','err_p')
plot(out.err_p.Time, out.err_p.Data, 'lineWidth', 1.5)
xlabel('t (s)', 'Interpreter', 'latex')
legend('err_p_x','err_p_y','err_p_z','Interpreter', 'latex', 'Location','southeast')
grid("on");

figure('Name','dot_err_p')
plot(out.dot_err_p.Time, out.dot_err_p.Data, 'lineWidth', 1.5)
xlabel('t (s)', 'Interpreter', 'latex')
legend('dot_err_p_x','dot_err_p_y','dot_err_p_z','Interpreter', 'latex', 'Location','southeast')
grid("on");

figure('Name','err_R')
plot(out.err_R.Time, out.err_R.Data, 'lineWidth', 1.5)
xlabel('t (s)', 'Interpreter', 'latex')
legend('err_R_x','err_R_y','err_R_z','Interpreter', 'latex', 'Location','southeast')
grid("on");

figure('Name','err_W')
plot(out.err_W.Time, out.err_W.Data, 'lineWidth', 1.5)
xlabel('t (s)', 'Interpreter', 'latex')
legend('err_W_x','err_W_y','err_W_z','Interpreter', 'latex', 'Location','southeast')
grid("on");

figure('Name','uT')
plot(out.uT.Time, out.uT.Data, 'lineWidth', 1.5)
xlabel('t (s)', 'Interpreter', 'latex')
legend('uT_x','uT_y','uT_z','Interpreter', 'latex', 'Location','southeast')
grid("on");

figure('Name','tau_b')
plot(out.tau_b.Time, out.tau_b.Data, 'lineWidth', 1.5)
xlabel('t (s)', 'Interpreter', 'latex')
legend('tau_b_x','tau_b_y','tau_b_z','Interpreter', 'latex', 'Location','southeast')
grid("on");