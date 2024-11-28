%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameter specifications
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

numberOfRuns = 100;                % Do NOT change
populationSize = 100;              % Do NOT change
maximumVariableValue = 5;          % Do NOT change (x_i in [-a,a], where a = maximumVariableValue)
numberOfGenes = 50;                % Do NOT change
numberOfVariables = 2;		   % Do NOT change
numberOfGenerations = 300;         % Do NOT change
tournamentSize = 2;                % Do NOT change
tournamentProbability = 0.75;      % Do NOT change
crossoverProbability = 0.8;        % Do NOT change


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Batch runs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Define more runs here (pMut < 0.02) ...

mutationProbability = [ 0, 0.01, 0.02, 0.03, 0.1, 0.2, 0.3, 0.6, 0.8, 1];
medianFitnessValues = zeros(length(mutationProbability), 1);

for j = 1:length(mutationProbability)
    mutationProb = mutationProbability(j);
    fprintf('Mutation rate = %0.5f\n', mutationProb);

    maximumFitnessList = zeros(numberOfRuns, 1);

    for i = 1:numberOfRuns 
     [maximumFitness, bestVariableValues]  = RunFunctionOptimization(populationSize, numberOfGenes, numberOfVariables, maximumVariableValue, tournamentSize, ...
                                           tournamentProbability, crossoverProbability, mutationProb, numberOfGenerations);
      
     maximumFitnessList(i,1) = maximumFitness;
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Summary of results
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Add more results summaries here (pMut < 0.02) ...
    
    averageFitness = mean(maximumFitnessList);
    medianFitness = median(maximumFitnessList);
    stdFitness = std(maximumFitnessList);
    medianFitnessValues(j) = medianFitness;

    sprintf('PMut = %0.2f: Median: %0.10f, Average: %0.10f, STD: %0.10f\n', mutationProb, medianFitness, averageFitness, stdFitness);
    
end

figure;
plot(mutationProbability, medianFitnessValues, '-o');
xlabel('Mutation Probability');
ylabel('Median Fitness Value');
title('Median Fitness Value vs. Mutation Probability');
grid on;
