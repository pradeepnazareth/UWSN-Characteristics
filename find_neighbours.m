function  [ vector  ] =find_neighbours(source,accRange, numNodes,nodePositions)
vector = [];
index = 1;
for i=1: numNodes
   
    % copy x/y/z co-ordinates of souce
    sx=nodePositions(source,1);
    sy=nodePositions(source,2);
    sz=nodePositions(source,3);
    
    % Copy x/y/z co-ordinates of neighbor
    x=nodePositions(i,1);
    y=nodePositions(i,2);
    z= nodePositions(i,3);
    
    distance = sqrt((sx-x)^2 + (sy-y)^2 + (sz-z)^2);
    if ( distance <=  accRange)
        vector(index)=i;
        index= index +1;
        
    end
end
 
 return   
end

