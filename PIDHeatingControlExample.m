% PIDHeatingControlExample.m
% PID-based House Heating Control Implementation

% PID Controller Parameters
Kp = 1.0; % Proportional gain
Ki = 0.1; % Integral gain
Kd = 0.05; % Derivative gain

% Desired temperature
setpoint = 22; % Desired temperature in Celsius
current_temp = 20; % Current temperature in Celsius

% Initialize variables
integral = 0;
previous_error = 0;

% Simulation loop
for t = 1:100
    % Calculate error
    error = setpoint - current_temp;
    
    % PID calculations
    integral = integral + error;
    derivative = error - previous_error;
    output = Kp * error + Ki * integral + Kd * derivative;
    
    % Update the current temperature based on the PID output
    current_temp = current_temp + output * 0.1; % Simplified model
    
    % Store performance metrics
    performance(t) = output; % Store the control output for analysis
    
    % Update previous error
    previous_error = error;
    
    % Reward calculation
    reward(t) = -abs(error); % Reward based on how close we are to the setpoint
end

% Validation function
function isValid = validateTemperature(temperature)
    % Check if temperature is within acceptable range
    isValid = (temperature >= 15) && (temperature <= 30);
end

% Performance metrics
average_performance = mean(performance);
max_performance = max(performance);

disp(['Average Performance: ', num2str(average_performance)]);
disp(['Maximum Performance: ', num2str(max_performance)]);