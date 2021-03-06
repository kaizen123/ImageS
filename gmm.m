function varargout = qmmf(varargin)
% QMMF MATLAB code for qmmf.fig
%      QMMF, by itself, creates a new QMMF or raises the existing
%      singleton*.
%
%      H = QMMF returns the handle to a new QMMF or the handle to
%      the existing singleton*.
%
%      QMMF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in QMMF.M with the given input arguments.
%
%      QMMF('Property','Value',...) creates a new QMMF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before qmmf_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to qmmf_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help qmmf

% Last Modified by GUIDE v2.5 26-Oct-2016 10:27:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @qmmf_OpeningFcn, ...
                   'gui_OutputFcn',  @qmmf_OutputFcn, ...
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


% --- Executes just before qmmf is made visible.
function qmmf_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to qmmf (see VARARGIN)

% Choose default command line output for qmmf
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
javaFrame = get(hObject,'JavaFrame');
javaFrame.setFigureIcon(javax.swing.ImageIcon('icon.JPG'));
% UIWAIT makes qmmf wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = qmmf_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
global coeh
temp=get(hObject,'String');
 temp=str2double(temp);
 if isnan(temp)==0
   coeh=temp;
 end
set(hObject,'String',num2str(coeh));

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


function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double
global ni
temp=get(hObject,'String');
 temp=str2double(temp);
 if isnan(temp)==0
   ni=temp;
 end
set(hObject,'String',num2str(ni));

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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Ic medias sgm menu nm colm type
set(handles.segment,'Enable','on')
[as,bs,~]=size(Ic);
axes(menu.mainax)
imshow(uint8(Ic))
h = imfreehand;
wait(h);
bw=createMask(h);
s=regionprops(bw, 'PixelIdxList' );
Ic=double(Ic);
nm=nm+1;
if strcmp(type,'rgb')
medias(1,nm)=mean(mean(Ic( s.PixelIdxList(:))));
medias(2,nm)=mean(mean(Ic( s.PixelIdxList(:)+(as*bs))));
medias(3,nm)=mean(mean(Ic( s.PixelIdxList(:)+(2*as*bs))));
sgm(1,1,nm)=std(double(Ic(s.PixelIdxList(:))));
sgm(2,2,nm)=std(double(Ic(s.PixelIdxList(:)+(as*bs))));
sgm(3,3,nm)=std(double(Ic(s.PixelIdxList(:)+(2*as*bs))));
colm(1:3,nm)=uint8([medias(1,nm),medias(2,nm),medias(3,nm)]);
else
medias(nm)=mean(mean(Ic( s.PixelIdxList(:))));
sgm(nm)=std((Ic(s.PixelIdxList(:))));     
end
Ic=uint8(Ic);
set(gmm,'Selected','on');

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Ic medias type sgm menu nm fore colm
set(handles.segment,'Enable','on')
[as,bs,~]=size(Ic);
axes(menu.mainax)
imshow(Ic)
h = imfreehand;
wait(h);
bw=createMask(h);
s=regionprops(bw, 'PixelIdxList' );
Ic=double(Ic);
nm=nm+1;
if strcmp(type,'rgb')
medias(1,nm)=mean(mean(Ic( s.PixelIdxList(:))));
medias(2,nm)=mean(mean(Ic( s.PixelIdxList(:)+(as*bs))));
medias(3,nm)=mean(mean(Ic( s.PixelIdxList(:)+(2*as*bs))));
sgm(1,1,nm)=std(double(Ic(s.PixelIdxList(:))));
sgm(2,2,nm)=std(double(Ic(s.PixelIdxList(:)+(as*bs))));
sgm(3,3,nm)=std(double(Ic(s.PixelIdxList(:)+(2*as*bs))));
colm(1:3,nm)=uint8([medias(1,nm),medias(2,nm),medias(3,nm)]);

else
medias(nm)=mean(mean(Ic( s.PixelIdxList(:))));
sgm(nm)=std((Ic(s.PixelIdxList(:)))); 
end
Ic=uint8(Ic);
set(gmm,'Selected','on');
fore=[fore 1];
% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Ic medias type sgm menu nm fore colm
set(handles.segment,'Enable','on')
[as,bs,~]=size(Ic);
axes(menu.mainax)
imshow(Ic)
h = imfreehand;
wait(h);
bw=createMask(h);
s=regionprops(bw, 'PixelIdxList' );
Ic=double(Ic);
nm=nm+1;
if strcmp(type,'rgb')
medias(1,nm)=mean(mean(Ic( s.PixelIdxList(:))));
medias(2,nm)=mean(mean(Ic( s.PixelIdxList(:)+(as*bs))));
medias(3,nm)=mean(mean(Ic( s.PixelIdxList(:)+(2*as*bs))));
sgm(1,1,nm)=std((Ic(s.PixelIdxList(:))));
sgm(2,2,nm)=std((Ic(s.PixelIdxList(:)+(as*bs))));
sgm(3,3,nm)=std((Ic(s.PixelIdxList(:)+(2*as*bs))));
colm(1:3,nm)=uint8([medias(1,nm),medias(2,nm),medias(3,nm)]);
else
medias(nm)=mean(mean(Ic( s.PixelIdxList(:))));
sgm(nm)=std((Ic(s.PixelIdxList(:))));    
end
Ic=uint8(Ic);
set(gmm,'Selected','on');
fore=[fore 0];

% --- Executes on button press in cleanmodels.
function cleanmodels_Callback(hObject, eventdata, handles)
% hObject    handle to cleanmodels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global  medias sgm nm fore back Ic menu
set(handles.segment,'Enable','off')
axes(menu.mainax)
Ic=uint8(Ic);
imshow(Ic)
medias=[];
sgm=[];
nm=0;
fore=[];
back=[];
set(gmm,'Selected','on');
% --- Executes on button press in segment.
function segment_Callback(hObject, eventdata, handles)
% hObject    handle to segment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Ic medias sgm coeh nm ni menu  mode_models fore  mask_models image_segmented type H
set(handles.text4,'Visible','on')
pause(0.1)
H = uicontrol('Style', 'PushButton', ...
    'String', 'Break', ...
    'Callback', 'delete(gcbo)');
set(H,'units', 'normalized','position',[0.736 0.059 0.212  0.086])

[nf,nc,~]=size(Ic);
h=fspecial('gaussian',[coeh,coeh]);
if mode_models==3
    if size(Ic,3)==3
        hsa=imhist(rgb2gray(Ic));
    else
        hsa=imhist(Ic);
    end
    hsa=double(hsa);
    hsa=[0 0 0 hsa(1) hsa(1) hsa(1) hsa(1) hsa' hsa(256) hsa(256) hsa(256) hsa(256) 0 0 0];
    [~,medias]=findpeaks(smooth(hsa,0.1,'loess'),'minpeakdistance',3);
    medias=unique(medias);
    sgm=ones(length(medias),1)*3;
    nm=length(medias);
    mask_models=false(nf,nc,nm);
    if strcmp(type,'rgb')
        [~, K, ~] = Segmenta(double(rgb2gray(Ic)), [medias,sgm], 5, 5);
        medias=zeros(3,nm);
        for i=1:nm
            mask_models(:,:,i)=im2bw(K(:,:,i));
        end
        for i=1:nm
            for uu=1:3
                temp=double(Ic(:,:,uu)).*double(mask_models(:,:,i));
                medias(uu,i)=mean(temp(temp>0));
            end
        end
        
        sgm=zeros(3,3,nm);
        sgm(1,1,:)=3;
        sgm(2,2,:)=3;
        sgm(3,3,:)=3;
    else
        sgm=ones(length(medias),1)*3;
    end
    
end
Ic=double(Ic);
if strcmp(type,'rgb')
    Kt = zeros(nf,nc,nm);
    K = zeros(nf*nc,1);
    iter=1;
    while ishandle(H)
        set(handles.text4,'String',['Iteration:' num2str(iter)])
        pause(0.01)
        if iter>ni
            delete(H)
            pause(1)
            break
        end
        for k=1:nm
            K =mvnpdf([Ic(1:nf*nc);Ic(nf*nc+1:2*nf*nc); Ic(2*nf*nc+1:3*nf*nc)]',medias(:,k)',sgm(:,:,k));
            Kt(1+((k-1)*nf*nc):nf*nc+((k-1)*nf*nc)) =K(1:nf*nc);
            
        end
        %%   Filtrado (promedio) de los modelos Gaussianos
        if coeh > 0
            Kt =imfilter(Kt,h);
        end
        %% compara el valor de cada pixel en los dos modelos y el mayor le asigna un 1 y al otro un 0
        mask_models=false(nf,nc,nm);
        for i=1:nf
            for j=1:nc
                [~,maximo]=max(Kt(i,j,:));
                mask_models(i,j,maximo)= 1;
            end
        end
        medias(:)=0;
        %% Encuentra las nuevas medias y varianzas
        eras=[];
        for k=1:nm
            l=find(mask_models(:,:,k) == 1);
            medias(1,k)=mean(Ic(l));
            medias(2,k)=mean(Ic(l+(nf*nc)));
            medias(3,k)=mean(Ic(l+(2*nf*nc)));
            sgm(:,:,k)= abs(cov([Ic(l), Ic(l+(nf*nc)),Ic(l+(2*nf*nc))]));
            if isnan(medias(1,k))
                eras=[eras k];
            end
        end
        medias(:,eras)=[];
        sgm(:,:,eras)=[];
        try
            fore(eras)=[];
        catch
        end
        nm=nm-length(eras);
        Kt(:,:,eras)=[];
        iter=iter+1;
    end
    
    if  (mode_models==2)
        mask_temp=false(nf,nc,2);
        for i=1:nm
            if fore(i)==1
                mask_temp(:,:,1)=or(mask_temp(:,:,1),mask_models(:,:,i));
            else
                mask_temp(:,:,2)=or(mask_temp(:,:,2),mask_models(:,:,i));
            end
        end
        mask_models=mask_temp;
    end
    image_segmented=uint8(zeros(nf,nc,3));
    for i=1:size(mask_models,3)
        l=find(mask_models(:,:,i)==1);
        image_segmented(l)=mean(mean(Ic(l)));
        image_segmented(l+(nf*nc))=mean(mean(Ic(l+(nf*nc))));
        image_segmented(l+(2*nf*nc))=mean(mean(Ic(l+(2*nf*nc))));
    end
else
    iter=1;
    K = zeros(nf,nc,nm);
    while ishandle(H)
        if iter>ni
            delete(H)
            pause(1)
            break
        end
        set(handles.text4,'String',['Iteration:' num2str(iter)])
        pause(0.01)
        
        for k=1:nm
            K(1+((k-1)*nf*nc):nf*nc+((k-1)*nf*nc)) =normpdf(Ic(:),medias(k),sgm(k)) ;
        end
        %%   Filtrado (promedio) de los dos modelos Gaussianos
        if coeh > 0
            %K(:,:,k) = medfilt2(K(:,:,k),[tf tf]);
            K =imfilter(K,h);
        end
        %% compara el valor de cada pixel en los dos modelos y el mayor le asigna un 1 y al otro un 0
        mask_models=false(nf,nc,nm);
        for i=1:nf
            for j=1:nc
                [~,maximo]=max(K(i,j,:));
                mask_models(i,j,maximo)= 1;
            end
        end
        medias(:)=0;
        %% Encuentra las nuevas medias y varianzas
        eras=[];
        for k=1:nm
            l=find(mask_models(:,:,k) == 1);
            medias(k)=mean(Ic(l));
            sgm(k)= std(Ic(l));
            if abs(sgm(k))<0.01;
                sgm(k)=0.01;
            end
            if isnan(medias(k))
                eras=[eras k];
            end
        end
        sgm=abs(sgm);
        medias(eras)=[];
        sgm(eras)=[];
        nm=nm-length(eras);
        K(:,:,eras)=[];
        iter=iter+1;
    end
    if  (mode_models==2)
        mask_temp=false(nf,nc,2);
        for i=1:nm
            if fore(i)==1
                mask_temp(:,:,1)=or(mask_temp(:,:,1),mask_models(:,:,i));
            else
                mask_temp(:,:,2)=or(mask_temp(:,:,2),mask_models(:,:,i));
            end
        end
        mask_models=mask_temp;
    end
end
image_segmented=uint8(zeros(nf,nc,3));
if strcmp(type,'rgb')
    for i=1:size(mask_models,3)
        l=find(mask_models(:,:,i)==1);
        image_segmented(l)=mean(mean(Ic(l)));
        image_segmented(l+(nf*nc))=mean(mean(Ic(l+(nf*nc))));
        image_segmented(l+(2*nf*nc))=mean(mean(Ic(l+(2*nf*nc))));
    end
else
    for i=1:size(mask_models,3)
        l=find(mask_models(:,:,i)==1);
    image_segmented(l)=mean(mean(Ic(l)));
    end
    image_segmented(:,:,2)=image_segmented(:,:,1);
    image_segmented(:,:,3)=image_segmented(:,:,1);
end
Ic=uint8(Ic);
set(handles.text4,'String','Iteration:')
set(handles.ok,'Enable','on')
axes(menu.mainax)
imshow(image_segmented)
set(handles.text4,'Visible','off')
set(gmm,'Selected','on');
% --- Executes on button press in ok.
function ok_Callback(hObject, eventdata, handles)
% hObject    handle to ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global resp 
resp='ok';
close(gmm)

% --- Executes on button press in cancel.
function cancel_Callback(hObject, eventdata, handles)
% hObject    handle to cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global resp 
resp='cancel';
close(gmm)

% --- Executes when selected object is changed in uipanel2.
function uipanel2_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel2 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
global mode_models nm
if (hObject==handles.radiobutton1)
    mode_models=1;
    set(handles.pushbutton1,'Enable','on')
    set(handles.pushbutton2,'Enable','off')
    set(handles.pushbutton3,'Enable','off')
     set(handles.segment,'Enable','off')
elseif (hObject==handles.radiobutton2)
    mode_models=2;
    set(handles.pushbutton1,'Enable','off')
    set(handles.pushbutton2,'Enable','on')
    set(handles.pushbutton3,'Enable','on')
    set(handles.segment,'Enable','off')
else
    mode_models=3;
    set(handles.pushbutton1,'Enable','off')
    set(handles.pushbutton2,'Enable','off')
    set(handles.pushbutton3,'Enable','off')
    set(handles.segment,'Enable','on')
end
nm=0;

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global br
br=1;
