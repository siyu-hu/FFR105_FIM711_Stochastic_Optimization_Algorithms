function [child1, child2] = Crossover(parent1, parent2)
    chromosome1 = parent1.Chromosome;
    chromosome2 = parent2.Chromosome;
    numOfInstructions = min (size(chromosome1, 1) ,size(chromosome2, 1));

    if numOfInstructions < 2
        child1 = parent1;
        child2 = parent2;
        return;
    end

    crossoverPoint1 = randi([1, numOfInstructions - 1]);
    crossoverPoint2 = randi([crossoverPoint1 + 1, numOfInstructions]);

    newChromosome1 = chromosome1;
    newChromosome2 = chromosome2;

    newChromosome1(crossoverPoint1:crossoverPoint2, :) = chromosome2(crossoverPoint1:crossoverPoint2,: );
    newChromosome2(crossoverPoint1:crossoverPoint2, : ) = chromosome1(crossoverPoint1:crossoverPoint2,: );

    childChromosome1 = newChromosome1;
    childChromosome2 = newChromosome2;

    child1 = struct('Chromosome', childChromosome1, 'Fitness', 0, 'ChromosomeLength', numel(childChromosome1));
    child2 = struct('Chromosome', childChromosome2, 'Fitness', 0, 'ChromosomeLength',  numel(childChromosome2));
end