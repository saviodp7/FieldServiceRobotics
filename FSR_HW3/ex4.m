close all
clear
clc

%% Parameters

load("ws_homework_3_2024.mat");
m = 1.5;
g = 9.81;
I_b = diag([1.2416 1.2416 2*1.2416]);
T_s = 0.001; %s
t = attitude.time ;

c_0 = 25; 
k_0 = c_0;
r = 1;  

%% ESTIMATOR

% Transfer function
s = tf('s');
G = (k_0/(s+c_0))^r;
a = cell2mat(G.Denominator); % [a_0 a_1 a_2 ... a_{r-1} a_r]

% K computation
K = zeros(r,1);
Product = 1; 
for i = 1:r
    K(i) = a(i+1)/Product;
    Product = Product*K(i);
end
K=flip(K);

%% Estimator variables 
external_wrench = zeros(6, length(t));
gamma = zeros(6, length(t), r); 
e_3 = [0 0 1]';
p_dot_b = linear_vel.signals.values;
eta_b = attitude.signals.values;
eta_dot_b = attitude_vel.signals.values;
thrust = thrust.signals.values;
tau = tau.signals.values;

for k = 1:length(t)-1

    C = compute_C(eta_b(k,:), eta_dot_b(k,:), I_b);
    Q = compute_Q(eta_b(k,:));
    R_b = compute_R_b(eta_b(k,:));
    M = compute_M(eta_b(k,:), I_b);
    
    q(:,k+1) = [m*eye(3) zeros(3,3); zeros(3,3) M]*[p_dot_b(k+1,:) eta_dot_b(k+1,:)]';
    
    for i = 1:r
        if i == 1
            gamma(:,k+1,1) = gamma(:,k,1) + K(1)*( (q(:,k+1) - q(:,k)) - T_s*(external_wrench(:,k) + [m*g*e_3-thrust(k)*R_b*e_3; C'*eta_dot_b(k,:)' + Q'*tau(k,:)']));
        else
            gamma(:,k+1,i) = gamma(:,k,i) + K(i)*T_s*(-external_wrench(:,k) + gamma(:,k,i-1));
        end
    end
    external_wrench(:,k+1) = gamma(:,k+1,r);
end


%% Plots 

figure()
subplot(3,2,1)
hold on
plot(t, external_wrench(1,:), 'lineWidth', 1.5)
plot(t, 0.5.*ones(length(t),1), 'LineStyle', '--')
hold off
xlabel('t (s)', 'Interpreter', 'latex')
ylabel('$\hat{f_x}$ (N)', 'Interpreter', 'latex')
legend('$\hat{f_x}$','x-axis disturbance','Interpreter', 'latex', 'Location','southeast')
grid("on");


subplot(3,2,2)
plot(t, external_wrench(4,:), 'lineWidth', 1.5)
xlabel('t (s)', 'Interpreter', 'latex')
ylabel('$\hat{\tau_x}$ (Nm)', 'Interpreter', 'latex')
grid("on");

subplot(3,2,3)
hold on
plot(t, external_wrench(2,:), 'lineWidth', 1.5)
plot(t, 0.5.*ones(length(t),1), 'LineStyle', '--')
hold off
xlabel('t (s)', 'Interpreter', 'latex')
ylabel('$\hat{f_y}$ (N)', 'Interpreter', 'latex')
legend('$\hat{f_y}$','y-axis disturbance','Interpreter', 'latex', 'Location','southeast')
grid("on");

subplot(3,2,4)
plot(t, external_wrench(5,:), 'lineWidth', 1.5)
xlabel('t (s)', 'Interpreter', 'latex')
ylabel('$\hat{\tau_y}$ (Nm)', 'Interpreter', 'latex')
grid("on");

subplot(3,2,5)
plot(t, external_wrench(3,:), 'lineWidth', 1.5)
xlabel('t (s)', 'Interpreter', 'latex')
ylabel('$\hat{f_z}$ (N)', 'Interpreter', 'latex')
grid("on");
 
subplot(3,2,6)
hold on
plot(t, external_wrench(6,:), 'lineWidth', 1.5)
plot(t,0.2.*ones(length(t),1), 'LineStyle', '--')
hold off
xlabel('t (s)', 'Interpreter', 'latex')
ylabel('$\hat{\tau_z}$ (Nm)', 'Interpreter', 'latex')
legend('$\hat{\tau_z}$','yaw-axis disturbance','Interpreter', 'latex', 'Location','southeast')
grid("on");

%% Real mass of the UAV
real_mass = external_wrench(3,end)/g + m