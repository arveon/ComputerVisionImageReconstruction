function features = knn_preTrainning()
  features.gabor_feature=@gabor_feature;
  features.edge_feature=@edge_feature;
  features.generate_labels = @labels;
  features.load_features_from_file = @load_features_from_file;
end
function y = gabor_feature(image_folder)
    %Create the gabor filters
    rot = [40 70 100 130 160]; % we have four orientations
    RF_siz    = 4;
    minFS     = 0.1; % the minimum receptive field
    maxFS     = 0.4; % the maximum receptive field
    sigma  = 0.0036*RF_siz.^2 + 0.35*RF_siz + 0.18; %define the equation of effective width
    lambda = sigma/0.8; % it the equation of wavelengthknn (lambda)
    g = gabor(lambda,rot);
    %Load the images
    images = dir(image_folder);
    gabor_features = zeros(numel(images), 1);
    %Loop through the images and computer the feature each one
    counter=1;
    for i=2:numel(images)
        %if is a directory, skip it
        if images(i).isdir
            continue
        end
        
        %ignore all but selected extensions
        [filepath, name, ext] = fileparts(images(i).name);
        if ~strcmp(ext, '.bmp') && ~strcmp(ext, '.jpg') && ~strcmp(ext, '.png') && ~strcmp(ext, '.JPG')
            continue
        end
        i_name=strcat(image_folder,"/", name, ext);
        out = imgaborfilt(rgb2gray(imread(i_name)),g);
        outSize = size(out);
        outMag = reshape(out,[outSize(1:2),1,outSize(3)]);
        %mn=image_mean(imread(i_name));
        gabor_features(counter)=sum(sum(sum(outMag,4)));
        counter=counter+1;
    end
    dlmwrite("./modified/gabor.data", gabor_features(1:counter-1,1), 'precision', 8);
    y = gabor_features(1:counter-1,:);
end
function y = edge_feature(image_folder)    
    images = dir(image_folder);
    edge_features = zeros(numel(images), 1);
    %Calculate edges and removes everything elese
    fudgeFactor = .5;    
    counter=1;
    for i=2:numel(images)
        %if is a directory, skip it
        if images(i).isdir
            continue
        end
        
        %ignore all but selected extensions
        [filepath, name, ext] = fileparts(images(i).name);
        if ~strcmp(ext, '.bmp') && ~strcmp(ext, '.jpg') && ~strcmp(ext, '.png') && ~strcmp(ext, '.JPG')
            continue
        end
        i_name=strcat(image_folder,"/", name, ext);
        [~, threshold] = edge(rgb2gray(imread(i_name)), 'sobel');
        edge_features(counter) = sum(sum(edge(rgb2gray(imread(i_name)),'sobel', threshold * fudgeFactor)));
        counter=counter+1;
    end
    dlmwrite("./modified/edge.data", edge_features(1:counter-1,1), 'precision', 8);
    y = edge_features(1:counter-1,:);
end

function y = labels(image_folder,label)
    files=dir(image_folder);
    counter=1;
    labels{numel(files)} = {};
    for i=2:numel(files)
        labels{counter} = label;
        counter = counter + 1;
    end
    y = labels(1:numel(files)-2);
end

function y = load_features_from_file(feature_file)
    y = dlmread(feature_file,',');
end