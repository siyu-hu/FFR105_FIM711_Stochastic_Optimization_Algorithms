% FFR105 HP2.4 LGP
% Author: Siyu Hu gushusii@student.gu.se, 19950910-3702
% Dataset type 1-training, 2-validation, 3-test   

function RunFFNNOptimization()  
    close all;
    clear all;
    clc;
           
    % FFNN parameters
    numOfInput = 3;                
    numOfHidden = 7;              
    numOfOutput = 2;                  
    weightMax = 5;                     
    activationConstant = 2;      

    % GA parameters
    numOfGenerations = 500;  
    populationSize = 100;
    tournamentProbability = 0.8;
    tournamentSize = 5;
    crossoverProbability = 0.75;
    mutationProbability = 0.035;
    validationFitnessHistory = zeros(numOfGenerations, 1);  
    trainingFitnessHistory = zeros(numOfGenerations, 1); 
    tempBestChromosome = [];
    stagnationCount = 0; 
    
    bestChromosome = zeros(numOfGenerations, (numOfHidden * (numOfInput + 1)) + (numOfOutput * (numOfHidden + 1)));

    % GA: Initialize Population
    population = InitializePopulation(populationSize, numOfInput, numOfHidden, numOfOutput, weightMax);
  
    for generation = 1:numOfGenerations
        maximumFitness = 0;
        fitnessValues = zeros(populationSize, 1);
        
        % GA: Evaluate Individual
        for i = 1:populationSize
            [weightsInputHidden, weightsHiddenOutput] = DecodeChromosome(population(i, :), numOfInput, numOfHidden, numOfOutput, weightMax);
            fitnessValues(i) = EvaluateIndividual(weightsInputHidden, weightsHiddenOutput, 1, activationConstant); 
                                                  
            if (fitnessValues(i) > maximumFitness ) 
                maximumFitness = fitnessValues(i);
                tempBestChromosome = population(i, :);
                
            end
        end
        
        trainingFitnessHistory(generation) = maximumFitness;
        bestChromosome(generation,:) = tempBestChromosome; 

        if ~isempty(tempBestChromosome)
            [weightsInputHidden, weightsHiddenOutput] = DecodeChromosome(tempBestChromosome, numOfInput, numOfHidden, numOfOutput, weightMax);
            validationFitness = EvaluateIndividual(weightsInputHidden, weightsHiddenOutput, 2, activationConstant); 
            
            validationFitnessHistory(generation) = validationFitness;

            if generation >= 2 
                if abs(validationFitnessHistory(generation) - validationFitnessHistory(generation-1)) <= 0.1
                    stagnationCount = stagnationCount + 1; 
                else
                    stagnationCount = 0;
                end
            end

        end

        fprintf('Generation = %d , training fitness = %.6f,  validation fitness = %.6f \n',generation, trainingFitnessHistory(generation) ,validationFitnessHistory(generation) );

        % GA: Tournament Selection and Crossover    
        temporaryPopulation = population; 
        
        for i = 1:2:populationSize 
            i1 = TournamentSelection(fitnessValues, tournamentProbability, tournamentSize);
            i2 = TournamentSelection(fitnessValues, tournamentProbability, tournamentSize);
            r = rand;
            if (r < crossoverProbability) 
                parent1 = temporaryPopulation(i1, :);
                parent2 = temporaryPopulation(i2, :);
                [offspring1, offspring2] = Crossover(parent1, parent2, numOfInput, numOfHidden, numOfOutput);
                temporaryPopulation (i, :) = offspring1;
                temporaryPopulation (i + 1, :) = offspring2;
            else
                temporaryPopulation(i, :) = population(i1, : );
                temporaryPopulation(i + 1, :) = population(i2, : );         
            end
        end
                
        % GA: Mutation
        temporaryPopulation(1,:) = bestChromosome(generation,:); 

        for i = 2:populationSize
            tempIndividual = Mutate(temporaryPopulation(i,:),mutationProbability);
            temporaryPopulation(i,:) = tempIndividual;
        end
        population = temporaryPopulation;

         
        % End the GA process early due to stagnation
        if stagnationCount >= 30
            break;  
        end
     
    end

    save('bestChromosome.mat', 'bestChromosome');

    stopGeneration = generation; 

    figure;
    plot(1:stopGeneration, trainingFitnessHistory(1:stopGeneration), 'b-', 'LineWidth', 2);
    hold on;
    plot(1:stopGeneration, validationFitnessHistory(1:stopGeneration), 'r-', 'LineWidth', 2);
    xlabel('Generation');
    ylabel('Fitness');
    title('Training and Validation Fitness over Generations');
    legend('Training Fitness', 'Validation Fitness');
    grid on;
end
