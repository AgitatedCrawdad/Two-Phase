function stopping() 
import Takedata
import DAQConfig
import Fix
handle = DAQConfig();
y = Takedata(handle);

global KEY_IS_PRESSED
%global t 

KEY_IS_PRESSED = 0;

gcf;
T1L = animatedline('Color','r');
T2L = animatedline('Color','r','LineStyle','--');
T3L = animatedline('Color','r','LineStyle',':');
T4L = animatedline('Color','k');
P1L = animatedline('Color','g');
P2L = animatedline('Color','g','LineStyle','--');
P3L = animatedline('Color','g','LineStyle','-.');
ax = gca;
ax.YGrid = 'on';
startTime = datetime('now');
set(gcf, 'KeyPressFcn', @myKeyPressFcn)

legend('TC1','TC2','TC3','TC4','P1','P2','P3','Location','northwest');

while ~KEY_IS_PRESSED
    
      t =  datetime('now') - startTime;
      addpoints(T1L,datenum(t),y(1))
      addpoints(T2L,datenum(t),y(2))
      addpoints(T3L,datenum(t),y(3))
      addpoints(T4L,datenum(t),y(7))
      addpoints(P1L,datenum(t),y(4)*6)
      addpoints(P2L,datenum(t),y(5)*6)
      addpoints(P3L,datenum(t),y(6)*6)
      ax.XLim = datenum([t-seconds(10) t]);
      datetick('x','keeplimits')
      
      drawnow

      disp('looping...')
      pause(2.5)
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

assignin('base','time',timeLogs);
assignin('base','T1',tempLogs1);
assignin('base','T2',tempLogs2);
assignin('base','T3',tempLogs3);
assignin('base','T4',tempLogs4);
assignin('base','P1',pLogs1);
assignin('base','P2',pLogs2);
assignin('base','P3',pLogs3);

timeSecs = (timeLogs-timeLogs(1))*24*3600;
assignin('base','timeSecs',timeSecs)
figure
plot(timeSecs,tempLogs1,timeSecs,tempLogs2,timeSecs,tempLogs3)
xlabel('Elapsed time (sec)')
ylabel('Temperature (\circC)')
disp('loop ended')

function myKeyPressFcn(hObject, event)

global KEY_IS_PRESSED

KEY_IS_PRESSED  = 1;

disp('key is pressed') 

