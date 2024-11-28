function value = GetOperandValue(index, registers, numOfRegisters, constants)
    if  index > (numOfRegisters + length(constants)) || index < 1
        error('Error: GetOperandValue index is invalid ');
    end

    if index <= numOfRegisters
        value = registers(index);
    else
        constantIndex = index - numOfRegisters;
        value = constants(constantIndex);      
    end
end
