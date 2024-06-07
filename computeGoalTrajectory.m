function [totalPath,goalCost] = computeGoalTrajectory(actualPoint,graph)
    
    reversePath = [actualPoint];
    qstart = graph(1,1:2);
    qgoal = actualPoint;

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
    
    totalPath = flipud(reversePath);
    goalCost = computeCost(qgoal,graph);
end

