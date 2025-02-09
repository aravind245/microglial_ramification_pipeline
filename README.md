Microglial Ramification Analysis
Author: [Dr Aravind Sivakumar]
Date: [10/1/2025]
Overview
This MATLAB script analyzes microglial morphology in .tif images to assess ramification index, a key feature of microglial activation. It extracts connected microglial structures and quantifies morphological complexity.

Workflow
Loads raw images from a specified directory.
Enhances microglial structures using filtering and morphological operations.
Skeletonizes the processed image to visualize microglial networks.
Computes the ramification index, which quantifies morphological complexity.
Requirements
MATLAB (Tested on R2022b and newer)
Image Processing Toolbox
Frangi Filter Toolbox (for microglial connectivity enhancement)

Folder structure:
BCAS_drug_microglia_analysis/
├── README.md                   # Project documentation
├── microglia_green.m           # Main MATLAB script
├── FrangiFilter3D.m            # Function for 3D Frangi vessel enhancement
├── Hessian2D.m                 # Function for Hessian-based 2D filtering
├── Hessian3D.m                 # Function for Hessian-based 3D filtering
├── eig2image.m                 # Supporting function for Hessian filtering
├── eig3volume.m                # Supporting function for 3D Hessian analysis
├──  results_counts.csv          # Ramification indices of processed images
├── results/                    # Directory containing generated processed images for retrospective verification 
│   ├── processed_image_1.tif   # Example processed image
│   ├── skeletal_network.tif    # Example skeletonized microglia network
│   └──    
├   ├── 9_micro1.tif            # Example input image 1
│   ├── 10_micro1.tif           # Example input image 2
│   ├── 21_micro1.tif           # Example input image 3
│   └── ...                     # Other `.tif` images in the dataset


Features
Microglial Connectivity Analysis:
Enhances microglial structures using Frangi filtering and morphological operations.
Skeletal Network Extraction:
Produces skeletonized networks to visualize microglial branching patterns.
Ramification Index Calculation:
Computes a quantitative index of microglial morphology.

Getting Started
Prerequisites
MATLAB (tested on R2022b or newer).
MATLAB Image Processing Toolbox.
Frangi Filter Toolbox (functions included in this repository).

Installation
Clone this repository:
bash
Copy
Edit
git clone [https://github.com/aravind245/microglial_ramification_pipeline.git]
cd BCAS_drug_microglia_analysis
Open MATLAB and set the working directory to the cloned folder.

Usage
1. Input Setup
Place your .tif images in a folder (e.g., other_images/).
Update the input_folder variable in microglia_green.m to point to this folder.
2. Running the Script
Open microglia_green.m in MATLAB.
Run the script:
matlab
Copy
Edit
microglia_green
The script will:
Process all .tif images in the specified folder.
Save results in the results/ directory.

Outputs
After running the script, you will get:

Processed Images:

connected_microglia_image.tif: Shows enhanced and connected microglial structures.
skeletal_network.tif: Displays skeletonized microglial networks.
Results File:

results_counts.csv: Summarizes:
Image filenames
Computed ramification indices.

Citation
If you use this repository in your research, please cite:

[Dr. Aravind Sivakumar]. (2025). BCAS Drug Microvessel Microglia Analysis. GitHub Repository. [https://github.com/yourusername/BCAS_drug_microglia_analysis](https://github.com/aravind245/microglial_ramification_pipeline)

License
This project is licensed under the GNU GENERAL PUBLIC LICENSE
                       Version 3, 29 June 2007 . See the LICENSE file for details.
