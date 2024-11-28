% This function should run gradient descent until the L2 norm of the
% gradient falls below the specified threshold.

function x = RunGradientDescent(xStart, mu, eta, gradientTolerance)
    converged = false;
    x = xStart;
 
    while (~converged)
        gradientX =  ComputeGradient(x, mu);
        x = x - eta * gradientX; 
        gradientNorm = sqrt(sum(gradientX .^ 2));%.^  each of element  * 
        
        if gradientNorm < gradientTolerance
            converged = true;
            return;
        end 
    end
end

