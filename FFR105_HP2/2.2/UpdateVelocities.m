% Equation 5.14 and restrict abs(vij)< vmax 
function v_new = UpdateVelocities(v, x, xpbest, xsbest, c1, c2, inertiaWeight, vmax)
    [numOfParticles, dim] = size(x);
    r1 = rand(numOfParticles, dim); 
    r2 = rand(numOfParticles, dim); 

    for i = 1:numOfParticles
        v(i, :) = inertiaWeight * v(i, :) + c1 * r1(i, :) .* (xpbest(i, :) - x(i, :)) + c2 * r2(i, :) .* (xsbest - x(i, :));

        for j = 1:dim
            if v(i, j) > vmax
                v(i, j) = vmax;
            elseif v(i, j) < -vmax
                v(i, j) = -vmax;
            end
        end
    end
    v_new = v;
end
