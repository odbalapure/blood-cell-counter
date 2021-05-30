A MATALAB application that uses digital image processing technique, capable of counting the Red Blood
Cells (RBCs), White Blood Cells (WBCs) and Platelets respectively from a colored image of a peripheral blood.

NOTE: The application was developed to automate the manual cell counting process which are prone to human errors not advanced machines like CBC Analyzers. 

System Architecture



The cell couting involves 3 steps: 
1. Preprocessing: This step removes noise from the image. A median filter was used as it is effective in removing salt and pepper noise.
   Red, Green and Blue channels are extracted from the input image of the peripheral blood smear. Filter is applied to each of these channels. Then all these channels are 
   concatenated that results into a noise free image with smoother edges of the objects present in the image. 
2. Image Segmentation: In this phase WBCs are counted. Morphological transformation are applied on binary images and unwanted small objects are removed.  
3. Feature Extraction: In this phase RBCs and platelets are counted. 

   
