
function RunTest()
    clear all;
    clc;

    data = load("bestChromosome.mat");
    bestChromosome = data.bestChromosome;
    unoverfitBestChromosome = bestChromosome(80, :); % Update by hand

    fileID = fopen('BestChromosome.m', 'w');
    fprintf(fileID, 'function bestChromosome = BestChromosome()\n');
    fprintf(fileID, 'bestChromosome = [\n');
    fprintf(fileID, '  %.20f,\n', unoverfitBestChromosome(1:end-1));
    fprintf(fileID, '  %.20f\n', unoverfitBestChromosome(end)); 
    fprintf(fileID, '];\n');
    fprintf(fileID, 'end \n');
    fclose(fileID);


    % FFNN parameters
    numOfInput = 3;                
    numOfHidden = 7;              
    numOfOutput = 2;                  
    weightMax = 5;                     
    activationConstant = 2;      

    % Evaluate parameters
    timeStep = 0.1;
    maxTemperature = 750;                          
    maxVelocity = 25;             
    minVelocity = 1;             
    maxAngle = 10; 
    maxDistance = 1000;
    brakeTemperature = 500; 
    gear = 7; 
    velocity = 20; 
    distance = 0; 
    lastGearChangeTime = 0; 
    t = 0;
   

    % Plot variables 
    angleHistory = [];
    brakePressureHistory = [];
    gearHistory = [];
    velocityHistory = [];
    temperatureHistory = [];
    distanceHistory = [];
    time = [];

    % Test set
    slopeIndex = 3; % Update by hand
    datasetIndex = 3;
    
    
    [weightsInputHidden, weightsHiddenOutput] = DecodeChromosome(unoverfitBestChromosome, numOfInput, numOfHidden, numOfOutput, weightMax);
   
    while distance <= maxDistance
        time = [time,t];
        velocityHistory = [velocityHistory, velocity];
    
        angleDegree = GetSlopeAngle(distance, slopeIndex, datasetIndex, maxAngle);
        angle = deg2rad(angleDegree);
        radMaxAngle = deg2rad(maxAngle);
        
        angleHistory = [angleHistory, angleDegree];
        
        input = [ angle / radMaxAngle; velocity / maxVelocity; brakeTemperature / maxTemperature];
        [brakePressure, deltaGear] = Feedforward(input, weightsInputHidden, weightsHiddenOutput, activationConstant);
        
        brakePressureHistory = [brakePressureHistory, brakePressure];
        
        if deltaGear <= 1/3
            deltaGear = -1;
        elseif deltaGear >= 2/3
            deltaGear = 1;
        else
            deltaGear = 0;
        end
    
        if t - lastGearChangeTime >= 2
            gear = max(1, min(10, gear + deltaGear));
            lastGearChangeTime = t;
        end
    
        gearHistory = [gearHistory, gear];
    
        distance = distance + velocity * cos(angle) * timeStep;
        distanceHistory = [distanceHistory, distance]; 
    
        [newVelocity, newBrakeTemperature] = RunTruck(angleDegree, brakePressure, maxTemperature, timeStep, velocity, brakeTemperature, gear);
    
        temperatureHistory = [temperatureHistory, newBrakeTemperature];
        
        if newBrakeTemperature > maxTemperature
            disp('End: brake temperature exceeded max value.');
            break;
        end
    
        if newVelocity > maxVelocity
            disp('End: Velocity exceeded max value.');
            break;
        elseif newVelocity < minVelocity
            disp('End: Velocity fell below min value.');
            break;
        end
    
        if newVelocity == 0
            disp('End: velocity =0, truck stoped.');
            break;
        end
    
        
        velocity = newVelocity;
        brakeTemperature = newBrakeTemperature;
        t = t + timeStep;    
    end
    figure;
    
    subplot(5, 1, 1);
    plot(distanceHistory, angleHistory,'-r');
    ylabel('Slope angle (degrees)');
    title('Slope Angle vs Distance');
    grid on;
    
    subplot(5, 1, 2);
    plot(distanceHistory, brakePressureHistory);
    ylabel('Brake Pressure');
    title('Brake Pressure vs Distance');
    grid on;
    
    subplot(5, 1, 3);
    plot(distanceHistory, gearHistory, '-r');
    ylabel('Gear');
    title('Gear vs Distance');
    grid on;
    
    subplot(5, 1, 4);
    plot(distanceHistory, velocityHistory);
    ylabel('Velocity (m/s)');
    title('Velocity vs Distance');
    grid on;
    
    subplot(5, 1, 5);
    plot(distanceHistory, temperatureHistory,'-r');
    ylabel('Brake Temperature (K)');
    xlabel('Distance (m)');
    title('Brake Temperature vs Distance');
    grid on;
    
end
