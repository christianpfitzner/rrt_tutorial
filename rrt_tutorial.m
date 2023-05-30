close all; 
clear all; 


% parameters for rrt
dist_threshold = 0.8;

x_max = 12; 
y_max = 12; 


start = [5; 5]

% generate simple map

% map = load_map_from_image('simple_office_map.png');
map = zeros(1200,1200);

figure(1); 
% show(map)
hold on; 
plot(start(1), start(2), 'ro')
grid on; 
xlim([0 x_max]);
ylim([0 y_max]);


tree = [start]; 

n = 1000; 
f = cell(n,1) ; 
for i=1:n

    
    rnd_point = get_random_coord(x_max, y_max); 

    % [best_point, shortest_dist] = find_nearest_tree_point(rnd_point, tree, start)

    shortest_dist       = 10000; 
    nearest_neighbor    = start; 
    nr_of_tree_elements = length(tree(1,:));

    for j=1:nr_of_tree_elements
        p = tree(:,j);
        dist = norm(p - rnd_point);
        if (dist < shortest_dist)
            shortest_dist = dist; 
            best_point    = p; 
        end; 
    end;


    % if the distance exceeds the distance threshold
    if (shortest_dist > dist_threshold)
        diff = rnd_point - best_point;
        l    = norm(diff);
        rnd_point = dist_threshold*(diff / l) + best_point;
    end



    % check if the line intersects with an obstacle
    diff      = rnd_point - best_point; 
    angle     = atan2(diff(2), diff(1));
    pose      = [best_point(1), best_point(2), angle]; 
    % intersect = rayIntersection(map, pose, angle, 3);
    % 
    % 
    % intersect_obstacle = sum(isnan(intersect));
    % 
    % 
    %     % check if this point is in obstacle
    % obstacle = checkOccupancy(map, rnd_point', "local");
    % if obstacle == 1
    %     plot(rnd_point(1), rnd_point(2), 'rx');
    %     % display(rnd_point);
    %     continue;
    % end


    % if (intersect_obstacle == 0)
    %     plot(intersect(1), intersect(2), 'bx'); 
    %     continue;
    % end

    % if((obstacle == 0) && (intersect_obstacle == 2))
        tree = [tree, rnd_point];
        % plot(rnd_point(1), rnd_point(2), 'g+');
        hold on; 
        plot([best_point(1) rnd_point(1)], [best_point(2) rnd_point(2)], 'r-');
    % end
    drawnow; 
    %pause(0.001);

   % f{i} = getframe(gcf) ;
end



% obj = VideoWriter('rrt.mpeg', 'MPEG-4');
% obj.Quality = 50;
% obj.FrameRate = 60;
% open(obj);
% for i = 1:n
%     writeVideo(obj, f{i}) ;
% end
% obj.close();



function [nearest_neighbor, shortest_dist] = find_nearest_tree_point(point, start, tree)

    shortest_dist       = 10000; 
    nearest_neighbor    = start; 
    nr_of_tree_elements = length(tree(1,:));
    
    for j=1:nr_of_tree_elements
        p = tree(:,j);
        point;
        dist = norm(p - point);
        if (dist < shortest_dist)
            shortest_dist = dist; 
            nearest_neighbor = p; 
        end; 

        nearest_neighbor;

    end;

    

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



