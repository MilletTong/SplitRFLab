function  SL_databaseViewer4old
% navigate within the SplitLab database

global eq config rf

if isempty(eq) 
   errordlg('No Earthquakes in database!')
   return
end
%the next lines indicate the order in which coloums are sorted when
%specific button was pressed.
sortorder = [3  2  1  4 %date:  day month year
             4  1  2  3 %julian day
             5  6  7  1 %time
             8  9 10  3 %lat
             9  8 10  3 %long
            10 12 13  3 %depth
            11 10 12  3 %Mw
            12 10 14  3 %baz
            13 12 11  3 %Distance
            14 13 12  3 %Energy
            ]; 
            

%%
strlen   = [ 0 11  12  8 8 7 6  9 8 5];
strlen   = [ 0 10  5 8  8 8 7 6  9 8 5];

names    = {'Date','JDay','Time','lat','long','depth','Mw','back-azi','distance','E_sks'};
fontsize = 12; %pixel

figpos=get(0,'ScreenSize');
width= 360*1.5; height=180*1.5;
    xpos = figpos(3)- figpos(1) - width*2.22;
    ypos = 70 ;
    figpos=[xpos ypos width 270];


h.dlg = findobj('Type','Figure', 'Name','Database Viewer');
if isempty(h.dlg)
    h.dlg    = figure('Name','Database Viewer','color',get(0,'DefaultUIcontrolBackgroundColor'),...
        'Position',figpos,'Units','pixel',  'NumberTitle','off',  'MenuBar','none' );       
else
    clf(h.dlg)
    set(h.dlg, 'ResizeFcn' ,'','Position',figpos, 'Units','pixel')
    figure(h.dlg)
end
%create empty text to get width of text in pixel
tmp = uicontrol(h.dlg, 'style','text', 'fontname','fixedWidth', 'fontunits','pixel', 'FontWeight','bold', 'fontsize',fontsize, 'String',repmat('*',1,sum(strlen)), 'visible','off');
ext    = get(tmp,'extent');
pos    = get(h.dlg,'Position');
pos(3) = ext(3)+95;
set(h.dlg,'Position',pos);
  
val=config.db_index;
if val > length(eq)
    val=[];
end
h.cmenu = uicontextmenu;
h.list = uicontrol(h.dlg, 'style','listbox', 'Position',[40 150 ext(3)+17 figpos(4)-180],...
    'tag','TableList', 'string',[], 'fontname','fixedWidth', 'fontunits','pixel', 'fontsize',fontsize,...
    'Backgroundcolor','w', 'max',999, 'Callback',@getThisLineData,'BusyAction','cancel',...
    'UIContextMenu',h.cmenu, 'value',val);
uimenu(h.cmenu, 'Label', 'Delete','UserData',h.list,...
        'Callback', ['tmpobj = get(gcbo,''UserData'');'...
        'tmp1 = get(tmpobj,''val'');'...
        'tmp2 = setdiff(1:length(eq),tmp1); '...;        
        'eq  = eq(tmp2);'...
        'tmp3 =get(tmpobj,''String''); '...
        'set(tmpobj,''value'',[],''string'',tmp3(tmp2,:)); clear tmp*']);

m4 = uimenu(h.dlg,'Label',   'File');
uimenu(m4, 'Label', 'Save current list', 'Callback', 'savelist');

%% result list
header = '  Phase  \Phi_{SC}  \Phi_{RC}   \deltat_{SC}   \deltat_{RC}  Quality  Null     Filter       Remark';
h.info(1)=uipanel('parent',h.dlg, 'units','pixel', 'Position',[40 40 ext(3)+17 100],'tag','ResultsPanel');
h.info(4)=axes('parent',h.info(1), 'units','pixel', 'Position',[2 78 ext(3)+11 18]);
axis off
h.info(2) = text(0,0,header,'HorizontalAlignment','left','VerticalAlignment','bottom ', ...
    'Tag','ResultHeader','Interpreter', 'Tex', ...
    'fontname','fixedWidth', 'fontunits','pixel', 'fontsize',fontsize, 'FontWeight','bold');

h.info(3) = uicontrol('parent',h.info(1),'style','listbox', 'max',0, 'value',1, 'Position',[1 1 ext(3)+12 80],...
    'tag','ResultsBox', 'string',[], 'Backgroundcolor','w', 'fontname','fixedWidth',...
    'fontunits','pixel', 'fontsize',fontsize, 'HorizontalAlignment','left',...
    'Callback','database_editResults(''select'')','BusyAction','Cancel');

load icon;
h.button = uicontrol(h.dlg, 'style','pushbutton',  'Position',[40 8 50 25],...
    'string','Preview','Callback','SL_SeismoViewer(get(gcbf,''Userdata''))');
h.button2 = uicontrol(h.dlg, 'style','pushbutton', 'Position',[100 8 50 25],...
    'Tooltipstring', 'Remove earthquakes with no result from database',...
    'string','CleanUp', 'Callback','database_editResults(''cleanup'')');
h.button5 = uicontrol( 'style','pushbutton', 'Position',[160 8 60 25],...
    'string','       Export','Tag','ExportButton', 'Cdata', icon.excel,...
    'Tooltipstring', 'Export tabel to Excel worksheet',...
    'Callback','pjt2xls');
h.button6 = uicontrol( 'style','pushbutton', 'Position',[230 8 60 25],...
    'string','Statistic',...
    'Tooltipstring', 'Show statistics plot',...
    'Callback','SL_showeqstats');    
h.button3 = uicontrol(h.dlg, 'style','pushbutton', 'Position',[ext(3)-88 8 45 25],...
    'string','Remove','Enable','off','Tag','ResultsButton',...
    'Tooltipstring', 'Remove result from database',...
    'Callback','database_editResults(''del'')');
h.button4 = uicontrol(h.dlg, 'style','pushbutton', 'Position',[ext(3)-38 8 45 25],...
    'string','Edit','Enable','off','Tag','ResultsButton', ...
    'Tooltipstring', 'Edit values ...',...
    'Callback','database_editResults(''Edit'')');
h.button8 = uicontrol(h.dlg, 'style','pushbutton', 'Position',[ext(3)-138 8 45 25],...
    'string','','Enable','of','Tag','ResultsButton', ...
    'Cdata', icon.presentation,'Tooltipstring', 'View resultfiles',...
    'Callback','database_editResults(''View'')');
h.button7 = uicontrol(h.dlg, 'style','pushbutton', 'Position',[ext(3)+12 8 45 25],...
    'string','View RF','Enable','off','Tag','RFButton', ...
    'Tooltipstring', 'Edit values ...',...
    'Callback','RfViewer(get(gcbf,''Userdata''));');

if ~isempty(rf)
    set(h.button7,'Enable','on');
end
    


    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%default list display:
col = config.tablesortcolumn;
sorttable([],[],sortorder(col,:),[],h.list, col); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%





%% Header Buttons
x=0; %offset of first button
for i=2:length(strlen)
    set(tmp,'string',repmat('_',1,strlen(i)))
    xy = get(tmp,'extent');
    h.head(i)=uicontrol(h.dlg, 'style','pushbutton', 'FontWeight','bold',...
        'tag','TableButton', 'string',names(i-1), 'position',[40+x figpos(4)-30 xy(3:4)],...
        'callback',{@sorttable,sortorder(i-1,:),[],h.list, i-1});
    x = xy(3)+ x - 4;
end
delete(tmp)
set(h.dlg, 'ResizeFcn',@localResizeFcn)
%% Map
SL_Earthview([], [], [], [],1);


%END OF PROGRAMM










%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% selection in list:
function getThisLineData(h_list,evt)
  global eq thiseq
  
h_dlg = gcf;
h_ax  = findobj('Tag','EQmap');
mark  = findobj('Tag','thisEQMarker');
val   = get(h_list,'Value');
r_box = findobj('tag','ResultsBox');

if ~isempty(mark),  delete(mark); end
% set figure UserData to selection index!
set(h_dlg,'Userdata',val(1)); %for use with split button


% Result display
outstr = []; 
for j = 1:length(val)
    R = eq(val(j)).results;
    outstr = strvcat(outstr,['------------------------------------- ' eq(val(j)).dstr ' -----------------------']);
    if ~isempty(R)
        for k = 1:length(R)
            P = R(k).SplitPhase;
            Q = R(k).quality;
            N = R(k).Null;
            phis = [R(k).phiSC(2) R(k).phiRC(2)];
            dts  = [R(k).dtSC(2) R(k).dtRC(2)];
            o = sprintf(['%6s %4.0f' char(186) ' %4.0f' char(186) '  %3.1fs  %3.1fs   %4s    %3s   [%4.3f %4.2f] %s'],...
                P, phis,dts, Q, N, R(k).filter,  R(k).remark);
            outstr=strvcat(outstr,o);
        end
    end
    L(j)=length(R);%numbers of results per earthquake
end
L = cumsum([1 L+1]); %separation lines
set(r_box,'String',outstr, 'value', 1,'UserData',L)





%% Map
if length(val)==1
    Mw=round([eq(val).Mw]*10)/10;
    SL_Earthview([eq(val).lat], [eq(val).long], Mw, [eq(val).depth], [eq(val).date(2)]);
else
    SL_Earthview([eq(val).lat], [eq(val).long], ['*'], ['*'], 0);
end




%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function  sorttable(src,evt,order,indat,h_list, button)
global eq config rf

config.tablesortcolumn= button;

dvec=reshape([eq(:).date], 7, [])';
listdata  = [dvec(:,[ 3 2 1 7 4 5 6])...  day month year Julian_day hour minute second
             [eq(:).lat]'   [eq(:).long]'               ...
             [eq(:).depth]' [eq(:).Mw]'   [eq(:).bazi]'  ...
             [eq(:).dis]'   abs([eq(:).energy]'*100)];%

    %order is passed by correspondng button button
    %initial sort order is by date
    [sdat,idx]  = sortrows(listdata, order); 

%format strings
datum = '%02.0f.%02.0f.%04.0f %03.0f';
hms   = ' %02.0f:%02.0f:%02.0f';
param = [' %6.1f' char(186) ' %6.1f' char(186) ' %4.0fkm  %3.1f'];
geom  = ['   %5.1f' char(186) '  %5.1f' char(186) ];
qual  = ' %3.0f%% ';

format=[datum hms param geom qual];


%format string produces line of match characters....
outstr = sprintf(format,sdat' );
len = length(outstr)/size(sdat,1);
outstr = reshape(outstr, len, size(sdat,1))'; %to produce text-"matrix"
set(h_list,...
    'String',outstr,...
    'UserData',idx) %update display, Userdata are sort order incices
% for i=2:length(idx)-1
%     eq(idx(i)).index=[idx(i-1) idx(i) idx(i+1)];
% end
eq=eq(idx);
if ~isempty(rf)
rf=rf(idx);
end
% Sorting changes only indices, not eq-order
% eq(idx(1)).index   = [idx(end)   idx(1)   idx(2)];%To enable looping 
% eq(idx(end)).index = [idx(end-1) idx(end) idx(1)];
%%








%% ===================================================================
function localResizeFcn(fig,evt)
set(fig,'Units','pixels');
figpos = get(fig,'Position');
if figpos(4) < 200
    figpos(4) =200;
    set(fig,'Position',figpos)
end

l = findobj('tag','TableList');
u = findobj('tag','TableButton');
r = findobj('tag','ResultsPanel');

for i =u';
    uold   = get(i,'Position');
    set(i,'Position',[uold(1) figpos(4)-30 uold(3) uold(4)]);
end
lold   = get(l,'Position');
set(l,'Position',[lold(1:3) figpos(4)-179]);


%% This program is part of SplitLab
% ?2006 Andreas W?tefeld, Universit?de Montpellier, France
%
% DISCLAIMER:
% 
% 1) TERMS OF USE
% SplitLab is provided "as is" and without any warranty. The author cannot be
% held responsible for anything that happens to you or your equipment. Use it
% at your own risk.
% 
% 2) LICENSE:
% SplitLab is free software; you can redistribute it and/or modifyit under the
% terms of the GNU General Public License as published by the Free Software 
% Foundation; either version 2 of the License, or(at your option) any later 
% version.
% This program is distributed in the hope that it will be useful, but WITHOUT
% ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or 
% FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for 
% more details.