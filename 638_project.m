% Import the necessary toolbox for sensor fusion
import matlab.system.*;



% Read the space-separated data
filename = 'data.csv';  % Replace with your actual filename
data = load(filename);         % Loads the entire file into a matrix
% Assuming the 19th column contains timestamps (in microseconds)
timeStamps = data(:, 19);  % Extract timestamps
timeStamps = timeStamps * 1e-6;  % Convert to seconds (if in microseconds)

% Calculate time differences (dt)
dt = diff(timeStamps);  % dt(i) is the time between step i and i+1

% Define sample rate (Hz)
sampleRate = 1/mean(dt);

% Assuming the data has 9 columns (3 for each sensor), split the columns:
accelData = data(:, 10:12);  % First 3 columns for accelerometer data
gyroData = data(:, 4:6);   % Next 3 columns for gyroscope data
magData = data(:, 1:3);    % Last 3 columns for magnetometer data
euler_real = data(:,7:9);
gravity = data(:, 16:18);

% % Display the first 5 rows
% disp(accelData(1:5, :));  % Show the first 5 rows of accelerometer data
% disp(gyroData(1:5, :));   % Show the first 5 rows of gyroscope data
% disp(magData(1:5, :));    % Show the first 5 rows of magnetometer data

R_accel = cov(accelData);  % Covariance matrix for accelerometer data    % Covariance matrix for gyroscope data
R_mag = cov(magData);      % Covariance matrix for magnetometer data
R_gyro = cov(gyroData);
R_grav = cov(gravity);

display(R_accel);
display(R_mag);
display(R_gyro);
display(R_grav);


% Create AHRS filter object
decim = 1;
gyroNoise = 50;
accelNoise = .1;
magNoise = 10;
fuse = ahrsfilter('SampleRate',sampleRate,'DecimationFactor',decim, 'GyroscopeNoise',gyroNoise, 'AccelerometerNoise', accelNoise, 'MagnetometerNoise', magNoise);
% fuse = ahrsfilter('SampleRate', sampleRate);

q = fuse(accelData,gyroData,magData);
time = (0:decim:size(accelData,1)-1)/sampleRate;

euler_predicted = -eulerd(q,'ZYX','frame');
rmse(euler_real(:,2), euler_predicted(:,2))
plot(time, euler_predicted)

hold on

plot(time,euler_real(:,2))
% plot(time,euler_real(:,1))
% plot(time,euler_real(:,3))


title('Orientation Estimate')
legend('x-axis', 'y-axis', 'z-axis')
ylabel('Rotation (degrees)')



% 
% % Initialize output array for orientation (quaternions)
% orientation = zeros(size(accelData, 1), 4);  % Each quaternion has 4 components
% 
% % Loop through each time step and update the filter
% for i = 1:size(accelData, 1)
%     % Get the current sensor data
%     accel = accelData(i, :);  % Accelerometer data at time step i
%     gyro = gyroData(i, :);    % Gyroscope data at time step i
%     mag = magData(i, :);      % Magnetometer data at time step i
% 
%     % Update the filter with the current data
%     quaternion = filter(accel, gyro, mag);  % Update and return quaternion
% 
%     % Store the quaternion components
%     orientation(i, :) = compact(quaternion);  % Convert to numeric array
% end
% 
% 
% % Convert quaternion to Euler angles (yaw, pitch, roll)
% eulerAngles = quat2eul(orientation);
% 
% % Plot the Euler angles (Yaw, Pitch, Roll)
% figure;
% subplot(3,1,1); plot(eulerAngles(:,1)); title('Yaw'); xlabel('Time Step'); ylabel('Yaw (radians)');
% subplot(3,1,2); plot(eulerAngles(:,2)); title('Pitch'); xlabel('Time Step'); ylabel('Pitch (radians)');
% subplot(3,1,3); plot(eulerAngles(:,3)); title('Roll'); xlabel('Time Step'); ylabel('Roll (radians)');
