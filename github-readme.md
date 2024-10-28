# Inductor_ImageClassification_detectron2_Keysight

This project utilizes the Detectron2 library from Facebook AI Research for object detection tasks. The notebook includes steps for setting up the environment, loading data, training a model, and evaluating its performance.

## Installation

To ensure all dependencies are met, follow these steps:

1. **Clone the repository**:
```bash
git clone https://github.com/nav47neet/Inductor_ImageClassification_detectron2_Keysight.git
```

2. **Install Dependencies**:
```bash
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
pip install 'git+https://github.com/facebookresearch/detectron2.git'
pip install labelme jsonmerg
```

## Project Structure

```
Inductor_ImageClassification_detectron2_Keysight/
├── Keysight_assignment2.ipynb          # Main notebook file
├── train/                              # Training data directory
├── model.pth                           # Trained model weights
└── README.md                           # Project documentation
```

## Key Components

### 1. Dataset

We manually annotated the component coordinates using labelme since they couldn't be extracted directly from KiCad software. This generated a dataset suitable for training.

<div align="center">
  <img src="https://github.com/user-attachments/assets/ada1ed50-ead4-4cfa-a3ec-ae5d4cf22b1f" width="300" height="300" alt="Annotation Example 1">
  <img src="https://github.com/user-attachments/assets/64e6ce93-f5a1-4321-9360-5b3a3eeafd1e" width="300" height="300" alt="Annotation Example 2">
</div>

These annotations were used to generate coordinates in JSON format, which along with the images, were used to train our model.

To help the model differentiate between inductors and similar shapes, we also included annotated doughnut images in the training set:

<div align="center">
  <img src="https://github.com/user-attachments/assets/a6bdb070-5dac-43ea-80e7-330c9430ab1d" width="300" height="300" alt="Doughnut Example 1">
  <img src="https://github.com/user-attachments/assets/95883884-0287-4b01-87b7-7934db481c33" width="300" height="300" alt="Doughnut Example 2">
</div>

### 2. Model

#### Faster R-CNN Model

Faster R-CNN is a state-of-the-art object detection framework that combines a Region Proposal Network (RPN) with a Fast R-CNN detector, allowing for efficient and accurate object detection.

#### Key Features:

- **Two-Stage Detection**: 
  - First stage: RPN generates region proposals
  - Second stage: Detection network classifies and refines these proposals

- **Backbone Network**: 
  - Utilizes ResNet with Feature Pyramid Networks (FPN)
  - Enables robust feature extraction at multiple scales

- **Pre-trained Weights**: 
  - Trained on the COCO dataset
  - Provides strong initialization for custom tasks

#### Applications:

Faster R-CNN is widely used in various fields, including:
- Autonomous driving
- Video surveillance
- Robotics

This makes it ideal for detecting objects like **Inductor** and **Donut** in this project.
