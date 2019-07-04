function varargout = MF(varargin)
% MF MATLAB code for MF.fig
%      MF, by itself, creates a new MF or raises the existing
%      singleton*.
%
%      H = MF returns the handle to a new MF or the handle to
%      the existing singleton*.
%
%      MF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MF.M with the given input arguments.
%
%      MF('Property','Value',...) creates a new MF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MF_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MF_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MF

% Last Modified by GUIDE v2.5 03-Jul-2019 09:48:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @MF_OpeningFcn, ...
    'gui_OutputFcn',  @MF_OutputFcn, ...
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


% --- Executes just before MF is made visible.
function MF_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MF (see VARARGIN)

% Choose default command line output for MF
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MF wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MF_OutputFcn(hObject, eventdata, handles)
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

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
cla reset;
axes(handles.axes2);
cla reset;
axes(handles.axes3);
cla reset;
axes(handles.axes4);
cla reset;
set(handles.meantext1, 'string', '');
set(handles.meantext2, 'string', '');
set(handles.stdtext1, 'string', '');
set(handles.stdtext2, 'string', '');

path = get(handles.edit1, 'string');
[handles.t, handles.send_signal] = textread(path);
handles.FS = 1 / (handles.t(2) - handles.t(1)); % Sample frequency
handles.send_signal_mean = mean(handles.send_signal);
handles.send_signal_std = std(handles.send_signal);
handles.send_signal_autocorr = xcorr(handles.send_signal);
[handles.send_signal_PSD, handles.f_send_PSD_shift] = t2f(handles.send_signal_autocorr, handles.FS);

handles.receive_signal = MatchedFilter(handles.send_signal);
handles.receive_signal_mean = mean(handles.receive_signal);
handles.receive_signal_Std = std(handles.receive_signal);
handles.receive_signal_autocorr = xcorr(handles.receive_signal);
[handles.receive_signal_PSD, handles.f_receive_PSD_shift] = t2f(handles.receive_signal_autocorr, handles.FS);

guidata(hObject, handles);

set(handles.meantext1, 'string', ['均值 = ' num2str(handles.send_signal_mean)]);
set(handles.meantext2, 'string', ['均值 = ' num2str(handles.receive_signal_mean)]);
set(handles.stdtext1, 'string', ['方差 = ' num2str(handles.send_signal_std)]);
set(handles.stdtext2, 'string', ['方差 = ' num2str(handles.receive_signal_mean)]);

axes(handles.axes1);
plot(handles.send_signal);
title('输入信号');
xlabel('t\s');
ylabel('A');

axes(handles.axes2);
plot(2 * handles.t, handles.receive_signal(1:2:end));
title('滤波后的信号');
xlabel('t\s');
ylabel('A');

% catch FileNotFound
%     set(handles.edit1, 'string', '路径错误');
% end




% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes3);
plot(handles.t, handles.send_signal_autocorr(1:2:end));
title('输入信号自相关');
xlabel('t\s');
ylabel('A');

axes(handles.axes4);
plot(2 * handles.t, handles.receive_signal_autocorr(1:4:end));
title('滤波后的信号自相关');
xlabel('t\s');
ylabel('Amplitude');


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.axes3);
plot(handles.f_send_PSD_shift, abs(handles.send_signal_PSD));
title('输入信号功率谱');
xlabel('f');
ylabel('A');
set(gca, 'XLim', [-2, 2]);

axes(handles.axes4);
plot(handles.f_receive_PSD_shift, abs(handles.receive_signal_PSD));
title('滤波后的信号功率谱');
xlabel('f');
ylabel('A');
set(gca, 'XLim', [-2, 2]);
