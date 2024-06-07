function MinorCostPoint = getMinorCostPoint(pointsInNeigh, graph)

pathTotalCosts = [];
nodeCost = [];

    for i=1:size(pointsInNeigh,1)
        % Seleziona un punto tra quelli nel Neighborhood
        actualPoint = pointsInNeigh(i,:);
        
        nodeCost = computeCost(actualPoint,graph);
    
        % Aggiungi il costo di TUTTO il reversePath
        % all'array contenente tutti i reversePath
        pathTotalCosts = [pathTotalCosts; nodeCost];
    end

    indexOfMinorCostPoint = find(pathTotalCosts == min(pathTotalCosts), 1);
    MinorCostPoint = pointsInNeigh(indexOfMinorCostPoint,:);
end