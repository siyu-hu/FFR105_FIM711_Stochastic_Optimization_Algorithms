% This function should return the value of the polynomial value = f(x) = a0x^0 + a1x^1 + a2x^2 ...
% where a0, a1, ... are obtained from polynomialCoefficients.


function value = GetPolynomialValue(x, polynomialCoefficients)

    %Initialize the value
    value = 0;
    
    % get the number of coefficients
    n = length(polynomialCoefficients);

    % get the polynomial value by summing each term x^(j-1), following this loop:
    for j =1:n
        oneTermValue =  x^(j-1) * polynomialCoefficients(j);
        value = value + oneTermValue;
    end
