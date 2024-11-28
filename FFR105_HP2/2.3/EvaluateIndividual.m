function Fitness = EvaluateIndividual(weightsInputHidden, weightsHiddenOutput, dataSetIndex, activationConstant)

    timeStep = 0.1;
    maxTemperature = 750;                          
    maxVelocity = 25;             
    minVelocity = 1;             
    maxAngle = 10;       

    if dataSetIndex == 1
        numOfSlopes = 10;
    elseif dataSetIndex == 2
        numOfSlopes = 5;
    elseif dataSetIndex == 3
        numOfSlopes = 5;
    end

    FitnessArray = zeros(numOfSlopes, 2);

    for slopeIndex = 1: numOfSlopes
        
        brakeTemperature = 500; %  (K)
        gear = 7; 
        velocity = 20; 
        distance = 0; 
        lastGearChangeTime = 0; 
        velocityHistory = []; 
        t = 0;

        while distance <= 1000
            angleDegree = GetSlopeAngle(distance, slopeIndex, dataSetIndex, maxAngle);
            angle = deg2rad(angleDegree);
            radMaxAngle = deg2rad(maxAngle);

            input = [angle / radMaxAngle; velocity / maxVelocity; brakeTemperature / maxTemperature];
            [brakePressure, deltaGear] = Feedforward(input, weightsInputHidden, weightsHiddenOutput, activationConstant);
            
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
            else
                deltaGear = 0; 
            end
            
            distance = distance + velocity * cos(angle) * timeStep; 

            [newVelocity, newBrakeTemperature] = RunTruck(angleDegree, ...
                      brakePressure, maxTemperature, timeStep, velocity, brakeTemperature, gear);
            
            if newBrakeTemperature > maxTemperature
                %disp('brake temperature violates max temperature.');
                break;
            end

            if newVelocity > maxVelocity
               % disp('End: Velocity exceeded max allowed value.');
                break;
            elseif newVelocity < minVelocity
               % disp('End: Velocity fell below min allowed value.');
                break;
            end
    
            if newVelocity == 0
                disp('The truck stops.');
                break;
            end

            velocityHistory = [velocityHistory, newVelocity];
            velocity = newVelocity;
            brakeTemperature = newBrakeTemperature;
            t = t + timeStep;
        end

        meanVelocity = mean(velocityHistory);
        fitness = meanVelocity * distance; 
        FitnessArray(slopeIndex, :) = [slopeIndex, fitness]; 
    end

    Fitness = mean(FitnessArray(:, 2));

end
