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
