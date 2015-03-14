% Splitlab Configureation GUI helper function
%% Find SAC files
h.panel(7) = uipanel('Units','pixel','Title','Find files for earthquakes',...
    'FontSize',10,'Position',[133 145 425 260], 'BackgroundColor', [224   223   227]/255);


% field descriptions text
uicontrol('Parent',h.panel(7),'Units','pixel',...
    'Style','text',...
    'Position',[60 205 200 20],...
    'String', 'File search string:',...
    'HorizontalAlignment','Left');
uicontrol('Parent',h.panel(7),'Units','pixel',...
    'Style','text',...
    'HorizontalAlignment','Left',...
    'Position',[60 175 200 20],...
    'String', 'Offset [sec]:');

uicontrol('Parent',h.panel(7),'Units','pixel',...
    'Style','text',...
    'Position',[60 145 200 20],...
    'String', ['Tolerance [' char(177) ' sec]:'],...
    'HorizontalAlignment','Left');
uicontrol('Parent',h.panel(7),'Units','pixel',...
    'Style','text',...
    'Position',[60 115 100 20],...
    'String', 'File name format:',...
    'HorizontalAlignment','Left');
%% edit fields
h.find(1) = uicontrol('Parent',h.panel(7),'Units','pixel',...
    'Style','Edit',...
    'BackgroundColor','w',...
    'Position',[160 210 100 20],...
    'String', config.searchstr,...
    'FontName','FixedWidth',...
    'Callback','config.searchstr=get(gcbo,''String'');');
h.find(3) = uicontrol('Parent',h.panel(7),'Units','pixel',...
    'Style','edit',...
    'BackgroundColor','w',...
    'Position',[160 180 100 20],...
    'String',num2str(config.offset),...
    'ToolTipString','Offset in seconds relative to hypotime',...
    'Callback','config.offset = str2num(get(gcbo,''String''));');


                         
h.find(2) = uicontrol('Parent',h.panel(7),'Units','pixel',...
    'Style','Edit',...
    'BackgroundColor','w',...
    'Position',[160 150 100 20],...
    'String', num2str(config.searchdt),...
    'FontName','FixedWidth',...
    'tooltip', 'search tolerance relative to hypotime',...
    'Callback','config.searchdt=str2num(get(gcbo,''String''));');
%% Radio buttons
uicontrol('Parent',h.panel(7),'Units'  ,'pixel',...
    'Style'    ,'radiobutton',...
    'Value'    ,~config.UseHeaderTimes,...
    'Position' ,[60 90 240 20],...
    'String'   ,'Extract file times from filename',...
    'Tag','UseFileNameTimes',...
    'Callback' ,'config.UseHeaderTimes=~get(gcbo,''Value''); set(findobj(''Tag'',''UseHeaderTimes'') ,''Value'',0)');

uicontrol('Parent',h.panel(7),'Units'  ,'pixel',...
    'Style'    ,'radiobutton',...
    'Value'    ,config.UseHeaderTimes,...
    'Position' ,[60 70 240 20],...   
    'Tag','UseHeaderTimes',...
    'String'   ,'Extract file times from SAC-header (slow)',...
    'Callback' ,'config.UseHeaderTimes=get(gcbo,''Value''); set(findobj(''Tag'',''UseFileNameTimes'') ,''Value'',0)');

%% File format:
str = {'RDSEED' 'SEISAN', 'YY.JJJ.hh.mm.ss.stnn.1.sac'  'YYYY.MM.DD-hh.mm.ss.stn.sac.e' '*.e; *.n; *.z' 'stn.YYMMDD.hhmmss.e' 'YYYY_MM_DD_hhmm_stnn.sac.e'...
    'MyFormat' 'YNoldFormat' 'YNFormat' 'CNSFormat' 'CNSFormat2' 'TibetFormat' 'YAFormat'};
val = strmatch(config.FileNameConvention, str);
h.find(3) = uicontrol('Parent',h.panel(7),'Units','pixel',...
    'Style','popupmenu',...
    'BackgroundColor','w',...
    'Position',[160 120 200 20],...
    'Value',  val,...
    'String', str,...
    'tooltip', 'search tolerance relative to hypotime',...
    'Callback',...
    ['tmpstr = get(gcbo,''String'');tmpval = get(gcbo,''Value'');'...
    'config.FileNameConvention=char(tmpstr(tmpval));',...
    'if tmpval==5;'...% use last letter
    '  config.UseHeaderTimes=1;'...
    '  set(findobj(''Tag'',''UseFileNameTimes'') ,''Value'',0);'...
    '  set(findobj(''Tag'',''UseHeaderTimes'') ,''Value'',1);'...
    'end;'...
    'clear tmp*']...
    );


%% check buttons:
uicontrol('Parent',h.panel(7),'Units'  ,'pixel',...
    'Style'    ,'checkbox',...
    'Value'    ,config.calcphase,...
    'Position' ,[270 210 138 20],...
    'String'   , 'Calculate phase arrivals',...
    'Tooltip'  ,'Phase arrivals as selected in the ''Phase''-panel',...
    'Callback' ,'config.calcphase=get(gcbo,''Value'');');
uicontrol('Parent',h.panel(7),'Units'  ,'pixel',...
    'Style'    ,'checkbox',...
    'Value'    ,config.calcEnergy,...
    'Position' ,[270 190 138 20],...
    'String'   , 'Calculate SKS energy',...
    'Tooltip'  ,'Radiation energy of SKS phase from faulting mechanism',...
    'Callback' ,'config.calcEnergy=get(gcbo,''Value'');');
uicontrol('Parent',h.panel(7),'Units'  ,'pixel',...
    'Style'    ,'checkbox',...
    'Value'    ,config.showstats,...
    'Position' ,[270 170 140 20],...
    'String'   , 'Show statistic plot',...
    'Tag',      'ShowStatsCheck',...
    'Callback' ,'config.showstats=get(gcbo,''Value'');set(findobj(''Tag'',''ShowStatsCheck'') ,''Value'',config.showstats)');






%% buttons
uicontrol('Parent',h.panel(7),'Units','pixel',...
    'Style','Pushbutton',...
    'Position',[10 15 195 30],...
    'String', 'Automatically associate SAC-files',...
    'Tooltip','Associate 3-components SAC files to catalogue',...
    'Callback',['[eq, success]=SL_assignFilesAuto(eq, config.calcphase, config.calcEnergy);',...
                'if ~config.showstats, ',...
                '    helpdlg([''Associated '' num2str(length(eq)) '' earthquakes! ''], ''Info'');',...
                'else,',...
                '  if success , if config.isoldver;SL_showeqstats4old;else;SL_showeqstats;end , end;',...
                'end;',...
                'tmp = findobj(''String'', ''Manually associate SAC-files'');',...
                'set(tmp,''Enable'',''off''); clear tmp']);

uicontrol('Parent',h.panel(7),'Units','pixel',...
    'Style','Pushbutton',...
    'Position',[220 15 195 30],...
    'String', 'Manually associate SAC-files',...
    'Tooltip','Associate 3-components SAC files to catalogue',...
    'Callback',[ 'F=list(fullfile(config.datadir, config.searchstr));',...
                'manual_eq =  SL_assignFilesManual( eq, F);',...
                'if ~isempty(manual_eq), eq=manual_eq; clear manual_eq;',...
                'if ~config.showstats, ',...
                '    helpdlg([''Associated '' num2str(length(manual_eq)) '' earthquakes! ''], ''Info'');',...
                'else,',...
                '  if ~isempty(eq) , if config.isoldver;SL_showeqstats4old;else;SL_showeqstats;end,end;',...
                'end; end;',...
                'tmp = findobj(''String'', ''Automatically associate SAC-files'');',...
                'set(tmp,''Enable'',''off''); clear tmp']);


%% Export
h.panel(9) = uipanel('Units','pixel','Title','Export',...
    'FontSize',10,'Position',[133 15 425 100], 'BackgroundColor', [224   223   227]/255);
uicontrol('Parent',h.panel(9),'Units','pixel',...
    'Style','Pushbutton',...
    'Position',[110 10 200 25],...
    'String', 'Cut and save as SAC',...
    'Tooltip','Cut 3-components SAC files at common time intervals and save new files',...
    'Callback','cutandsaveasSAC');
uicontrol('Parent',h.panel(9),'Units'  ,'pixel',...
    'Style'    ,'text',...
    'Position' ,[10 40 400 40],...
    'String'   , ['Cut the three SAC files to their common time window. '...
    'These new SAC files can then be used in external programms. Not neccesary for SplitLab']);

