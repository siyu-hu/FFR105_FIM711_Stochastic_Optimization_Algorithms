function newIndividuals = Cross(individual1, individual2)
    individualLength = length(individual1);
    newIndividuals = zeros(2, individualLength);

    crossoverPoint = randi([1, individualLength - 1]); 
    newIndividuals(1, :) = [individual1(1:crossoverPoint), individual2(crossoverPoint+1:end)];
    newIndividuals(2, :) = [individual2(1:crossoverPoint), individual1(crossoverPoint+1:end)];
end