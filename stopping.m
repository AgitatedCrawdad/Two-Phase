function stopping() 
import Takedata
y = Takedata();

global KEY_IS_PRESSED
global t 

KEY_IS_PRESSED = 0;

gcf

h = animatedline;
ax = gca;
ax.YGrid = 'on';
startTime = datetime('now');
i = 0;
set(gcf, 'KeyPressFcn', @myKeyPressFcn)

while ~KEY_IS_PRESSED
      i = i+1;
      t =  datetime('now') - startTime;
      addpoints(h,datenum(t),y)
      ax.XLim = datenum([t-seconds(100) t]);
      datetick('x','keeplimits')
      drawnow

      disp('looping...')
      pause(0.1)
      y = Takedata();

end
[timeLogs,tempLogs] = getpoints(h);
assignin('base','time',timeLogs);
assignin('base','temp',tempLogs);
timeSecs = (timeLogs-timeLogs(1))*24*3600;
figure
plot(timeSecs,tempLogs)
xlabel('Elapsed time (sec)')
ylabel('Temperature (\circF)')
disp('loop ended')

function myKeyPressFcn(hObject, event)

global KEY_IS_PRESSED

KEY_IS_PRESSED  = 1;

disp('key is pressed') 

