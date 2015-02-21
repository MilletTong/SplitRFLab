function varargout=neic2mat(catalogue)
%Save NEIC earthquake catalogue data to read with Splitlab
%
%Select the "SPREAD SHEET FORMAT" (comma separated list) as obtained from NEIC (neic.usgs.gov)
%
%This file must have one header line and comma separated column containing:
%Year,Month,Day,Time(hhmmss.mm)UTC,Lat,Long,Mag,Depth
%1990,01,02,202132.62, 13.41, 144.44,5.7,135
%1990,01,04,053221.04,-15.40,-172.85,6.4, 53
%
% The NEIC catalogue does not contain fault mechanism
% informations. Full SplitLab functionality is not guaranteed ...
%
%

% Andreas Wuestefeld ,31.03.06
hbox=questdlg(help('SL_neic2mat'),'Help','Goto NEIC','Update from Server','Open local file','Update from Server');
drawnow
switch hbox
    case 'Cancel'
        return
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case 'Goto NEIC'
        try
            web http://neic.usgs.gov/neis/epic/epic_global.html -browser
        catch
            error('Problems while opening web browser. See <a href="matlab:doc docopt">docopt</a> and <a href="matlab:doc web">web</a> for details')
        end
        return

    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case 'Open local file'
        [filename, pathname] = uigetfile( ...
            {'*.dat';'*.txt';'*.csv';'*.*'}, ...
            'Pick the earthquake file');
        if filename==0 & pathname==0
            hbox=questdlg('Do you want to download a list from NEIC?','Get data','No','Goto NEIC','No');
            if strcmp(hbox,'Goto NEIC')
                try
                    web http://neic.usgs.gov/neis/epic/epic_global.html -browser
                catch
                    weberror
                end
            end
            if nargout==1
                varargout{1}=[];
            end
            return
        end
        workbar(.4,'Reading data...')

        data = dlmread(fullfile(pathname,filename),',',1,0);%skip header line
        % initialize structure:
        cmt.year     = [];
        cmt.month    = [];
        cmt.day      = [];
        cmt.jjj      = [];
        cmt.hour     = [];
        cmt.minute   = [];
        cmt.sec      = [];
        cmt.lat      = [];
        cmt.long     = [];
        cmt.depth    = [];
        cmt.M0       = [];
        cmt.Mw       = [];




    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case 'Update from Server'
        workbar(.05,'Sending querry to http://neic.usgs.gov/...')
        drawnow

        load(catalogue)
        lastdate = [cmt.year(end) cmt.month(end) cmt.day(end)];
        lastdate = datevec(datenum(lastdate)+1);% add one day to last date
        today    = datevec(now);

        workbar(.2,'Sending query to http://neic.usgs.gov/...')
        try
            neic     = urlread(['http://neic.usgs.gov/cgi-bin/epic/epic.cgi'...
                '?SEARCHMETHOD=1&FILEFORMAT=6&SEARCHRANGE=HH&SUBMIT=Submit+Search'...
                ['&SYEAR=' num2str(lastdate(1)) '&SMONTH=' num2str(lastdate(2)) '&SDAY=' num2str(lastdate(3))]...
                ['&EYEAR=' num2str(today(1))    '&EMONTH=' num2str(today(2))    '&EDAY=' num2str(today(3))]...
                '&LMAG=4&UMAG=9.9'...
                '&NDEP1=0&NDEP2=1000'...
                '&IO1=&IO2=&SLAT2=0.0&SLAT1=0.0&SLON2=0.0&SLON1=0.0&CLAT=0.0&CLON=0.0&CRAD=0']);
        catch
            workbar(1)
            errordlg({'Sorry, but I have problems reading the file on the server','http://neic.usgs.gov/cgi-bin/epic/epic.cgi'},'Connection Problems')
            return
        end
        workbar(.7,'Processing data...')
        start = strfind(neic,'Year');
        stop  = strfind(neic,'</PRE>') - 2;
        neic  = neic(start:stop);
        tmpfile   = tempname;
        fid = fopen(tmpfile,'w');
        fprintf(fid,'%s',neic);
        fclose(fid);

        data = dlmread(tmpfile,',',1,0);%skip header line
        delete(tmpfile)
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
workbar(.9,'Processing data...')

[h,m,s]=strange2hms(data(:,4)); %CONVERT STRAGE TIME FORMAT TO READIBLE FORMAT


cmt.year     = [cmt.year;   data(:,1)];
cmt.month    = [cmt.month;  data(:,2)];
cmt.day      = [cmt.day;    data(:,3)];
cmt.jjj      = [cmt.jjj;    dayofyear(data(:,1)',data(:,2)',data(:,3)')']; %julian day
cmt.hour     = [cmt.hour;   h];
cmt.minute   = [cmt.minute; m];
cmt.sec      = [cmt.sec;    s];
cmt.lat      = [cmt.lat;    data(:,5)];
cmt.long     = [cmt.long;   data(:,6)];
cmt.depth    = [cmt.depth;  data(:,8)];
cmt.M0       = nan;
cmt.Mw       = [cmt.Mw;     data(:,7)];
%     cmt.region   = '';
%     cmt.strike   = nan;
%     cmt.dip      = nan;
%     cmt.rake     = nan;
workbar(1)
drawnow


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% save datebase:
[FileName,PathName] = uiputfile('*.mat','Save Catalogue', 'neicCatalogue.mat');
if ~(FileName==0)
    fname=fullfile(PathName,FileName);
    save(fname,'cmt')
    helpdlg({['File "' fname '" sucsessfully written'],
        ['start: ' datestr( [cmt.year(1), cmt.month(1), cmt.day(1),0,0,0])],
        ['stop:  ' datestr( [cmt.year(end), cmt.month(end), cmt.day(end),0,0,0])],
        ['Mw_min: ' num2str(min(cmt.Mw)) '   Mw_max: ' num2str(max(cmt.Mw))]},...
        'SL_neicread sucsess')
end


if nargout==1
    varargout{1}=cmt;
end


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [h,m,s]=strange2hms(dat)
%converts the "strange" time format of the NEIC catalog to hour minute
%second format
H = dat/10000;
h = floor(H);
M = (H-h)*100;
m = floor(M);
s = (M-m)*100;

