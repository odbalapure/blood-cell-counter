# Blood Cell Counter

### Description
A MATALAB application that uses digital image processing technique, capable of counting the Red Blood
Cells (RBCs), White Blood Cells (WBCs) and Platelets respectively from a colored image of a peripheral blood.

_**NOTE**: The application was developed to automate the manual cell counting process which are prone to human errors not to replace advanced machines like the CBC Analyzer._

### Working of the MATLAB application
**The cell couting involves 3 steps:** 
1. **Preprocessing**: This step removes noise from the image. A median filter was used as it is effective in removing salt and pepper noise.
   Red, Green and Blue channels are extracted from the input image of the peripheral blood smear. Filter is applied to each of these channels. Then all these channels are 
   concatenated that results into a noise free image with smoother edges of the objects present in the image. 
2. **Image Segmentation**: In this phase WBCs are counted. Morphological transformation are applied on binary images and unwanted small objects are removed.  
3. **Feature Extraction**: In this phase RBCs and platelets are counted. Both of them are counted using Circular Hough Transform. 
   1. RBC Count: Image is converted to gray scale, then to a matrix and if the value of pixels is less than 100, then those pixels are ignored. And using CHT the RBCs are               counted.
   2. Platelet Count: To count platelets we need to adjust the radius ratio to 1:2 and the CHT plots them and display their count. 
   
# System Architecture
![Slide9](https://user-images.githubusercontent.com/83666636/120933429-c4829700-c717-11eb-98fc-2e9ecfc972eb.jpg)

# WBC Count
![Slide12](https://user-images.githubusercontent.com/83666636/120933612-889c0180-c718-11eb-977c-80f5587240d8.jpg)

# RBC Count
![Slide16](https://user-images.githubusercontent.com/83666636/120933621-90f43c80-c718-11eb-8f21-c21fc10fa37c.jpg)

# Platelet Count
![Slide18](https://user-images.githubusercontent.com/83666636/120933635-9c476800-c718-11eb-9591-99d489b4fec8.jpg)
