%returns id of a row in all_means that is the closest to image_mean
function y = get_closest_mean(all_means, image_mean)
    [rows, cols] = size(all_means);
    
    min_dist=1000;
    min_id=0;
    
    counter=1;
    id=[];
    
    %calculate weights for colours based on image mean
    %colour with largest value will have largest weight
    %color with lowest value will have lowest weight
    weights = rescale(image_mean,1,3).^2;%bring numbers to 1-2 range
    %make sure there are no 0 in weights
    %weights(weights==0)=1;
    
    for i=1:rows
            %i+rows and i+rows*2 instead of i+1 and i+2 is because it goes through
            %rows first all_means(i+1) would be the value in the same column next row
            cur_mean=[all_means(i), all_means(i+rows),all_means(i+rows*2)];
            
            dist = abs(cur_mean - image_mean);
            %simple_dist=dist(1)+dist(2)+dist(3);
            weighted_dist = dist(1)/weights(1) + dist(2)/weights(2) + dist(3)/weights(3);            
            
%             if weighted_dist < 3 && weighted_dist < min_dist 
%                 id(counter)=i;
%                 min_dist = weighted_dist;
%                 min_id=i;
%                 counter=counter+1;
%             elseif weighted_dist < 3
%                 id(counter)=i;
%                 counter=counter+1;
%             else
            if weighted_dist < min_dist
                min_dist = weighted_dist;
                min_id=i;
            end
            
    end
    if numel(id)==0
        y = min_id;
    else
        rand=randi([1,counter-1]);
        y=id(rand)
    end
end