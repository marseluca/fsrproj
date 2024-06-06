function MinorCostPoint = getMinorCostPoint(pointsInNeigh, graph, qstart)

pathTotalCosts = [];

    for i=1:size(pointsInNeigh,1)
        % Seleziona un punto tra quelli nel Neighborhood
        actualPoint = pointsInNeigh(i,:);
        reversePath = [actualPoint];
        
        totalCost = computeCost(actualPoint,qstart);
        
        % Cicla il while finché non arrivi al punto qstart
        while ~isequal(actualPoint,qstart)

            % Trova l'indice di actualPoint nel graph
            posInGraph=1;
            while ~isequal(actualPoint,graph(posInGraph,1:2))
                posInGraph = posInGraph + 1;
            end

            % Trova il previousPoint
            previousPoint = graph(posInGraph,3:4);

            % Aggiungi il previousPoint al reversePath
            reversePath = [reversePath;previousPoint];

            % Passa al previousPoint e ricomincia il ciclo while 
            % finché non arrivi a qstart
            actualPoint = previousPoint;
        end
    
        % Calcola il costo di TUTTO il reversePath
        tempCost = 0;
        for c = 1:size(reversePath,1)-1
            tempCost = tempCost + norm(reversePath(c,:)-reversePath(c+1,:));
        end
    
        % Aggiungi il costo di TUTTO il reversePath
        % all'array contenente tutti i reversePath
        pathTotalCosts = [pathTotalCosts; tempCost];
    end

    indexOfMinorCostPoint = find(pathTotalCosts == min(pathTotalCosts), 1);
    MinorCostPoint = pointsInNeigh(indexOfMinorCostPoint,:);
end