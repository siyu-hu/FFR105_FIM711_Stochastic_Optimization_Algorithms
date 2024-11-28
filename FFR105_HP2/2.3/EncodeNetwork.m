% Genes take value from [0, 1]
function chromosome = EncodeNetwork(wIH, wHO, wMax)
    wIH_vector = wIH(:)';
    wHO_vector = wHO(:)';
    tempChromosome = [wIH_vector, wHO_vector];
    chromosome = (tempChromosome + wMax) / (2 * wMax);
end