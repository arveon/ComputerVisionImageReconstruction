function y=reconstruct_img_in_folder(first, last, targets_folder, dataset_folder)
clearvars -except first sidesize last targets_folder dataset_folder;
    images=load_images(dataset_folder);
    for i=first:last
       img=sprintf("%s/%d.jpg",targets_folder,i); 
       result = reconstruct_image_with_frame(img,400,20,dataset_folder,-1,-1,images);
%         result = padarray(result,[170 50],'both');%adds black borders
       
       
       img=erase(img,".jpg");
       newpath=sprintf("%s%s",img,"_reconstructed.jpg");
       imwrite(result, newpath);
    end
    

end