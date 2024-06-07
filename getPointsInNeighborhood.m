function pointsInNeigh = getPointsInNeighborhood(neighRadius,graph,qRand)
    pointsInNeigh = [];

    for i=1:size(graph,1)
        
        isInNeigh = false;
        if ~isempty(pointsInNeigh)
            for i=1:size(pointsInNeigh,1)
                if isequal(pointsInNeigh(i,:),graph(i,1:2))
                    isInNeigh = true;
                    break;
                end
            end
        end

        if (norm(qRand-graph(i,1:2)) < neighRadius) && (isInNeigh == false)
            pointsInNeigh=[pointsInNeigh;graph(i,1:2)];
        end
    end
end