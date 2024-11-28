% FFR105 HP2.4 LGP
% Author: Siyu Hu gushusii@student.gu.se, 19950910-3702

function RunLGP

    minChromosomeLength = 8;
    maxChromosomeLength = 800;
    populationSize = 100;
    maxGenerations = 100000; 
    mutationProbability = 0.05; 
    crossoverProbability = 0.7;
    tournamentProbability = 0.8;
    tournamentSize = 8;
    operators = ['+', '-', '*', '/'];
    constants = [ -10, -1, 0, 0.5, 1]; 
    numOfOperators = length(operators);
    numOfRegisters = 3; 
    lengthPenalty = 0.95;
    functionData = LoadFunctionData;

    population = InitializePopulation(populationSize, minChromosomeLength, maxChromosomeLength, numOfOperators, numOfRegisters, constants);

    bestOverallIndividual = population(1);
    bestOverallIndividual.Fitness = 0;

    for generation = 1:maxGenerations     

        for i = 1:populationSize
            population(i).Fitness = EvaluateIndividual(population(i), functionData, numOfRegisters, constants, operators);
          
        end

        [bestFitnessValue, maxIndex] = max([population.Fitness]);
        if bestFitnessValue > bestOverallIndividual.Fitness
           bestOverallIndividual = population(maxIndex);
           disp(['Generation ', num2str(generation), ' - Best Fitness:', num2str(bestOverallIndividual.Fitness)]);
        end

        if mod(generation, 200)==0
            disp(['current generation:  ', num2str(generation)]);
        end

        temporaryPopulation = population;
        for i = 1:2:populationSize 
            i1 = TournamentSelect(temporaryPopulation, populationSize, tournamentProbability, tournamentSize);
            i2 = TournamentSelect(temporaryPopulation, populationSize, tournamentProbability, tournamentSize);

            r = rand;
            if (r < crossoverProbability)
                individual1 = temporaryPopulation(i1);
                individual2 = temporaryPopulation(i2);
                [newIndividual1, newIndividual2] = Crossover(individual1, individual2);
                temporaryPopulation(i) = newIndividual1;
                temporaryPopulation(i + 1) = newIndividual2;
            else
                temporaryPopulation(i) = population(i1);
                temporaryPopulation(i + 1) = population(i2);
            end
        end

        for i = 1:populationSize
            if temporaryPopulation(i).ChromosomeLength > 500
                temporaryPopulation(i).Fitness = temporaryPopulation(i).Fitness * lengthPenalty;
            end
        end

        for i = 1:populationSize
            if temporaryPopulation(i).Fitness ~= bestOverallIndividual.Fitness
                temporaryPopulation(i) = Mutate(temporaryPopulation(i), mutationProbability, numOfOperators, numOfRegisters, length(constants));
            end   
        end
        temporaryPopulation(1) = bestOverallIndividual;
        population = temporaryPopulation;
  
    end
    
    fileID = fopen('BestChromosome.m', 'w');
    fprintf(fileID, 'bestOverallIndividual.Chromosome = [\n');
    for i = 1:size(bestOverallIndividual.Chromosome, 1)
        fprintf(fileID, '%d %d %d %d;\n', bestOverallIndividual.Chromosome(i, :));
    end
    fprintf(fileID, '];\n');
    fprintf(fileID, 'bestOverallIndividual.Fitness = %f;\n', bestOverallIndividual.Fitness);
    fprintf(fileID, 'bestOverallIndividual.ChromosomeLength = %d;\n', bestOverallIndividual.ChromosomeLength);  
    fclose(fileID);

    disp(['Best Fitness: ', num2str(bestOverallIndividual.Fitness)]);
end
