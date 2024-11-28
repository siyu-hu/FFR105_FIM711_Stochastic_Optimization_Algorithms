% Fg - Gravitational force along the slope
% Fb - brake force
% Feb - engine brakes force 

function [newVelocity, newBrakeTemperature] = RunTruck(angleDegree, brakePressure, maxTemperature, timeStep, velocity, brakeTemperature, gear)
                                                     
    mass = 20000;                 
    gravity = 9.81;    
    tau = 30; % Cooling constant
    heatCoefficient = 40; % (K/s)
    engineBrakeConstant = 3000; % (N)
    ambientTemperature = 283; %(K)
    gearForce = [7.0, 5.0, 4.0, 3.0, 2.5, 2.0, 1.6, 1.4, 1.2, 1.0]; 
    gearIndex = max(1, min(10, gear));

    Feb = gearForce(gearIndex) * engineBrakeConstant;

    alpha = deg2rad(angleDegree);
    Fg = mass * gravity * sin(alpha); 

    if brakeTemperature < (maxTemperature - 100)
        Fb = (mass * gravity / 20) * brakePressure; 
    else
        Fb = (mass * gravity / 20) * brakePressure * exp(-(brakeTemperature - (maxTemperature - 100)) / 100); 
    end
      
    v_dot = (Fg - Fb - Feb) / mass;  
    newVelocity = velocity + v_dot * timeStep;

    deltaBrakeTemperature = brakeTemperature - ambientTemperature;

    if brakePressure < 0.01
        dDeltaBrakeTemperature = - deltaBrakeTemperature / tau;
    else
        dDeltaBrakeTemperature = heatCoefficient * brakePressure;
    end
    
    newDeltaBrakeTemperature =  deltaBrakeTemperature + dDeltaBrakeTemperature * timeStep;
    newBrakeTemperature = ambientTemperature + newDeltaBrakeTemperature;
    
end
