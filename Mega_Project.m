function varargout = Mega_Project(varargin)
% MEGA_PROJECT MATLAB code for Mega_Project.fig
%      MEGA_PROJECT, by itself, creates a new MEGA_PROJECT or raises the existing
%      singleton*.
%
%      H = MEGA_PROJECT returns the handle to a new MEGA_PROJECT or the handle to
%      the existing singleton*.
%
%      MEGA_PROJECT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MEGA_PROJECT.M with the given input arguments.
%
%      MEGA_PROJECT('Property','Value',...) creates a new MEGA_PROJECT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Mega_Project_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Mega_Project_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Mega_Project

% Last Modified by GUIDE v2.5 08-Mar-2019 20:09:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Mega_Project_OpeningFcn, ...
                   'gui_OutputFcn',  @Mega_Project_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Mega_Project is made visible.
function Mega_Project_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Mega_Project (see VARARGIN)

% Choose default command line output for Mega_Project
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Mega_Project wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Mega_Project_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global filename
global pathname
global name
global image
global pathstr

[filename,pathname]=uigetfile('*.jpg;*.gif;*.tif;*.bmp;*.png','Select an image');
[pathstr, name] = fileparts(filename);
image=imread([pathname filename]);

%image = imresize(image,[1000,1000]);

axes(handles.axes1);
imshow(image);
title('Original Image','color','black');

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image  

rim=image(:,:,1);
gim=image(:,:,2);
bim=image(:,:,3);

rf=medfilt2(rim,[1 1]);
gf=medfilt2(gim,[1 1]);
bf=medfilt2(bim,[1 1]);

image=cat(3,rf,gf,bf);

%image = imresize(image,[1000,1000]);

axes(handles.axes1);
imshow(image); hold on;
title('Preprocessed Image','color','black');


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image
global BW2

bPlane = image(:,:,3)  - 0.5*(image(:,:,1)) - 0.5*(image(:,:,2));

BW = bPlane > 50;

BW2 = bwareaopen(BW, 100);

axes(handles.axes2);
imshow(BW2);
title('WBC Detection','color','black');

figure, imshow(image); hold on
title('WBC Detection','color','black');
himage = imshow(BW2);
set(himage, 'AlphaData', 0.5);

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global BW2
global L

[L,Num] = bwlabel(BW2);

set(handles.edit1,'string',(Num));

%{
for i=1:Num
imshow(L==i);
pause(1)
end
%}

z = Num * 2000;

if(z>=4000 && z<=11000)
    x = 'Count is Normal';
elseif(z==0)
    z='7000';
    x ='Count is Normal';
elseif(z<4000)
    x = 'Risk of Yellow Fever, Malaria, ';
elseif(z>11000)
    x = 'Risk of Infection, Chronic Obstructive Pulmonary Disease(Smoking), Leukemia';
end 

set(handles.edit2,'string',(z));

set(handles.edit3,'string',(x));


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image

gray_image = rgb2gray(image);

[size1,size2]=size(gray_image);
for i=1:size1
   for j=1:size2
      if gray_image(i,j)<100
          gray_image(i,j)=255;
      end
   end
end

im1=im2bw(gray_image,graythresh(gray_image));

figure,imshow(im1);hold on;
title('RBC Count');

%imfindcircle with CHT
[centers, radii, metric] = imfindcircles(im1,[10 20],'ObjectPolarity','dark','Sensitivity',0.82,'Method','twostage'); 
h = viscircles(centers,radii,'EdgeColor','b');
[m,n]=size(centers);


axes(handles.axes3);
imshow(im1);
title('Thresholded Image','color','black');

z = m * 7500;

if(z>=3500000 && z<=5500000)
    x = 'Count is Normal';
elseif(z<3500000)
    x = 'Risk of Thrombocytopenia, Dehydration, Plumonary Fibrosis!';
elseif(z>5500000)
    x='Risk of Polycythemia, Hypoxia, Carbon Mono- oxide Exposure(Smoking)';
end

set(handles.edit4,'string',(m));%per film

set(handles.edit5,'string',(z));%per CMM

set(handles.edit6,'string',(x));%Risk

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image

gray_image = rgb2gray(image);

[size1,size2]=size(gray_image);
for i=1:size1
   for j=1:size2
      if gray_image(i,j)<5
          gray_image(i,j)=255;
      end
   end
end

im1=im2bw(gray_image,graythresh(gray_image));

%imshowpair(image,im1);

figure;imshow(im1);title('Platelet Count');hold on;

[centers, radii, metric] = imfindcircles(im1,[1 2],'ObjectPolarity','dark','Sensitivity',0.82,'Method','twostage'); 
h = viscircles(centers,radii,'EdgeColor','g');
[m,n]=size(centers);

z = m * 15000;

if(z>=150000 && z<=450000)
    x = 'Count is Normal';
elseif(z<150000)
    x = 'Thrombocytopenia, Anemia, Viral Infection(Hepatisis C/ HIV)';
elseif(z>450000)
    x = 'Risk of Infection, Iron Defeciency, Inflammatory Conditions, Thrombocytosis';
elseif(z<100000)
    x='Risk of Thrombocytopenia';
end 

set(handles.edit7,'string',(m));

set(handles.edit8,'string',(z));

set(handles.edit9,'string',(x));

function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close all;
