function nodeCost = computeCost(actualPoint,graph)

% This function computes the cost of a node from the start node

    reversePath = [actualPoint];
    qstart = graph(1,1:2);
    
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
    nodeCost = 0;
    for c = 1:size(reversePath,1)-1
        nodeCost = nodeCost + norm(reversePath(c,:)-reversePath(c+1,:));
    end
end

