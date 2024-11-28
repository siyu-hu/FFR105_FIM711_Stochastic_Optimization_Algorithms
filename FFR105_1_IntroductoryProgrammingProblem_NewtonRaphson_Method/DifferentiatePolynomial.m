% This method should return the coefficients of the k-th derivative (defined by
% the derivativeOrder) of the polynomial given by the polynomialCoefficients (see also GetPolynomialValue)

function derivativeCoefficients = DifferentiatePolynomial(polynomialCoefficients, derivativeOrder)
    % Validation check
    if derivativeOrder < 0
        error('Order of differentiation (derivativeOrder) must be non-negative');
    end
    
    % Return if the differentiation order exceeds the degree of the polynomial
    numOfCoefficients = length(polynomialCoefficients);
    if derivativeOrder >= numOfCoefficients
        derivativeCoefficients = []; % If differentiation is higher than polynomial degree
        return;
    end
    
    % Recursive differentiation
    currentCoefficients = polynomialCoefficients; 
    for k = 1:derivativeOrder
        numOfCoefficients = length(currentCoefficients);
        newCoefficients = zeros(1, numOfCoefficients - 1); % Prepare the new coefficients array
        
        % Calculate the coefficients of the first derivative
        for i = 2:numOfCoefficients
            newCoefficients(i - 1) = (i - 1) * currentCoefficients(i);
        end
        
        % Update current coefficients for next iteration
        currentCoefficients = newCoefficients; % length of currentCoeffient -1, in Matlab, it doent need to modify the length manually
    end
    
    derivativeCoefficients = currentCoefficients;
end
