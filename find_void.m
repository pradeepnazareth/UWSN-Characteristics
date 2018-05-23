function [neighbour, neighbour_to_sink_dis] = find_void(node,sink,numNodes,nodePositions,...
              accRange,neighbour,void_nodes, neighbour_to_sink_dis)

index =1;

 % Copy x/y/z co-ordinates of forwarding node
 node_x=nodePositions(node,1);
 node_y=nodePositions(node,2);
 node_z=nodePositions(node,3);
 
 % Copy coordinates of sink node
 sink_x = sink(1,1);    
 sink_y = sink(1,2);
 sink_z = sink(1,3);
 
 % find the distance between node and sink
 dst_sink = sqrt((node_x- sink_x)^2 + (node_y- sink_y)^2 + (node_z- sink_z)^2);

% code to find neighbours for a given node
 for i=1: numNodes
    if (node == i)
         continue;
    end
       
    % Copy x/y/z co-ordinates of nodes
    x=nodePositions(i,1);
    y=nodePositions(i,2);
    z= nodePositions(i,3);
           
    distance = sqrt((node_x-x)^2 + (node_y-y)^2 + (node_z-z)^2);
    if ( distance <=  accRange)              
        neighbour(node,index)=i;
        index= index +1;
        
    end
 end
 
 % Code to check a node is void or not
  no_of_neighbour=sum(neighbour(node,:)~= 0)
  for i=1:no_of_neighbour
     neighbouring_node= neighbour(node,i)
    nx= nodePositions(neighbouring_node,1)
    ny= nodePositions(neighbouring_node,2)
    nz= nodePositions(neighbouring_node,3)
    dst_sink = sqrt((nx- sink_x)^2 + (ny- sink_y)^2 + (nz- sink_z)^2);
    neighbour_to_sink_dis(node,i)=dst_sink;
  end
    
    
    
 

end

