close all; 
clear all; 


% parameters for rrt
dist_threshold = 0.8;

% create map space
x_max = 12; 
y_max = 12; 

% define starting position
start = [5; 5]

% generate simple map
% if you have the navigation toolbox installed, you can try this experiment
% with a previous defined map -- uncomment the following line
% map = load_map_from_image('simple_office_map.png');
map = zeros(1200,1200);

figure(1); 
% show(map)     % uncomment if you use the navigation package
hold on; 
plot(start(1), start(2), 'ro')
grid on; 
xlim([0 x_max]);
ylim([0 y_max]);



% add the starting node to the tree
tree = [start]; 

% number of iterations
n = 1000; 
for i=1:n

    % get a random point int the area
    rnd_point = get_random_coord(x_max, y_max); 


    shortest_dist       = 10000; 
    nearest_neighbor    = start; 
    nr_of_tree_elements = length(tree(1,:));


    % find the closest point in the tree
    for j=1:nr_of_tree_elements
       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       %        ADD YOUR CODE HERE          %
       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    end


    % if the distance exceeds the distance threshold
    % move the point in the direction of the closest point. 
    % the point should be then have the same distance to the closest
    % point, as the distance threshold
    if (shortest_dist > dist_threshold)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %        ADD YOUR CODE HERE          %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        
    end


    
    % check if the added point is within an obstacle and draw a line
    % between the random point and the closest point
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %        ADD YOUR CODE HERE          %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 


    plot(rnd_point(1), rnd_point(2), 'g+');
    % hold on; 
    % plot([best_point(1) rnd_point(1)], [best_point(2) rnd_point(2)], 'r-');

    drawnow; 
end





function map = load_map_from_image(image_path)
    image     = imread('simple_office_map.png');
    grayimage = rgb2gray(image);
    bwimage   = grayimage < 0.5;
    map       = binaryOccupancyMap(bwimage,100);
end

function rnd_point = get_random_coord(x_max, y_max)
    x = rand*x_max;
    y = rand*y_max;
    rnd_point = [x; y];
end



