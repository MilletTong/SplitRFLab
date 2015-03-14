%% RF process--station plotting
h.panel(98) = uipanel('Units','pixel','Title','station plotting',...
    'FontSize',10,'Position',[133 245 425 160], 'BackgroundColor', [224   223   227]/255);


% field descriptions text
uicontrol('Parent',h.panel(98),'Units','pixel',...
    'Style','text',...
    'Position',[10 120 150 20],...
    'String', 'RF Data Path:',...
    'HorizontalAlignment','Left');

uicontrol('Parent',h.panel(98),'Units','pixel',...
    'Style','text',...
    'Position',[10 90 150 20],...
    'String', 'Imaging Out Path:',...
    'HorizontalAlignment','Left');

uicontrol('Parent',h.panel(98),'Units','pixel',...
    'Style','text',...
    'Position',[10 60 150 20],...
    'String', 'Cut out Data Out Path:',...
    'HorizontalAlignment','Left');

uicontrol('Parent',h.panel(98),'Units','pixel',...
    'Style','text',...
    'Position',[10 30 70 20],...
    'String', 'pulse width:',...
    'HorizontalAlignment','Left');

uicontrol('Parent',h.panel(98),'Units','pixel',...
    'Style','text',...
    'Position',[10 2 120 20],...
    'String', 'Plot Time axis after P:',...
    'HorizontalAlignment','Left');

uicontrol('Parent',h.panel(98),'Units','pixel',...
    'Style','text',...
    'Position',[180 30 80 20],...
    'String', 'Time before P:',...
    'HorizontalAlignment','Left');

uicontrol('Parent',h.panel(98),'Units','pixel',...
    'Style','text',...
    'Position',[180 2 80 20],...
    'String', 'Time after P:',...
    'HorizontalAlignment','Left');
%% path edit
h.out(1)=uicontrol('Parent',h.panel(98),'Units','pixel',...
    'Style','Edit',...
    'BackgroundColor','w',...
    'Position',[130 125 170 20],...
    'ToolTipString','RF output directory',...
    'String', config.RFdatapath,...
    'Callback', 'config.RFdatapath=get(gcbo,''String'');');

h.out(2)=uicontrol('Parent',h.panel(98),'Units','pixel',...
    'Style','Edit',...
    'BackgroundColor','w',...
    'Position',[130 95 170 20],...
    'ToolTipString','Image output directory',...
    'String', config.imout,...
    'Callback', 'config.imout=get(gcbo,''String'');');

h.out(3)=uicontrol('Parent',h.panel(98),'Units','pixel',...
    'Style','Edit',...
    'BackgroundColor','w',...
    'Position',[130 65 170 20],...
    'ToolTipString','Cut data output directory',...
    'String', config.cutdir,...
    'Callback', 'config.cutdir=get(gcbo,''String'');');

h.out(7)=uicontrol('Parent',h.panel(98),'Units','pixel',...
    'Style','Edit',...
    'BackgroundColor','w',...
    'Position',[130 35 35 20],...
    'ToolTipString','Gaussian factor',...
    'String', config.f0,...
    'Callback', 'config.f0=str2num(get(gcbo,''String''));');

h.out(8)=uicontrol('Parent',h.panel(98),'Units','pixel',...
    'Style','Edit',...
    'BackgroundColor','w',...
    'Position',[130 5 35 20],...
    'ToolTipString','Output directory',...
    'String', config.timeafterp,...
    'Callback', 'config.timeafterp=str2num(get(gcbo,''String''));');

h.out(9)=uicontrol('Parent',h.panel(98),'Units','pixel',...
    'Style','Edit',...
    'BackgroundColor','w',...
    'Position',[260 35 35 20],...
    'ToolTipString','Output directory',...
    'String', config.extime_before,...
    'Callback', 'config.extime_before=str2num(get(gcbo,''String''));');

h.out(10)=uicontrol('Parent',h.panel(98),'Units','pixel',...
    'Style','Edit',...
    'BackgroundColor','w',...
    'Position',[260 5 35 20],...
    'ToolTipString','Output directory',...
    'String', config.extime_after,...
    'Callback', 'config.extime_after=str2num(get(gcbo,''String''));');

%% PopupMenu
uicontrol('Parent',h.panel(98),'Units','pixel',...
    'Style','text',...
    'Position',[305 30 50 20],...
    'String', 'RF format:',...
    'HorizontalAlignment','Left');


uicontrol('Parent',h.panel(98),'Units','pixel',...
    'Style','PopupMenu',...
    'BackgroundColor','w',...
    'Position',[360 35 65 20],...
    'String', {'*.sac','*.dat'},...
    'Value',config.rfformat,...
    'Callback','config.rfformat=get(gcbo,''Value'');if config.rfformat == 1;config.issac=1;else;config.issac=0;end;');


uicontrol('Parent',h.panel(98),'Units','pixel',...
    'Style','text',...
    'Position',[305 2 60 20],...
    'String', 'RF method:',...
    'HorizontalAlignment','Left');

uicontrol('Parent',h.panel(98),'Units','pixel',...
    'Style','PopupMenu',...
    'BackgroundColor','w',...
    'Position',[360 5 65 20],...
    'String', {'iter','water'},...
    'Value',config.rfmethod,...
    'Callback','config.rfmethod=get(gcbo,''Value'');if config.rfmethod == 1;config.iter=1;else;config.iter=0;end;');
%% buttons

h.out(4) = uicontrol('Parent',h.panel(98),'Units','pixel',...
    'Style','Pushbutton',...
    'Position',[310 125 25 20],...
    'cdata', icon.folder,...
    'ToolTipString','Browse',...
    'Userdata',h.out(1),...
    'Callback','tmp2=uigetdir(config.RFdatapath);if isstr(tmp2), config.RFdatapath=tmp2;set(get(gcbo,''Userdata''), ''String'',config.RFdatapath);end,clear tmp*');
h.out(5) = uicontrol('Parent',h.panel(98),'Units','pixel',...
    'Style','Pushbutton',...
    'Position',[310 95 25 20],...
    'cdata', icon.folder,...
    'ToolTipString','Browse',...
    'Userdata',h.out(2),...
    'Callback','tmp2=uigetdir(config.imout);if isstr(tmp2), config.imout=tmp2;set(get(gcbo,''Userdata''), ''String'',config.imout);end,clear tmp*');
h.out(6) = uicontrol('Parent',h.panel(98),'Units','pixel',...
    'Style','Pushbutton',...
    'Position',[310 65 25 20],...
    'cdata', icon.folder,...
    'ToolTipString','Browse',...
    'Userdata',h.out(3),...
    'Callback','tmp2=uigetdir(config.cutdir);if isstr(tmp2), config.cutdir=tmp2;set(get(gcbo,''Userdata''), ''String'',config.cutdir);end,clear tmp*');

uicontrol('Parent',h.panel(98),'Units','pixel',...
    'Style','Pushbutton',...
    'Position',[345 120 65 25],...
    'String', 'Plot RT',...
    'Callback', 'if config.issac; plotRT_sac;else;plotRT(config.RFdatapath,config.imout,config.stnname,config.timeafterp);end');





%% Radio buttons
% uicontrol('Parent',h.panel(98),'Units'  ,'pixel',...
%     'Style'    ,'radiobutton',...
%     'Value'    ,~config.issac,...
%     'Position' ,[342 90 70 13],...
%     'String'   ,'Use dat',...
%     'Tag','usedat',...
%     'Callback' ,'config.issac=~get(gcbo,''Value''); set(findobj(''Tag'',''usesac'') ,''Value'',0)');
% 
% uicontrol('Parent',h.panel(98),'Units'  ,'pixel',...
%     'Style'    ,'radiobutton',...
%     'Value'    ,config.issac,...
%     'Position' ,[342 65 70 13],...   
%     'Tag','usesac',...
%     'String'   ,'Use sac',...
%     'Callback' ,'config.issac=get(gcbo,''Value''); set(findobj(''Tag'',''usedat'') ,''Value'',0)');

%% H-k stacking
h.panel(97) = uipanel('Units','pixel','Title','H-k stacking',...
    'FontSize',10,'Position',[133 10 425 230], 'BackgroundColor', [224   223   227]/255);
% set H para
uicontrol('Parent',h.panel(97),'Units','pixel',...
    'Style','text',...
    'Position',[10 190 150 20],...
    'String', 'Moho depth (H) from:',...
    'HorizontalAlignment','Left');

h.hk(1)=uicontrol('Parent',h.panel(97),'Units','pixel',...
    'Style','Edit',...
    'BackgroundColor','w',...
    'Position',[115 195 35 20],...
    'String', config.h1,...
    'Callback', 'config.h1=str2num(get(gcbo,''String''));');

uicontrol('Parent',h.panel(97),'Units','pixel',...
    'Style','text',...
    'Position',[160 190 20 20],...
    'String', 'to',...
    'HorizontalAlignment','Left');

h.hk(2)=uicontrol('Parent',h.panel(97),'Units','pixel',...
    'Style','Edit',...
    'BackgroundColor','w',...
    'Position',[180 195 35 20],...
    'String', config.h2,...
    'Callback', 'config.h2=str2num(get(gcbo,''String''));');

% set k para
uicontrol('Parent',h.panel(97),'Units','pixel',...
    'Style','text',...
    'Position',[10 160 150 20],...
    'String', 'Kappa (k) from:',...
    'HorizontalAlignment','Left');

h.hk(3)=uicontrol('Parent',h.panel(97),'Units','pixel',...
    'Style','Edit',...
    'BackgroundColor','w',...
    'Position',[115 165 35 20],...
    'String', config.k1,...
    'Callback', 'config.k1=str2num(get(gcbo,''String''));');

uicontrol('Parent',h.panel(97),'Units','pixel',...
    'Style','text',...
    'Position',[160 160 20 20],...
    'String', 'to',...
    'HorizontalAlignment','Left');

h.hk(4)=uicontrol('Parent',h.panel(97),'Units','pixel',...
    'Style','Edit',...
    'BackgroundColor','w',...
    'Position',[180 165 35 20],...
    'String', config.k2,...
    'Callback', 'config.k2=str2num(get(gcbo,''String''));');

%set search max para
uicontrol('Parent',h.panel(97),'Units','pixel',...
    'Style','text',...
    'Position',[10 130 150 20],...
    'String', 'Search max H from:',...
    'HorizontalAlignment','Left');

h.hk(5)=uicontrol('Parent',h.panel(97),'Units','pixel',...
    'Style','Edit',...
    'BackgroundColor','w',...
    'Position',[115 135 35 20],...
    'String', config.searchh1,...
    'Callback', 'config.searchh1=str2num(get(gcbo,''String''));');

uicontrol('Parent',h.panel(97),'Units','pixel',...
    'Style','text',...
    'Position',[160 130 20 20],...
    'String', 'to',...
    'HorizontalAlignment','Left');

h.hk(6)=uicontrol('Parent',h.panel(97),'Units','pixel',...
    'Style','Edit',...
    'BackgroundColor','w',...
    'Position',[180 135 35 20],...
    'String', config.searchh2,...
    'Callback', 'config.searchh2=str2num(get(gcbo,''String''));');

uicontrol('Parent',h.panel(97),'Units','pixel',...
    'Style','text',...
    'Position',[10 100 150 20],...
    'String', 'Search max k from:',...
    'HorizontalAlignment','Left');

h.hk(7)=uicontrol('Parent',h.panel(97),'Units','pixel',...
    'Style','Edit',...
    'BackgroundColor','w',...
    'Position',[115 105 35 20],...
    'String', config.searchk1,...
    'Callback', 'config.searchk1=str2num(get(gcbo,''String''));');

uicontrol('Parent',h.panel(97),'Units','pixel',...
    'Style','text',...
    'Position',[160 100 20 20],...
    'String', 'to',...
    'HorizontalAlignment','Left');

h.hk(8)=uicontrol('Parent',h.panel(97),'Units','pixel',...
    'Style','Edit',...
    'BackgroundColor','w',...
    'Position',[180 105 35 20],...
    'String', config.searchk2,...
    'Callback', 'config.searchk2=str2num(get(gcbo,''String''));');


% set Average Vp
uicontrol('Parent',h.panel(97),'Units','pixel',...
    'Style','text',...
    'Position',[240 190 80 20],...
    'String', 'Average Vp:',...
    'HorizontalAlignment','Left');

h.hk(9)=uicontrol('Parent',h.panel(97),'Units','pixel',...
    'Style','Edit',...
    'BackgroundColor','w',...
    'Position',[320 195 35 20],...
    'String', config.averVp,...
    'Callback', 'config.averVp=str2num(get(gcbo,''String''));');

% weight
uicontrol('Parent',h.panel(97),'Units','pixel',...
    'Style','text',...
    'Position',[240 155 50 20],...
    'String', 'Weight:',...
    'HorizontalAlignment','Left');

h.hk(10)=uicontrol('Parent',h.panel(97),'Units','pixel',...
    'Style','Edit',...
    'BackgroundColor','w',...
    'Position',[290 160 35 20],...
    'String', config.weight1,...
    'Callback', 'config.weight1=str2num(get(gcbo,''String''));');

h.hk(11)=uicontrol('Parent',h.panel(97),'Units','pixel',...
    'Style','Edit',...
    'BackgroundColor','w',...
    'Position',[335 160 35 20],...
    'String', config.weight2,...
    'Callback', 'config.weight2=str2num(get(gcbo,''String''));');

h.hk(12)=uicontrol('Parent',h.panel(97),'Units','pixel',...
    'Style','Edit',...
    'BackgroundColor','w',...
    'Position',[380 160 35 20],...
    'String', config.weight3,...
    'Callback', 'config.weight3=str2num(get(gcbo,''String''));');

% out path
uicontrol('Parent',h.panel(97),'Units','pixel',...
    'Style','text',...
    'Position',[10 70 70 20],...
    'String', 'H-k map Path:',...
    'HorizontalAlignment','Left');
h.hkout(1)=uicontrol('Parent',h.panel(97),'Units','pixel',...
    'Style','Edit',...
    'BackgroundColor','w',...
    'Position',[100 75 170 20],...
    'ToolTipString','Output directory',...
    'String', config.hkout,...
    'Callback', 'config.hkout=get(gcbo,''String'');');
h.hkout(2) = uicontrol('Parent',h.panel(97),'Units','pixel',...
    'Style','Pushbutton',...
    'Position',[280 75 25 20],...
    'cdata', icon.folder,...
    'ToolTipString','Browse',...
    'Userdata',h.hkout(1),...
    'Callback','tmp2=uigetdir(config.hkout);if isstr(tmp2), config.hkout=tmp2;set(get(gcbo,''Userdata''), ''String'',config.hkout);end,clear tmp*');

uicontrol('Parent',h.panel(97),'Units','pixel',...
    'Style','text',...
    'Position',[10 40 70 20],...
    'String', 'H-k list Path:',...
    'HorizontalAlignment','Left');
h.hkout(3)=uicontrol('Parent',h.panel(97),'Units','pixel',...
    'Style','Edit',...
    'BackgroundColor','w',...
    'Position',[100 45 170 20],...
    'ToolTipString','list file',...
    'String', config.hklstout,...
    'Callback', 'config.hklstout=get(gcbo,''String'')');
h.hkout(4) = uicontrol('Parent',h.panel(97),'Units','pixel',...
    'Style','Pushbutton',...
    'Position',[280 45 25 20],...
    'cdata', icon.folder,...
    'ToolTipString','Browse',...
    'Userdata',h.hkout(3),...
    'Callback','[filename, pathname] = uigetfile(''*.dat'', ''open H-k list'');config.hklstout=[pathname filename];clear filename pathname');

uicontrol('Parent',h.panel(97),'Units','pixel',...
    'Style','text',...
    'Position',[10 10 70 20],...
    'String', 'Plot R Path:',...
    'HorizontalAlignment','Left');
h.hkout(5)=uicontrol('Parent',h.panel(97),'Units','pixel',...
    'Style','Edit',...
    'BackgroundColor','w',...
    'Position',[100 15 170 20],...
    'ToolTipString','Output directory',...
    'String', config.plotrayp,...
    'Callback', 'config.plotrayp=get(gcbo,''String'');');
h.hkout(6) = uicontrol('Parent',h.panel(97),'Units','pixel',...
    'Style','Pushbutton',...
    'Position',[280 15 25 20],...
    'cdata', icon.folder,...
    'ToolTipString','Browse',...
    'Userdata',h.hkout(5),...
    'Callback','tmp2=uigetdir(config.plotrayp);if isstr(tmp2), config.plotrayp=tmp2;set(get(gcbo,''Userdata''), ''String'',config.plotrayp);end,clear tmp*');

% button
uicontrol('Parent',h.panel(97),'Units','pixel',...
    'Style','Pushbutton',...
    'Position',[240 115 80 30],...
    'String', 'Go stacking',...
    'Callback','if config.isoldver;hkmap4old(config.RFdatapath,config.hklstout,config.hkout,config.h1,config.h2,config.k1,config.k2,config.searchh1,config.searchh2,config.searchk1,config.searchk2,config.averVp);else;hkmap(config.RFdatapath,config.hklstout,config.hkout,config.h1,config.h2,config.k1,config.k2,config.searchh1,config.searchh2,config.searchk1,config.searchk2,config.averVp);end;' );
uicontrol('Parent',h.panel(97),'Units','pixel',...
    'Style','Pushbutton',...
    'Position',[330 115 80 30],...
    'String', 'Plot R (by Rayp)',...
    'Callback','if config.isoldver;plotR_P4old(config.RFdatapath,config.plotrayp,config.h1,config.h2,config.k1,config.k2,config.searchh1,config.searchh2,config.searchk1,config.searchk2,config.averVp);else;plotR_P(config.RFdatapath,config.plotrayp,config.h1,config.h2,config.k1,config.k2,config.searchh1,config.searchh2,config.searchk1,config.searchk2,config.averVp);end;');

uicontrol('Parent',h.panel(97),'Units','pixel',...
    'Style','Pushbutton',...
    'Position',[320 55 80 35],...
    'String', 'Do PRF',...
    'Callback','claRFbat;');

uicontrol('Parent',h.panel(97),'Units','pixel',...
    'Style','Pushbutton',...
    'Position',[320 15 80 35],...
    'String', 'Check PRFs',...
    'Callback','RfViewer;');