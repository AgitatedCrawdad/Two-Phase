function stopping() 
import Takedata
import DAQConfig
import Fix              %Type "Fix" in the Command Window if stopping function errors out
import varcheck
handle = DAQConfig();
y = Takedata(handle);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%CHANGE NAME TO MATCH EXPERIMENT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
trial = 'Trial_91C_1'; %%KEEP FORMATTING I.E ('Trial_SubcooledTemp#C_Trial#')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%CHANGE NAME TO MATCH EXPERIMENT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

check = horzcat(trial,'.mat');
if exist(check)~=0
    errmsg = input('MAKE SURE YOU ARE NOT OVERWRITTING DATA (LOOK AT LINE 9 & CURRENT FOLDER) (enter "y" if you think you are, or "n" if not):','s');
    if errmsg =='y'
       error('You may have successfully prevented data overwrite, congratulations') 
    end
end


%%
global KEY_IS_PRESSED %Global variable used to detect button press


KEY_IS_PRESSED = 0;

%%%%%%%%%%%%%%%%%%%%THESE LINES CREATE THE LIVE DATA PLOT%%%%%%%%%%%%%%%%%%
gcf;
h = gcf;
T1L = animatedline('Color','r'); 
T2L = animatedline('Color','r','LineStyle','--');
T3L = animatedline('Color','r','LineStyle',':');
T4L = animatedline('Color','k');
P1L = animatedline('Color','b');
P2L = animatedline('Color','b','LineStyle','--');
P3L = animatedline('Color','b','LineStyle','-.');
ML = animatedline('Color','m');
ax = gca;
ax.YGrid = 'on';
startTime = datetime('now');
set(gcf, 'KeyPressFcn', @myKeyPressFcn)
legend('TC1','TC2','TC3','TC4','P1','P2','P3','M','Location','northwest');
%%%%%%%%%%%%%%%%%%%%THESE LINES CREATE THE LIVE DATA PLOT%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%THESE LINES PLOT THE LIVE DATA %%%%%%%%%%%%%%%%%%%%%%%%
i = 0;
while ~KEY_IS_PRESSED 
      i = i + 1;
      t =  datetime('now') - startTime;
      addpoints(T1L,datenum(t),y(1))
      addpoints(T2L,datenum(t),y(2))
      addpoints(T3L,datenum(t),y(3))
      addpoints(T4L,datenum(t),y(7))
      addpoints(P1L,datenum(t),y(4)*6)
      addpoints(P2L,datenum(t),y(5)*6)
      addpoints(P3L,datenum(t),y(6)*6)
      addpoints(ML,datenum(t),y(9)/5.264) %Turns freqency to a mass flowrate (5.264Hz/(g/s))
      ax.XLim = datenum([t-seconds(1200) t]);
      datetick('x','keeplimits')
      
      drawnow
      %%
      %%%%THIS SECTION OF CODE PRINTS OUT THE DATA TO THE CONSOLE
      if i ==1 || mod(i,14)==0
          show1 = ['Time  |',' T1 |',' T2 |',' T3 |',' T4 |','  P1 |','  P2 |','  P3 |',' M'];
          disp(show1);
      end
      show1 = [num2str(datenum(t)*24*3600,'%06.1f'),'|',num2str(y(1),'%#5.1f'),'|',num2str(y(2),'%#5.1f'),'|',num2str(y(3),'%#5.1f'),'|'];
      show2 = [num2str(y(7),'%#5.1f'),'|',num2str(y(4)*6,'%#5.2f'),'|',num2str(y(5)*6,'%#5.2f'),'|',num2str(y(6)*6,'%#5.2f'),'|',num2str(y(9)/5.264,'%#5.3f')];
      show3 = horzcat(show1,show2);
      disp(show3);
      %%
      pause(0.1)
      y = Takedata(handle); %%%GRABS THE DATA AND PUTS IT INTO VARIABLE Y
end
%%%%%%%%%%%%%%%%%%%%THESE LINES PLOT THE LIVE DATA %%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%THESE LINES CLOSE OUT OF LABJACK%%%%%%%%%%%%%%%%%%%%%%%
try
    % Close handle
    LabJack.LJM.Close(handle);
catch e
    showErrorMessage(e)
end
%%%%%%%%%%%%%%%%%%%%THESE LINES CLOSE OUT OF LABJACK%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%THESE LINES SAVE DATA TO WORKSPACE%%%%%%%%%%%%%%%%%%%%%
[timeLogs,tempLogs1] = getpoints(T1L);
[timeLogs,tempLogs2] = getpoints(T2L);
[timeLogs,tempLogs3] = getpoints(T3L);
[timeLogs,tempLogs4] = getpoints(T4L);
[timeLogs,pLogs1] = getpoints(P1L);
[timeLogs,pLogs2] = getpoints(P2L);
[timeLogs,pLogs3] = getpoints(P3L);
[timeLogs,MLogs] = getpoints(ML);

assignin('base','time',timeLogs);
assignin('base','T1',tempLogs1);
assignin('base','T2',tempLogs2);
assignin('base','T3',tempLogs3);
assignin('base','T4',tempLogs4);
assignin('base','P1',pLogs1);
assignin('base','P2',pLogs2);
assignin('base','P3',pLogs3);
assignin('base','M',MLogs);

T1 = tempLogs1;
T2 = tempLogs2;
T3 = tempLogs3;
T4 = tempLogs4;
P1 = pLogs1;
P2 = pLogs2;
P3 = pLogs3;
M = MLogs;

timeSecs = (timeLogs-timeLogs(1))*24*3600;
assignin('base','timeSecs',timeSecs)

Data = horzcat(timeSecs.',T1.',T2.',T3.',T4.',P1.',P2.',P3.',M.'); %.' transposed the vector, horzcat concatenates to a single matrix
assignin('base',trial,Data);
%%%%%%%%%%%%%%%%%%%%THESE LINES SAVE DATA TO WORKSPACE%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%THESE LINES SAVE DATA TO WORKSPACE/ERROR CHECK%%%%%%%%%%%%%%%%%%%%%
check = horzcat(trial,'.mat');
if exist(check)==0
    newName = varcheck();
    S.(newName) = Data;
    save(trial, '-struct', 'S') 
else  
    variableInfo = whos('-file',check);
    newName = varcheck();
    
    t = 1;
    j = 0;
    while t==1
        for i=1:length(variableInfo)
            if strcmp(newName,variableInfo(i,1).name)
                j = j+1;
                disp('Trial run has already been entered')
                newName = varcheck();
            end
        end
        if j == 0
            t = 0;
        end
        j = 0;
    end
    S.(newName) = Data;

    if exist(check)>=1
        save(trial, '-struct', 'S','-append')
    else
        save(trial, '-struct', 'S')
    end
end
close all
%%%%%%%%%%%%%%%%%%%%THESE LINES SAVE DATA TO WORKSPACE/ERROR CHECK%%%%%%%%%%%%%%%%%%%%%

% save(trial,'Data')

% figure
% plot(timeSecs,tempLogs1,timeSecs,tempLogs2,timeSecs,tempLogs3)
% xlabel('Elapsed time (sec)')
% ylabel('Temperature (\circC)')
% disp('loop ended')

function myKeyPressFcn(hObject, event)

global KEY_IS_PRESSED

KEY_IS_PRESSED  = 1;

disp('key is pressed') 

