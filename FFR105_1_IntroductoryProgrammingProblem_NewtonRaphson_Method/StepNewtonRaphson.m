% This method should perform a **single step** of the Newton-Raphson method.
% Note: In cases where the step cannot be completed, e.g. if f" = 0, a
% clear error message should be given.

function xNext = StepNewtonRaphson(x, fPrime, fDoublePrime)

    % check the second-order of differentiate
    
    if fDoublePrime ==0
        disp('Error: the second-order differetiation of input polynomial is empty ');
        xNext = NaN;
        return;
    else
        %Perform the single step of Newton-Raphson Method
        xNext = x - fPrime/fDoublePrime; 
    end
end

