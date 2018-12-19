%returns id of a row in all_means that is the closest to image_mean
function y = get_closest_means(all_means, image_mean, fragment, dataset_folder)
    [rows, cols] = size(all_means);
    
    min_dist=1000;
    min_dist2=1000;
    min_dist3=1000;
    min_id=1;
    min_id2=0;
    min_id3=0;
    counter=1;
    id=[];
    lowest_dist = 1000;
    lowest_id = 0;
    
    %calculate weights for colours based on image mean
    %colour with largest value will have largest weight
    %color with lowest value will have lowest weight
    weights = rescale(image_mean,1,2).^2;%bring numbers to 1-2 range
    %make sure there are no 0 in weights
    %weights(weights==0)=1;
    
    for i=1:rows
            %i+rows and i+rows*2 instead of i+1 and i+2 is because it goes through
            %rows first all_means(i+1) would be the value in the same column next row
            cur_mean=[all_means(i), all_means(i+rows),all_means(i+rows*2)];
            
            dist = abs(cur_mean - image_mean);
            %simple_dist=dist(1)+dist(2)+dist(3);
            weighted_dist = dist(1)/weights(1) + dist(2)/weights(2) + dist(3)/weights(3);            
%               weighted_dist=dist(1)+dist(2)+dist(3);
            
            if weighted_dist < lowest_dist
                lowest_id = i;
                lowest_dist = weighted_dist;
            end
            if weighted_dist < min_dist3
                if weighted_dist < min_dist
                    min_dist3 = min_dist2;
                    min_id3 = min_id2;
                    min_dist2 = min_dist;
                    min_id2 = min_id;
                    min_dist = weighted_dist;
                    min_id = i;
                elseif weighted_dist < min_dist2
                    min_dist3 = min_dist2;
                    min_id3 = min_id2;
                    min_dist2 = weighted_dist;
                    min_id2 = i;
                else
                    min_dist3 = weighted_dist;
                    min_id3 = i;
                end
                    
                
            end
            
            
    end
       
    lowest_path=sprintf("%s/%01d%s", dataset_folder,lowest_id,".jpg");
    y = imread(lowest_path);
    
%     rep_path=sprintf("%s/%01d%s", dataset_folder,min_id,".jpg");
%     rep_img=imread(rep_path);
%     f_size = size(fragment);
%     cmp_img = imresize(rep_img, [f_size(1),f_size(2)]);
%     best_sim = ssim(fragment, cmp_img);
%     y = rep_img;
%     if min_id2 > 0
%         rep_path2=sprintf("%s/%01d%s", dataset_folder,min_id2,".jpg");
%         rep_img2=imread(rep_path2);
%         cmp_img = imresize(rep_img2, [f_size(1),f_size(2)]);
%         s = ssim(fragment, cmp_img);
%         if s > best_sim
%            best_sim = s;
%            y = rep_img2;
%         end
%         if min_id3 > 0
%             rep_path3=sprintf("%s/%01d%s", dataset_folder,min_id3,".jpg");
%             rep_img3=imread(rep_path3);
%             cmp_img = imresize(rep_img3, [f_size(1),f_size(2)]);
%             s = ssim(fragment, cmp_img);
%             if s > best_sim
%                best_sim = s;
%                y = rep_img3;
%             end
%         end
%     end

    % TEST ABOVE
end