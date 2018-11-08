%returns id of a row in all_means that is the closest to image_mean
function y = get_closest_mean(all_means, image_mean)
    [rows, cols] = size(all_means);
    
    
    min_dist=all_means(1)+all_means(1)+all_means(1);
    min_id=1;
    
    counter=1;
    id=[];
    
    for i=2:rows
            %i+rows and i+rows*2 instead of i+1 and i+2 is because it goes through
            %rows first all_means(i+1) would be the value in the same column next row
            cur_mean=[all_means(i), all_means(i+rows),all_means(i+rows*2)];
            
            dist = abs(image_mean-cur_mean);
            simple_dist=dist(1)+dist(2)+dist(3);
            
            if simple_dist < 3 && simple_dist < min_dist 
                id(counter)=i;
                min_dist = simple_dist;
                min_id=i;
                counter=counter+1;
            elseif simple_dist < 15
                id(counter)=i;
                counter=counter+1;
            else
                if simple_dist < min_dist
                min_dist = simple_dist;
                min_id=i;
            end     
    end
    if numel(id)==0
        y = min_id;
    else
        rand=randi([1,counter-1]);
        id
        y=id(rand);
    end
end