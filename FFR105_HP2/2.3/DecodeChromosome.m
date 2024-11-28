% Weights (and biases) should take values in the range [-wMax,wMax]

function [weightInputHidden , weightHiddenOutput ] = DecodeChromosome(chromosome, numOfInput, numOfHidden, numOfOutput, weightMax)

    chromosome = (chromosome * 2 * weightMax) - weightMax;

    lengthOfwIH = numOfHidden * (numOfInput + 1);
    lengthOfwHO = numOfOutput * (numOfHidden + 1);

    if length(chromosome) ~= (lengthOfwHO + lengthOfwIH)
        error('Decode error: length of chromosome is wrong');
    end

    vectorIH = chromosome(1:lengthOfwIH);
    vectorHO = chromosome(lengthOfwIH + 1 : lengthOfwIH + lengthOfwHO);

    weightInputHidden = reshape(vectorIH, [numOfHidden, numOfInput + 1]);
    weightHiddenOutput = reshape(vectorHO, [numOfOutput, numOfHidden + 1]);

end
