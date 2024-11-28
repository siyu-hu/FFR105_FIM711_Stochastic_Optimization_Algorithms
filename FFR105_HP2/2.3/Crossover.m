function [offspring1, offspring2] = Crossover(parent1, parent2, numOfInput, numOfHidden, numOfOutput)
    chromosomeLength = (numOfHidden * (numOfInput+ 1)) + (numOfOutput * (numOfHidden + 1));
    crossoverPoint = randi([1, chromosomeLength - 1]);
    offspring1 = [parent1(1 : crossoverPoint), parent2(crossoverPoint + 1 : end)];
    offspring2 = [parent2(1 : crossoverPoint), parent1(crossoverPoint + 1 : end)];
end
