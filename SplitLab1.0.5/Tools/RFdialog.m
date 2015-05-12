function RFdialog

global config

mpos =get(0,'PointerLocation');
figpos = [mpos(1)-50 mpos(2)-50 200 300];
fig = figure('WindowStyle','modal','Position',figpos,'NumberTitle','off','Name','RF Parameter','Toolbar','None','menubar','none');

% pulse width
uicontrol('Parent',fig,'Units','pixel',...
    'Style','text',...
    'Position',[15 268 100 20],...
    'String', 'pulse width:',...
    'HorizontalAlignment','Left');

uicontrol('Parent',fig,'Units','pixel',...
    'Style','Edit',...
    'BackgroundColor','w',...
    'Position',[110 270 35 20],...
    'ToolTipString','Gaussian factor',...
    'String', config.f0,...
    'Callback', 'config.f0=str2num(get(gcbo,''String''));');

% Time before P:
uicontrol('Parent',fig,'Units','pixel',...
    'Style','text',...
    'Position',[15 238 100 20],...
    'String', 'Time before P:',...
    'HorizontalAlignment','Left');

uicontrol('Parent',fig,'Units','pixel',...
    'Style','Edit',...
    'BackgroundColor','w',...
    'Position',[110 240 35 20],...
    'ToolTipString','Time before P',...
    'String', config.extime_before,...
    'Callback', 'config.extime_before=str2num(get(gcbo,''String''));');

uicontrol('Parent',fig,'Units','pixel',...
    'Style','text',...
    'Position',[150 238 100 20],...
    'String', 'sec',...
    'HorizontalAlignment','Left');

% Time before P
uicontrol('Parent',fig,'Units','pixel',...
    'Style','text',...
    'Position',[15 208 100 20],...
    'String', 'Time before P:',...
    'HorizontalAlignment','Left');

uicontrol('Parent',fig,'Units','pixel',...
    'Style','Edit',...
    'BackgroundColor','w',...
    'Position',[110 210 35 20],...
    'ToolTipString','Time after P',...
    'String', config.extime_after,...
    'Callback', 'config.extime_after=str2num(get(gcbo,''String''));');

uicontrol('Parent',fig,'Units','pixel',...
    'Style','text',...
    'Position',[150 208 100 20],...
    'String', 'sec',...
    'HorizontalAlignment','Left');

%Plot Time axis after P:
uicontrol('Parent',fig,'Units','pixel',...
    'Style','text',...
    'Position',[15 178 100 20],...
    'String', 'Time axis after P:',...
    'HorizontalAlignment','Left');

uicontrol('Parent',fig,'Units','pixel',...
    'Style','Edit',...
    'BackgroundColor','w',...
    'Position',[110 180 35 20],...
    'ToolTipString','Plot Time axis after P',...
    'String', config.timeafterp,...
    'Callback', 'config.timeafterp=str2num(get(gcbo,''String''));');

uicontrol('Parent',fig,'Units','pixel',...
    'Style','text',...
    'Position',[150 178 100 20],...
    'String', 'sec',...
    'HorizontalAlignment','Left');

% RF format
uicontrol('Parent',fig,'Units','pixel',...
    'Style','text',...
    'Position',[15 148 100 20],...
    'String', 'RF format:',...
    'HorizontalAlignment','Left');

RF1 = uicontrol('Parent',fig ,'Units','pixel',...
    'Style','PopupMenu',...
    'BackgroundColor','w',...
    'Position',[90 150 100 20],...
    'String', {'*.sac','*.dat'},...
    'Value',config.rfformat,...
    'Callback','config.rfformat=get(gcbo,''Value'');if config.rfformat == 1;config.issac=1;else;config.issac=0;end;');

uicontrol('Parent',fig,'Units','pixel',...
    'Style','text',...
    'Position',[15 118 100 20],...
    'String', 'RF method:',...
    'HorizontalAlignment','Left');

RF2 = uicontrol('Parent',fig,'Units','pixel',...
    'Style','PopupMenu',...
    'BackgroundColor','w',...
    'Position',[90 120 100 20],...
    'String', {'iter','water'},...
    'Value',config.rfmethod,...
    'Callback','config.rfmethod=get(gcbo,''Value'');if config.rfmethod == 1;config.iter=1;else;config.iter=0;end;');

uicontrol('Parent',fig,'Units','pixel',...
    'Style','text',...
    'Position',[15 88 100 20],...
    'String', 'Noise gate:',...
    'HorizontalAlignment','Left');

RF3 = uicontrol('Parent',fig ,'Units','pixel',...
    'Style','Edit',...
    'BackgroundColor','w',...
    'Position',[110 90 35 20],...
    'ToolTipString','Noise gate',...
    'String', config.snrgate,...
    'Callback', 'config.snrgate=str2num(get(gcbo,''String''));');

uicontrol('Parent',fig,'Units','pixel',...
    'Style','text',...
    'Position',[150 88 100 20],...
    'String', 'dB',...
    'HorizontalAlignment','Left');

uicontrol('Units','pixel', 'Style','pushbutton','Parent',fig,...
    'Position',[150 10 45 25], 'String', 'OK',...
    'callback',' close(gcbf);')

waitfor(fig)