function y = load_image(image_path)

    image=imread(image_path);
%     image=rgb2lab(image);
    
    [rows, cols, channels] = size(image);
    %check if image is black and white and if it is, generate an rgb
    %version with duplicate values in other channels
    if channels == 1
        image=repmat(image,[1,1,3]);
    end    
    
    info = imfinfo(image_path);
    if isfield(info,'Orientation')
       orient = info(1).Orientation;
       switch orient
         case 2
            image = image(:,end:-1:1,:);         %right to left
         case 3
            image = image(end:-1:1,end:-1:1,:);  %180 degree rotation
         case 4
            image = image(end:-1:1,:,:);         %bottom to top
         case 5
            image = permute(image, [2 1 3]);     %counterclockwise and upside down
         case 6
            image = rot90(image,3);              %undo 90 degree by rotating 270
         case 7
            image = rot90(image(end:-1:1,:,:));  %undo counterclockwise and left/right
         case 8
            image = rot90(image);                %undo 270 rotation by rotating 90
%          otherwise
%             warning(sprintf('unknown orientation %g ignored\n', orient));
       end
    end
    
    y = image;
end