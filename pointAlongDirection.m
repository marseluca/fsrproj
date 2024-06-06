function qpoint = pointAlongDirection(qstart, qmid, delta, map)

    direction_vector = qmid - qstart;
    direction_vector = direction_vector / norm(direction_vector);
    
    qpoint = round(qstart + delta * direction_vector);
    
    if qpoint(1)>size(map,1) || qpoint(2)>size(map,2)
        disp("The new point is outside matrix bounds");
        qpoint = qmid;
    end
end


