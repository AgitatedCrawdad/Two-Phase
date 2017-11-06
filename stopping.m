function stopping() 
import Takedata
import DAQConfig
import Fix              %Type "Fix" in the Command Window if stopping function errors out
handle = DAQConfig();
y = Takedata(handle);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%CHANGE NAME TO MATCH EXPERIMENT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
trial = 'Data_110V_25C'; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%CHANGE NAME TO MATCH EXPERIMENT%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if exist(trial,'var')
else
    error('Change name of trial data, file already exists')
end

%%
global KEY_IS_PRESSED
%global t 

KEY_IS_PRESSED = 0;

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

while ~KEY_IS_PRESSED 

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

%       disp(num2str(datenum(t)*24*3600)+',')
      pause(2)
      y = Takedata(handle);
end

try
    % Close handle
    LabJack.LJM.Close(handle);
catch e
    showErrorMessage(e)
end

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
save(trial,'Data')

figure
plot(timeSecs,tempLogs1,timeSecs,tempLogs2,timeSecs,tempLogs3)
xlabel('Elapsed time (sec)')
ylabel('Temperature (\circC)')
disp('loop ended')

function myKeyPressFcn(hObject, event)

global KEY_IS_PRESSED

KEY_IS_PRESSED  = 1;

disp('key is pressed') 

