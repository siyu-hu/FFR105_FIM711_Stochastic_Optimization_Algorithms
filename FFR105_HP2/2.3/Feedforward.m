% Forward pass through the FFNN   
% wIH: Weights from input to hidden layer (nHidden x nInput+1)
% wHO: Weights from hidden to output layer (nOutput x nHidden+1)

function [brakePressure, deltaGear] = Feedforward(input, weightInputHidden, weightHiddenOutput, c)
    input = [input; -1]; 
    temp1 = weightInputHidden * input;
    hidden = 1./(1 + exp(-c * temp1));

    hidden = [hidden; -1]; 
    temp2 = weightHiddenOutput * hidden;
    output = 1 ./ (1 + exp(-c * temp2)) ;

    brakePressure = output(1); 
    deltaGear = output(2); 
end

