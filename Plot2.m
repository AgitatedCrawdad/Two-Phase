function Plot2(name,prop)
%%%%%%%%%%%%%%%%%%
%Used to plot any variable from the new experimental setup
%%%%%%%%%%%%%%%%%%
import "Trial_70C_7.mat"
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
    errorbar(x,y,errors,'r-*');
else
    x = x(1:end-1);
    y = [mean(a.M) mean(b.M) mean(c.M) mean(d.M) mean(e.M) mean(f.M) mean(g.M) mean(h.M)];
    error_a = std(a.M); error_b = std(b.M);error_c = std(c.M);error_d = std(d.M);error_e = std(e.M);
    error_f = std(f.M); error_g = std(g.M);error_h = std(h.M);
    errors = 2*[error_a error_b error_c error_d error_e error_f error_g error_h];
    errorbar(x,y,errors,'-*');
end

% plot(1008,mean(a.M),'o',1200,mean(b.M),'o',1408,mean(c.M),'o',1633,mean(d.M),'o',1875,mean(e.M),'o',2133,mean(f.M),'o',2408,mean(g.M),'o',2700,mean(h.M),'o')
% plot(x,y,'-*','M  arkerFaceColor','r')
xlabel('Power [Watts]')
% ylabel('Pressure [psi]')
% ylabel('Mass Flowrate [g/s]')
grid on
% nametemp = strrep(nametemp,'_','-');
% legend(nametemp)
clear
end