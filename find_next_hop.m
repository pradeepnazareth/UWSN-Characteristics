% fn. to find the next hop nearest hop to destination
function min_hop =find_next_hop(source, sink ,neighbours, nodePositions)

% copy x/y/z co-ordinates of souce
 sx=nodePositions(source,1);
 sy=nodePositions(source,2);
 sz=nodePositions(source,3);
 
 % Copy the coordinates of sink
 dx=sink(1);
 dy=sink(2);
 dz=sink(3);
 
% find distance between source to sink node
 distance_source_sink= sqrt((sx-dx)^2 + (sy-dy)^2 + (sz-dz)^2);
 
 totalNeighbours=numel(neighbours);
 neighbour_to_sink= zeros(totalNeighbours, 1);
 % find the distance between each neighbour of source to sink
 for i=1:totalNeighbours
    
     nx=nodePositions(neighbours(i),1);
     ny=nodePositions(neighbours(i),2);
     nz=nodePositions(neighbours(i),3);
     distance_neighbour_sink= sqrt((nx-dx)^2 + (ny-dy)^2 + (nz-dz)^2);
     neighbour_to_sink(i,1)= neighbours(i);
     neighbour_to_sink(i,2)= distance_neighbour_sink;
 end
     % find the node having MINIMUM distance to sink
     [M, I] =min(neighbour_to_sink(:,2));
     min_neighbour_sink= M;
     min_hop= neighbour_to_sink(I,1)
      
      if(distance_source_sink < min_neighbour_sink)
          disp('No node found with shorter distance than forwarding node');
          disp('FOUND VOID NODE: GREEDY FORWARDING TERMINATED');
      end
      msg=sprintf(' next nearest hop will be %d', min_hop);
      disp(msg);
end

