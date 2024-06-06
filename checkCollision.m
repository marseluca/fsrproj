function collision = checkCollision(map,points)
    
    collision = false;
    for i = 1:size(points,1)
        if map(points(i,1),points(i,2))==0
            collision = true;
            break
        end
    end

end

