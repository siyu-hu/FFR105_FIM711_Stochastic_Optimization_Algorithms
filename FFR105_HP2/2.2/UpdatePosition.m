function x_new = UpdatePosition(xmin, xmax,x, v)
    [numOfParticles, dim] = size(x);

    for i = 1:numOfParticles
        x(i, :) = x(i, :) + v(i, :);  

        for d = 1:dim
            if x(i, d) > xmax
                x(i, d) = xmax;  
            elseif x(i, d) < xmin
                x(i, d) = xmin; 
            end
        end
    end

    x_new = x;
end
