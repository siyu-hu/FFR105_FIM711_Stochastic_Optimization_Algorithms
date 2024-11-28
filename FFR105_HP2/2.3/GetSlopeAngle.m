% Truck Model
% 1. x denotes the horizontal distance travelled (by the truck) on a given slope, and
% 2. alpha measures the slope angle at distance x
% 3. slopeIndex denotes the slope index (i.e. 1,2,..10 for the
% training set etc.)
% 4. datasetIndex determines whether the slope under consideration
% belongs to the training set (datasetIndex = 1), validation
% set (datasetIndex = 2) or the test set (datasetIndex = 3).

function angle = GetSlopeAngle(x, slopeIndex, datasetIndex, angleMax)
    
    if x > 1000
        x = 1000;
    end

    if (datasetIndex == 1)                                % Training Set
    switch slopeIndex
        case 1
            alpha = 5 + cos(x / 100) + sin(sqrt(3) * x / 60);
        case 2
            alpha = 4 + sin(x / 150) + cos(x / 80);
        case 3
            alpha = 6 + 0.7 * sin(x / 70) - cos(sqrt(2) * x / 55);
        case 4
            alpha = 4.5 + sin(x / 120) + 1.2 * cos(sqrt(3) * x / 85);
        case 5
            alpha = 3 + cos(x / 65) + sin(sqrt(5) * x / 90);
        case 6
            alpha = 5 + 1.3 * sin(x / 110) + cos(x / 75);
        case 7
            alpha = 4 - sin(sqrt(2) * x / 95) + 1.5 * cos(x / 65);
        case 8
            alpha = 3.5 + sin(x / 130) + cos(sqrt(7) * x / 50);
        case 9
            alpha = 4.5 + cos(x / 105) - sin(x / 85);
        case 10
            alpha = 3 + 1.8 * sin(x / 90) + cos(sqrt(3) * x / 70);
    end
    
    elseif (datasetIndex == 2)                            % Validation Set
        switch slopeIndex
            case 1
                alpha = 4.5 + sin(x / 120) + cos(sqrt(4) * x / 60);
            case 2
                alpha = 3 + 2.1 * sin(x / 100) + cos(x / 110);
            case 3
                alpha = 5 + cos(sqrt(2) * x / 80) - sin(x / 95);
            case 4
                alpha = 3.8 + 0.9 * sin(x / 70) + cos(x / 95);
            case 5
                alpha = 2.5 + sin(sqrt(3) * x / 60) + 1.2 * cos(x / 50);
        end
    
    elseif (datasetIndex == 3)                           % Test Set
        switch slopeIndex
            case 1
                alpha = 5.5 + 0.3 * sin(x / 100) - log(x / 30);
            case 2
                alpha = 4 + log(2 + x / 600) - cos(sqrt(4) * x / 85);
            case 3
                alpha = 5 + tanh(x / 80) - sin(x / 130);
            case 4
                alpha = 3.3 + cos(sqrt(3) * x / 100) + sin(x / 75);
            case 5
                alpha = 2 + (x / 1400) + sin(x / 85) + 0.7 * cos(sqrt(2) * x / 65);
        end
    end


    if alpha > angleMax
        angle = angleMax;
    elseif alpha < 0
        angle = 0; 
    else
        angle = alpha;
    end
end