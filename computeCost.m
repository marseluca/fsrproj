function nodeCost = computeCost(actualPoint,graph)

% This function computes the cost of a node from the start node

    reversePath = [actualPoint];
    qstart = graph(1,1:2);

    % display("computeCost outside the while")
    
    % Cicla il while finché non arrivi al punto qstart
    count = 0;
    fprintf("Looking for: [%d,%d]\n\n",actualPoint(1),actualPoint(2))
    while ~isequal(actualPoint,qstart)
        count = count+1;
      
        % display("inside the while to find qstart")

        % Trova l'indice di actualPoint nel graph
        posInGraph=1;
        while ~isequal(actualPoint,graph(posInGraph,1:2))
            posInGraph = posInGraph + 1;
            % fprintf("inside the while to find posInGraph: %d\n",posInGraph)
            % graph
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

