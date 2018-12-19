%returns id of a row in all_means that is the closest to image_mean
function y = get_closest_mean(all_means, image_mean)
    [rows, ~] = size(all_means);
    
    lowest_dist=10000;
    lowest_id = 1;
    
    lowest_dist1=10000;
    lowest_id1=1;
    
    lowest_dist2=10000;
    lowest_id2=1;
    
    lowest_dist3=10000;
    lowest_id3=1;
    
    %calculate weights for colours based on image mean
    %colour with largest value will have largest weight
    %color with lowest value will have lowest weight
     weights = rescale(image_mean,1,2);%bring numbers to 1-2 range
    %make sure there are no 0 in weights
    %weights(weights==0)=1;
    
    for i=1:rows
            %i+rows and i+rows*2 instead of i+1 and i+2 is because it goes through
            %rows first all_means(i+1) would be the value in the same column next row
            cur_mean=[all_means(i), all_means(i+rows),all_means(i+rows*2)];
            
            dist = abs(cur_mean - image_mean);

            weighted_dist = sqrt(dist(1)^2+dist(2)^2+dist(3)^2);
            
            if weighted_dist < lowest_dist1
                lowest_id1 = i;
                lowest_dist1 = weighted_dist;
            elseif weighted_dist < lowest_dist2  
                lowest_id2 = i;
                lowest_dist2 = weighted_dist;
            elseif weighted_dist < lowest_dist3
                lowest_id3 = i;
                lowest_dist3 = weighted_dist;
            end
    end
    a=randi([1 3],1,1);
    if a == 1
        y = lowest_id1;
    elseif a == 2
        y = lowest_id2;
    elseif a == 3
        y = lowest_id3;
    end
end