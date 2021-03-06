function [x,y,errors]=Plot2(name,prop)
% [a,b,c,d,e,f,g,h,i]=Plot2(name,prop)
%%%%%%%%%%%%%%%%%%
%Used to plot any variable from the new experimental setup
%%%%%%%%%%%%%%%%%%
%Example Plot2('Trial_70C_S10','M') would plot the flowrate at each voltage
%level for that trial
% Possible variables: M,T1,T2,T3,T4,T5
%                    P1,P2,P3,C1
%
%
%
v = 0;
for i = 1:9
    v(i) = 100+10*i;
end
num = 120;
x = v.^2/12;
nametemp = name;
name = horzcat(name,'.mat');
load(name)
a = Temp2(V110(length(V110)-num:length(V110),:));
b = Temp2(V120(length(V120)-num:length(V120),:));
c = Temp2(V130(length(V130)-num:length(V130),:));
d = Temp2(V140(length(V140)-num:length(V140),:));
e = Temp2(V150(length(V150)-num:length(V150),:));
f = Temp2(V160(length(V160)-num:length(V160),:));
g = Temp2(V170(length(V170)-num:length(V170),:));
h = Temp2(V180(length(V180)-num:length(V180),:));
if exist('V190')==1
    i = Temp2(V190(length(V190)-num:length(V190),:));
    y = [mean(get(a,prop)) mean(get(b,prop)) mean(get(c,prop)) mean(get(d,prop))...
        mean(get(e,prop)) mean(get(f,prop)) mean(get(g,prop)) mean(get(h,prop)) mean(get(i,prop))];
    error_a = std(get(a,prop)); error_b = std(get(b,prop));error_c = std(get(c,prop));error_d = std(get(d,prop));
    error_e = std(get(e,prop));
    error_f = std(get(f,prop)); error_g = std(get(g,prop));error_h = std(get(h,prop));error_i = std(get(i,prop));
    errors = 2*[error_a error_b error_c error_d error_e error_f error_g error_h error_i];
    if strcmp(prop,'T4')==1
        plt = errorbar(x,y+7.8+1.6,errors+2.2,'-o','LineWidth',2); %Heater TC off by 7.8C
    else
        plt = errorbar(x,y,errors,'-o','LineWidth',2);    
    end

    plt.Color(4) = 0.2;
else
    x = x(1:end-1);
    y = [mean(get(a,prop)) mean(get(b,prop)) mean(get(c,prop)) mean(get(d,prop))...
        mean(get(e,prop)) mean(get(f,prop)) mean(get(g,prop)) mean(get(h,prop))];
    error_a = std(get(a,prop)); error_b = std(get(b,prop));error_c = std(get(c,prop));error_d = std(get(d,prop));
    error_e = std(get(e,prop));
    error_f = std(get(f,prop)); error_g = std(get(g,prop));error_h = std(get(h,prop));
    errors = 2*[error_a error_b error_c error_d error_e error_f error_g error_h];
    if strcmp(prop,'T4')==1
        plt = errorbar(x,y+7.8+1.6,errors+2.2,'-o','LineWidth',2); %Heater TC off by 7.8C
    else
        plt = errorbar(x,y,errors,'-o','LineWidth',2);    
    end
    plt.Color(4) = 0.2;
end

xlabel('Power [Watts]');
grid on
% clear
end