% FFR105 HP2.2 PSO
% Main Function
% Author: Siyu HU, gushusii@student.gu.se, 19950910-3702


function RunPSO

    numOfParticles = 50; 
    maxIterations = 2000;
    numOfRuns = 30; 
    c1 = 2; 
    c2 = 2; 
    vmax = 2; 
    xmin = -5; 
    xmax = 5; 
    dim = 2;
    minValues = zeros(1, numOfRuns);
    
    inertiaWeight = 1.4;
    inertiaWeight_min = 0.3;
    
    figure;
    PlotLogContour();
    hold on;
    
    scatterHandles = [];

    for run = 1:numOfRuns
        x = xmin + (xmax - xmin) * rand(numOfParticles, dim);
        v = (-(xmin - xmax)/2) + rand(numOfParticles, dim) * (xmax - xmin);

        xpbest = x;
        xpbest_values = EvaluateSwarm(x);
        [xsbest_value, xsbest_idx] = min(xpbest_values);
        xsbest = x(xsbest_idx, :);

        for iteration = 1:maxIterations
            decreaseRate = 0.99;
            inertiaWeight = max(inertiaWeight * decreaseRate, inertiaWeight_min);
            v = UpdateVelocities(v, x, xpbest, xsbest, c1, c2, inertiaWeight, vmax);
            x = UpdatePosition(xmin, xmax, x, v);
            fitnessValues = EvaluateSwarm(x);

            for i = 1:numOfParticles
                if fitnessValues(i) < xpbest_values(i)
                    xpbest(i, :) = x(i, :);
                    xpbest_values(i) = fitnessValues(i);
                end
            end

            [current_xsbest_value, current_xsbest_idx] = min(fitnessValues);
            if current_xsbest_value < xsbest_value
                xsbest_value = current_xsbest_value;
                xsbest = x(current_xsbest_idx, :);
            end
       
        end
        minValues(run) = xsbest_value;
        minimaPositions(run, :) = xsbest;

    end
    
    avgValue = mean(minValues);
    stdValue = std(minValues);
    fprintf('Average of f(x1, x2) minimum: %.10f\n', avgValue);
    fprintf('Standard deviation of f(x1, x2) minimum: %.10f\n', stdValue);
    minimaTable = [minimaPositions, minValues']; 
    csvwrite('minima_results.csv', minimaTable);  
    scatter(minimaPositions(:, 1), minimaPositions(:, 2), 50, 'filled', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'r');
    hold off;

   
end

