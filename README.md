# Kalman-Filter
This project implements an Attitude and Heading Reference System (AHRS) filter using a Kalman filter for real-time orientation estimation. The system fuses data from an accelerometer, gyroscope, and magnetometer to provide accurate roll, pitch, and yaw estimates. The implementation is done in MATLAB and evaluates the estimated orientation against ground truth data.

## Features

Sensor fusion using a Kalman filter
Compensation for gyroscope drift, linear acceleration, and magnetic disturbances
Implementation of quaternion-based orientation tracking
Visualization of estimated orientation over time
RMSE-based evaluation against ground truth

## Files in Repository

638.m: MATLAB script implementing the AHRS filter and also containing functions for visualizing results and comparing estimated values with actual.
README.md: Project documentation.

## Requirements

MATLAB (with Sensor Fusion and Tracking Toolbox recommended)
Dataset containing accelerometer, gyroscope, and magnetometer readings

## Usage

Load your dataset containing accelerometer, gyroscope, and magnetometer readings.
Run 638.m to estimate orientation.

## Results

The filter effectively mitigates gyroscope drift.
Magnetic disturbances introduce minor errors, which could be further refined.
RMSE analysis indicates the accuracy of the orientation estimation.

## License

This project is licensed under the MIT License. See LICENSE for details.

## References

Kalman Filtering for Sensor Fusion
Quaternion Mathematics for Orientation Tracking
