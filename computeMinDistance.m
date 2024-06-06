function [qnear,minDistance] = computeMinDistance(qpoint,graph)

    % This function returns the nearest point to a given configuration

    minDistance = Inf;
    
    for i = 1:size(graph,1)
        distance = norm(qpoint-graph(i,1:2));
        
        if distance < minDistance
            minDistance = distance;
            qnear = graph(i,1:2);
        end
    end
end
