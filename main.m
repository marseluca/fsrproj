clear all
clc

% Matlab is loading the map as a struct,
% so I need to extract the corresponding field. Otherwise:
% image_map = load("image_map.mat")
image_map = load('image_map.mat').image_map;
image_map_writable = load('image_map.mat').image_map;

qstart = [30, 125];
qgoal = [135, 400];
delta = 20;
neighRadius = 25;
maxIterations = 1200;
requestedGoalDistance = 20;

%% Initialization
n = 1;
qnew = [0,0];
graph = [qstart 0 0];
figure
hold on

%% Algorithm
while n<=maxIterations

    % Extract a random configuration
    qrand = [randi(size(image_map,1)), randi(size(image_map,2))];

    % Exclusive to RRT*
    pointsInNeigh = getPointsInNeighborhood(neighRadius,graph,qrand);

    while isempty(pointsInNeigh)            
            qrand = [randi(size(image_map,1)), randi(size(image_map,2))];
            pointsInNeigh = getPointsInNeighborhood(neighRadius, graph, qrand);
    end

    qnear = getMinorCostPoint(pointsInNeigh, graph);

    % Check the nearest configuration to qrand
    % [qnear,distance] = computeMinDistance(qrand,graph);

    % Get the points connecting these qnear and qrand
    points = bresenhamLine(qnear(1),qnear(2),qrand(1),qrand(2));

    % Compute the distance between qnear and qrand
    distance = norm(qrand-qnear);

    % If qrand is further than a distance delta from qrand
    % get the configuration at the distance delta as qnew
    if distance>=delta
        i=1;
        while round(norm(qnear-points(i,:)))<delta
            qnew = points(i,:);
            i=i+1;
        end
    % Otherwise, find the point at a distance delta from qnear,
    % in the direction of qrand
    elseif distance<delta
        qnew = pointAlongDirection(qnear,qrand,delta,image_map);
    end

    % Get the points between qnear and qnew
    points = bresenhamLine(qnear(1),qnear(2),qnew(1),qnew(2));

    % Check for collisions
    collision = checkCollision(image_map,points);
    
    % Check if qnew is already present in the graph
    isInGraph = false;
    for i=1:size(graph,1)
        if isequal(graph(i,1:2),qnew)
            isInGraph = true;
            break;
        end
    end

    % If no collisions, add qnew to the graph
    if collision == false && isInGraph == false
        for j = 1:size(points,1) 
            image_map_writable(points(j,1),points(j,2))=0;
        end
        graph = [graph; qnew qnear];

        % rewiring
        graph = rewiring(graph,pointsInNeigh);
    end



    % Find the nearest configuration to the goal
    [qnearest,distance] = computeMinDistance(qgoal,graph);
    % qNearest = findNearestPoint(graph,qgoal)
    goalDistance = norm(qnearest-qgoal);
    
    % Find the points and collision check on them
    points = bresenhamLine(qnearest(1),qnearest(2),qgoal(1),qgoal(2));
    collision = checkCollision(image_map,points);
    
    % Flag the collision
    if collision == false && goalDistance<=requestedGoalDistance
        graph = [graph; qgoal, qnearest];

        [totalPath,goalCost] = computeGoalTrajectory(qgoal,graph);
        fprintf("Success at iteration n. %d, with cost %d\n\n", n, goalCost)
        disp("Goal path:")
        % totalPath

        break;
    end

    n=n+1

end


% Display the results
for j = 1:size(points,1)
    image_map_writable(points(j,1),points(j,2))=0;
end

imshow(image_map_writable)
hold on
plot(qstart(2),qstart(1), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
plot(qgoal(2),qgoal(1), 'ro', 'MarkerSize', 10, 'LineWidth', 2);

if collision == true || goalDistance>requestedGoalDistance
    disp("Failure")
else
    for i=1:size(totalPath,1)-1
        x = [totalPath(i,2), totalPath(i+1,2)];
        y = [totalPath(i,1), totalPath(i+1,1)];
        line(x, y, 'Color', 'r', 'LineWidth', 2);
    end
end

