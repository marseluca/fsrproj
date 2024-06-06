function pointsInNeigh = getPointsInNeighborhood(neighRadius,graph,qRand)
    pointsInNeigh = [];
    for i=1:size(graph,1)
        if norm(qRand-graph(i,1:2)) < neighRadius
            pointsInNeigh=[pointsInNeigh;graph(i,1:2)];
        end
    end
end