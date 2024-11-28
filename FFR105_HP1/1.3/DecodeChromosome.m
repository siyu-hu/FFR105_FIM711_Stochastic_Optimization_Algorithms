% Note: Each component of x should take values in [-a,a], where a = maximumVariableValue.

function x = DecodeChromosome(chromosome,numberOfVariables,maximumVariableValue)
    x = zeros(1, numberOfVariables);

    chromosomeLength = length(chromosome);
    numberOfBits = chromosomeLength / numberOfVariables; 
    for i = 1:numberOfVariables
        startIdx = (i-1)*numberOfBits + 1;
        endIdx = i*numberOfBits;
        binarySegment = chromosome(startIdx:endIdx);
        
        %Change Binary values to Decimal [0 1 1 0] -> '0110'
        decimalValue = sum(binarySegment .* (2.^(numberOfBits-1:-1:0))); % (start : step : end)
        
        %Reflect
        a = maximumVariableValue;
        x(i) = -a + (decimalValue / (2^numberOfBits - 1)) * 2 * a;
    end
end

