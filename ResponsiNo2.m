function varargout = ResponsiNo2(varargin)
% RESPONSINO2 MATLAB code for ResponsiNo2.fig
%      RESPONSINO2, by itself, creates a new RESPONSINO2 or raises the existing
%      singleton*.
%
%      H = RESPONSINO2 returns the handle to a new RESPONSINO2 or the handle to
%      the existing singleton*.
%
%      RESPONSINO2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RESPONSINO2.M with the given input arguments.
%
%      RESPONSINO2('Property','Value',...) creates a new RESPONSINO2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ResponsiNo2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ResponsiNo2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ResponsiNo2

% Last Modified by GUIDE v2.5 26-Jun-2021 08:00:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ResponsiNo2_OpeningFcn, ...
                   'gui_OutputFcn',  @ResponsiNo2_OutputFcn, ...
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


% --- Executes just before ResponsiNo2 is made visible.
function ResponsiNo2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ResponsiNo2 (see VARARGIN)

% Choose default command line output for ResponsiNo2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ResponsiNo2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ResponsiNo2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function uitable1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
data = readmatrix('DATA RUMAH.csv');
data = [data(:,1:1) data(:,3:3) data(:,4:4) data(:,5:5) data(:,6:6) data(:,7:7) data(:,8:8)];
uitable1 = findobj(0, 'tag', 'uitable1');
set(uitable1,'Data',data); 



% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
opts = detectImportOptions('DATA RUMAH.csv');
opts.SelectedVariableNames = {'NO','HARGA','LB','LT','KT','KM','GRS'};
data = readmatrix('DATA RUMAH.csv',opts);

x=[data(:,2:7)];%input data berdasarkan kriteria
k=[0,1,1,1,1,1];%nilai atribut, dimana 0= atribut biaya &1= atribut keuntungan
w=[0.3,0.2,0.23,0.1,0.07,0.1];% bobot untuk masing-masing kriteria

%tahapan 1. normalisasi matriks
[m n]=size (x); %matriks m x n dengan ukuran sebanyak variabel x (input)
R=zeros (m,n); %membuat matriks R, yang merupakan matriks kosong
Y=zeros (m,n); %membuat matriks Y, yang merupakan titik kosong
for j=1:n,
 if k(j)==1, %statement untuk kriteria dengan atribut keuntungan
  R(:,j)=x(:,j)./max(x(:,j));
 else
  R(:,j)=min(x(:,j))./x(:,j);
 end;
end;

%disp ('matriks yang sudah ternomalisasi R=')
%disp (R)
%tahapan kedua, proses perangkingan
for i=1:m,
 V(i)= sum(w.*R(i,:));
end;

%pengurutan array dari besar ke kecil
[ Y, IND ] = sort( V(:),'descend');
%pencarian Index
[ pr, xx ] = ind2sub( size(V), IND(1:20) );
dataset = readtable('DATA RUMAH.csv');
peringkat = [dataset( xx(1):xx(1) , 1:8)]
for ii = 2 : 20
    peringkat = [peringkat;dataset( xx(ii):xx(ii) , 1:8)];
end

%menampilkan hasil 20 terbesar ke dalam tabel
peringkat = [peringkat(:,1:1) peringkat(:,3:3) peringkat(:,4:4) peringkat(:,5:5) peringkat(:,6:6) peringkat(:,7:7) peringkat(:,8:8)];
peringkat = table2array(peringkat);
uitable2 = findobj(0, 'tag', 'uitable2');
set(uitable2,'Data',peringkat); 

% --- Executes during object creation, after setting all properties.
function uitable2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uitable2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
