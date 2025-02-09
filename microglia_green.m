% Microglial Ramification Analysis Pipeline
% Author: [Dr. Aravind Sivakumar]
% Date: [10/1/2025]
% Description:
% This script processes images of microglia to quantify their ramification.
% It loads .tif images, enhances structures, extracts skeletonized networks, 
% and computes a ramification index.

clc;           % Clear command window
clear all;     % Clear all variables
close all;     % Close all figures

% Define the input folder containing images
input_folder = 'C:\Users\User\OneDrive\Desktop\BCAS drug microvessel microglia';

% Define output directory for storing results
output_dir = 'C:\Users\User\OneDrive\Desktop\BCAS drug microvessel microglia\results';
mkdir(output_dir); % Create results directory if it does not exist

% Read all .tif image files in the input folder
image_files = dir(fullfile(input_folder, '*.tif')); 
num_images = length(image_files);

% Extract filenames of all images
filenames = {image_files.name}';

% Initialize results storage
analyzeresults = struct();

% Process each image in the folder
for count = 1:num_images
    filename = filenames{count}; 
    analyzeresults(count).filename = filename; 

    % Extract filename without extension
    filename_no_ext = filename(1:end-4);
    
    % Create subfolder for each image’s processed results
    img_output_dir = fullfile(output_dir, filename_no_ext);
    mkdir(img_output_dir);

    % Read image
    Imgraw = imread(fullfile(input_folder, filename));

    % Display raw image
    figure;
    imshow(Imgraw);
    raw_image_path = fullfile(img_output_dir, 'raw_microglia_image.tif');
    save_figure(raw_image_path);

    % Process the image to enhance microglia connectivity
    Iprocessed = mgconnectivity(Imgraw, img_output_dir);

    % Compute ramification index
    analyzeresults(count).ramification_index = mgquant(Iprocessed, img_output_dir);
    
    % Close all figures after processing to free memory
    close all;
end

% Convert results to table and save as CSV
results_table = struct2table(analyzeresults);
writetable(results_table, 'results_counts.csv');

% ------------------ Function Definitions ------------------ %

% Function to enhance microglial connectivity
function Iclose = mgconnectivity(Imgraw, img_output_dir)
    % Extract green channel (assumed to be microglia)
    Imgraw1 = Imgraw(:,:,2);
    
    % Apply median filtering to reduce noise
    Imgraw1 = medfilt2(Imgraw1);

    % Invert the image for Frangi filtering
    Img_inv = double(255 - Imgraw1);

    % Apply Frangi vessel enhancement filter
    Img_frangi = FrangiFilter2D(Img_inv);

    % Threshold the image to obtain a binary mask
    Ibmg = Img_frangi > 0;

    % Perform morphological closing to enhance structures
    se1 = strel('disk', 30, 8);
    Iclose = imclose(Ibmg, se1);

    % Display and save enhanced image
    figure;
    imshowpair(Iclose, Imgraw1);
    enhanced_image_path = fullfile(img_output_dir, 'connected_microglia_image.tif');
    save_figure(enhanced_image_path);

    % Skeletonize the connected components
    Ithin = bwmorph(Iclose, 'thin', Inf);

    % Display and save skeletal network image
    figure;
    imshowpair(Ithin, Imgraw1, 'Montage');
    skeletal_image_path = fullfile(img_output_dir, 'skeletal_network.tif');
    save_figure(skeletal_image_path);
end

% Function to compute the ramification index of microglia
function ram_index = mgquant(Iclose, img_output_dir)
    % Identify boundaries of segmented structures
    [boundaries, labeled_img] = bwboundaries(Iclose, 'noholes');

    % Extract region properties: Area and Perimeter
    stats = regionprops(labeled_img, 'Area', 'Perimeter');

    % Compute total area and perimeter of all structures
    total_area = sum([stats.Area]);
    total_perimeter = sum([stats.Perimeter]);

    % Compute ramification index
    % Ramification Index = (Total Perimeter / Total Area) / (2 * (? / Total Area)^0.5)
    ram_index = (total_perimeter / total_area) / (2 * (pi / total_area)^0.5);
end

% Utility function to save figures
function save_figure(filepath)
    % Capture the current figure
    frame = getframe(gcf);
    img_data = frame.cdata;
    
    % Save the image
    imwrite(img_data, filepath);
end
