function fitness = EvaluateIndividual(individual, data, numOfRegisters, constants, operators)
    chromosome = individual.Chromosome;
    chromosomeLength = individual.ChromosomeLength;
    numOfInstructions = chromosomeLength / 4 ;

    X = data(:, 1); 
    Y = data(:, 2); 
    K = length(X); 

    errors = zeros(K, 1);
  
    for k = 1:K

        registers(1) = X(k);
        registers(2:numOfRegisters) = 0;

        for j = 1:numOfInstructions
            operatorIndex = chromosome(j, 1); 
            destinationIndex = chromosome(j, 2);     
            operand1Index = chromosome(j, 3);
            operand2Index = chromosome(j, 4); 

            operand1 = GetOperandValue(operand1Index, registers, numOfRegisters, constants);
            operand2 = GetOperandValue(operand2Index, registers, numOfRegisters, constants);
            
            operator = operators(operatorIndex); 
            switch operator
                case '+'
                    result = operand1 + operand2;
                case '-'
                    result = operand1 - operand2;
                case '*'
                    result = operand1 * operand2;
                case '/'
                    if operand2 ~= 0
                        result = operand1 / operand2; 
                    else
                        result = 0; 
                    end
             
                otherwise
                    result = 0;
            end
            registers(destinationIndex) = result;
        end

        yPrime= registers(1);
        errors(k) = (yPrime - Y(k))^2;
    end

    e = sqrt(mean(errors));
    fitness = 1 / e;
end
