function graph = rewiring(graph,pointsInNeigh)

    qstart = graph(1,1:2);
    qnew = graph(end,1:2);
    qnear = graph(end,3:4);
    
    for i=1:size(pointsInNeigh,1)

        % Seleziona un punto tra quelli nel Neighborhood
        actualPoint = pointsInNeigh(i,:);

        if ~isequal(actualPoint,qnear) && ~isequal(actualPoint,qnew)
            % 1. Calcola il costo di actualPoint nel graph
            nodeCost = computeCost(actualPoint,graph);

            % 2. Crea un nuovo graph in cui rimuovi il collegamento 
            % di actualPoint con il suo nodo precedente e lo sostituisci
            % con qnew
            newGraph = [];
            newGraph = graph;
            for i=1:size(newGraph,1)
                if isequal(actualPoint,newGraph(i,1:2))
                    if ~isequal(newGraph(i,3:4),qstart)
                        newGraph(i,3:4) = qnew;
                        break;
                    end
                end
            end
        
            
            % 3. Infine calcoli il costo di actualPoint nel nuovo grafico
            % ossia il costo passando per qnew
            newNodeCost = computeCost(actualPoint,newGraph);

            if newNodeCost<nodeCost
                graph = newGraph;
                % display("Node costs:")
                % newNodeCost
                % nodeCost
                % disp("rewired")
            else
                graph = graph;
            end
        end
    end


end

