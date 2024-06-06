function points = bresenhamLine(x1, y1, x2, y2)
    dx = abs(x2 - x1);
    dy = abs(y2 - y1);
    sx = sign(x2 - x1);
    sy = sign(y2 - y1);
    
    err = dx - dy;
    
    x = x1;
    y = y1;
    
    points = [x, y];
    
    while x ~= x2 || y ~= y2
        e2 = 2 * err;
        if e2 > -dy
            err = err - dy;
            x = x + sx;
        end
        if e2 < dx
            err = err + dx;
            y = y + sy;
        end
        
        points = [points; [x, y]];
    end
end