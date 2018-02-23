clear
trial = 'Trial_80C_1'; %CHANGE THIS TO REFLECT TRIAL WANTED
trialname = horzcat(trial,'.mat');
load(trialname)
num = 200; %THIS TAKES THE LAST 200 DATA POINTS FOR EACH VOLTAGE RUN
v = 0;
for i = 1:9
    v(i) = 100+10*i;
end
x = v.^2/12; %ARRAY OF POWER IN WATTS OF EACH VOLTAGE

%%%%%CREATES OBJECTS OF INDIVIDUAL VOLTAGE RUNS FOR A GIVEN TRIAL%%%%%%%%%
a = Temp(V110(length(V110)-num:length(V110),:));
b = Temp(V120(length(V120)-num:length(V120),:));
c = Temp(V130(length(V130)-num:length(V130),:));
d = Temp(V140(length(V140)-num:length(V140),:));
e = Temp(V150(length(V150)-num:length(V150),:));
f = Temp(V160(length(V160)-num:length(V160),:));
g = Temp(V170(length(V170)-num:length(V170),:));
h = Temp(V180(length(V180)-num:length(V180),:));
%%%%%%%%THIS IS FOR IF THERE IS A 190V RUN INCLUDED IN THE DATA%%%%%%%%%%%%
if exist('V190')==1
    i = Temp(V190(length(V190)-num:length(V190),:));
end
%%%%%%%%THIS IS FOR IF THERE IS A 190V RUN INCLUDED IN THE DATA%%%%%%%%%%%%
%%%%%CREATES OBJECTS OF INDIVIDUAL VOLTAGE RUNS FOR A GIVEN TRIAL%%%%%%%%%


%USE THE OBJECTS ABOVE TO PLOT SPECFIC DATA VALUES
%THE FOLLOWING ARE THE PROPERTIES OF THE OBJECT AVAILABLE FOR USE
%       Time
%       T1
%       T2
%       T3
%       T4
%       Ts           %Ts is all the temperatures together
%       T1S
%       T2S
%       T3S
%       T4S
%       P1
%       P2
%       P3
%       Ps
%       M

% FOR EXAMPLE TO ACCESS THE 110V RUN MASS FLOW RATE DATA TYPE: 'a.M'
%a.M %Uncomment this line to see the example

trialplot(trial); %THIS PLOTS MASS FLOW RATE VS HEATER POWER 

figure(2) %PLOTS UNFILTERED FLOWRATE WITH TIME
plot(a.Time,a.M)
ylim([0 16])
xlabel('Time (s)')
ylabel('Flowrate (g/s)')
title('Flowrate vs Time')

figure(3) %PLOTS THE MOVING AVERAGE OF MASS FLOWRATE FOR THE 110V RUN
datapts = 20;
B = 1/datapts*ones(datapts,1);
out = filter(B,1,a.M);
plot(a.Time(datapts:end),out(datapts:end))
ylim([0 16])
xlabel('Time (s)')
ylabel('Flowrate (g/s)')
title('Flowrate vs Time')

figure(4) %PLOTS UNFILTERED TEMPERATURE WITH TIME
plot(a.Time,a.Ts)
xlabel('Time (s)')
ylabel('Temperature (°C)')
title('Temperature vs Time')
legend('T1','T2','T3','T4')

figure(5) %PLOTS THE MOVING AVERAGE OF THE TEMPERATURES FOR THE 110V RUN
datapts = 10;
B = 1/datapts*ones(datapts,1);
out = filter(B,1,a.T1);
plot(a.Time(datapts:end),out(datapts:end))
hold on
B = 1/datapts*ones(datapts,1);
out = filter(B,1,a.T2);
plot(a.Time(datapts:end),out(datapts:end))
hold on
B = 1/datapts*ones(datapts,1);
out = filter(B,1,a.T3);
plot(a.Time(datapts:end),out(datapts:end))
hold on
B = 1/datapts*ones(datapts,1);
out = filter(B,1,a.T4);
plot(a.Time(datapts:end),out(datapts:end))

xlabel('Time (s)')
ylabel('Temperature (°C)')
title('Temperature vs Time')
legend('T1','T2','T3','T4')
