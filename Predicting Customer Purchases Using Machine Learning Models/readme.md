# Predicting Customer Purchases Using Machine Learning Models

## Overview

This project aims to predict whether a customer will make a purchase based on various product and pricing data. By preprocessing the dataset, engineering meaningful features, and applying different machine learning models, we identify the best-performing model for accurate purchase prediction.

## Research Objectives

-   Preprocess pricing and currency data for consistency.
-   Engineer features such as discount percentage, weighted ratings, and price categorization.
-   Train and evaluate multiple classification models to determine the most effective predictor.
-   Optimize model performance using hyperparameter tuning.

## Dataset

-   **Source:** Internal dataset of product listings and customer behavior.
-   **Features Used:** Pricing details, discount percentages, ratings, and categorical variables.
-   **Processed File:** `prediction.csv` (contains cleaned and transformed data).

## Methodology

1. **Data Preprocessing**:

    - Extracted and standardized currency values.
    - Converted prices to USD for consistency.
    - Handled missing values by imputing medians and default categories.

2. **Feature Engineering**:

    - Calculated discount percentage and absolute discount amount.
    - Created a weighted rating metric considering both rating value and number of reviews.
    - Categorized products into ‘Low’, ‘Medium’, and ‘High’ price ranges.

3. **Model Selection**:

    - Evaluated multiple machine learning models:
        - Naïve Bayes
        - Logistic Regression
        - Perceptron
        - Ridge Classifier
        - Linear & Quadratic Discriminant Analysis (LDA & QDA)
        - Decision Tree
        - Random Forest
        - K-Nearest Neighbors (KNN)
    - Automated model testing for efficiency.

4. **Hyperparameter Tuning**:

    - Applied **GridSearchCV** for Decision Tree and Random Forest.
    - Tuned `n_estimators`, `max_depth`, `min_samples_split`, and `class_weight` for better accuracy.

5. **Evaluation Metrics**:
    - **Accuracy:** Overall correctness of predictions.
    - **Precision:** Correctly predicted purchases out of all predicted purchases.
    - **Recall:** Correctly predicted purchases out of all actual purchases.
    - **F1 Score:** Harmonic mean of precision and recall.

## Key Findings

-   **Random Forest** emerged as the best model with:
    -   **Accuracy:** 83.64%
    -   **Precision:** 55.67%
    -   **Recall:** 77.10%
    -   **F1 Score:** 0.6465
-   **Tree-based models** (Decision Tree & Random Forest) significantly outperformed simpler models like Naïve Bayes.
-   **Random Forest's ensemble approach** improved accuracy and reduced overfitting compared to single Decision Trees.

## Files in This Repository

-   `Dashaputra_A3.ipynb` – Jupyter Notebook containing data preprocessing, model training, and evaluation.
-   `Dashaputra_A3.docx` – Research report summarizing methodology and findings.
-   `prediction.csv` – Processed dataset used for training models.
