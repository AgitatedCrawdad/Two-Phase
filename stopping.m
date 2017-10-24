function stopping() 
import Takedata
import DAQConfig
handle = DAQConfig();
y = Takedata(handle);

global KEY_IS_PRESSED
global t 

KEY_IS_PRESSED = 0;

gcf

h = animatedline('Color','r');
h2 = animatedline;
ax = gca;
ax.YGrid = 'on';
startTime = datetime('now');
i = 0;
set(gcf, 'KeyPressFcn', @myKeyPressFcn)

while ~KEY_IS_PRESSED
      i = i+1;
      t =  datetime('now') - startTime;
      addpoints(h,datenum(t),y(1))
      addpoints(h2,datenum(t),y(2))
      ax.XLim = datenum([t-seconds(10) t]);
      datetick('x','keeplimits')
      drawnow

      disp('looping...')
      pause(1)
      y = Takedata(handle);

end
try
    % Close handle
    LabJack.LJM.Close(handle);
catch e
    showErrorMessage(e)
end

[timeLogs,tempLogs] = getpoints(h);
[timeLogs,tempLogs2] = getpoints(h2);
assignin('base','time',timeLogs);
assignin('base','temp',tempLogs);
assignin('base','temp2',tempLogs)
timeSecs = (timeLogs-timeLogs(1))*24*3600;
figure
plot(timeSecs,tempLogs,timeSecs,tempLogs2)
xlabel('Elapsed time (sec)')
ylabel('Temperature (\circC)')
disp('loop ended')

function myKeyPressFcn(hObject, event)

global KEY_IS_PRESSED

KEY_IS_PRESSED  = 1;

disp('key is pressed') 

