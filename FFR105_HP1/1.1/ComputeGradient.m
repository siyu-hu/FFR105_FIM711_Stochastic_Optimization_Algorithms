% This function should return the gradient of f_p = f + penalty.
% You may hard-code the gradient required for this specific problem.
% penalty term = mu *(max{0, g(x1,x2)})^2 
% means that if g(x1, x2) < = 0, the penalty term value is equal to zero vector

function gradF = ComputeGradient(x,mu)

    x1  = x(1);
    x2 = x(2);
    
    g = x1^2 + x2^2 - 1 ;%  g(x1, x2)

    grad_f1 = 2 * (x1 - 1);  % df/dx1
    grad_f2 = 4 * (x2 - 2);  % df/dx2

    if g <= 0 
        grad_penalty1 = 0;
        grad_penalty2 = 0;
    else 
        grad_penalty1 = mu * 2 * g * 2 * x1;  % d(penalty)/dx1
        grad_penalty2 = mu * 2 * g * 2 * x2;  % d(penalty)/dx2
    end

    gradF = [grad_f1 + grad_penalty1; grad_f2 + grad_penalty2];

end
