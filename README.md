# Ear-Deformity-Detection

## Goal
We optimize a pre-trained CNN model, GoogLeNet, to classify ears from 2D photographs
as normal or abnormal (deformity) and evaluate its performance by comparing it prediction with ground truth clinical diagnosis.

## Abstract
Ear molding therapy is a nonsurgical technique to correct certain congenital auricular deformities. While the advantages of nonsurgical treatments over otoplasty are well-described, few studies have assessed aesthetic outcomes. In this study, we compared assessments of outcomes of ear molding therapy for 283 ears by experienced healthcare providers and a previously developed deep learning CNN model. 2D photographs of ears were obtained as a standard of care in our onsite photography studio. Physician assistants (PAs) rated the photographs using a 5-point Likert scale ranging from 1(poor) to 5(excellent) and the CNN assessment was categorical, classifying each photo as either “normal” or “deformed”. On average, the PAs classified 75.6% of photographs as good to excellent outcomes (scores 4 and 5). Similarly, the CNN classified 75.3% of the photographs as normal. The inter-rater agreement between the PAs ranged between 72 and 81%, while there was a 69.6% agreement between the machine model and the inter-rater majority agreement between at least two PAs (i.e., when at least two PAs gave a simultaneous score < 4 or ≥ 4). This study shows that noninvasive ear molding therapy has excellent outcomes in general. In addition, it indicates that with further training and validation, machine learning techniques, like CNN, have the capability to accurately mimic provider assessment while removing the subjectivity of human evaluation making it a robust tool for ear deformity identification and outcome evaluation.

![image](https://github.com/user-attachments/assets/865686c2-6f35-4ca0-8bcf-f0baccc62353)

## Full paper
1. Hallac RR, Lee J, Pressler M, Seaward JR, Kane AA. Identifying Ear Abnormality from 2D Photographs Using Convolutional Neural Networks. Sci Rep. 2019 Dec 3;9(1):18198. doi: 10.1038/s41598-019-54779-7. PubMed PMID: 31796839; PubMed Central PMCID: PMC6890688.
2. Hallac RR, Jackson SA, Grant J, Fisher K, Scheiwe S, Wetz E, Perez J, Lee J, Chitta K, Seaward JR, Kane AA. Assessing outcomes of ear molding therapy by health care providers and convolutional neural network. Sci Rep. 2021 Sep 9;11(1):17875. doi: 10.1038/s41598-021-97310-7. PubMed PMID: 34504194; PubMed Central PMCID: PMC8429730.
