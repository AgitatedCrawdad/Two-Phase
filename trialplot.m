function trialplot(name)
import Temp
v = 0;
for i = 1:9
    v(i) = 100+10*i;
end
num = 200;
x = v.^2/12;
name = horzcat(name,'.mat');
load(name)
a = Temp(V110(length(V110)-num:length(V110),:));
b = Temp(V120(length(V120)-num:length(V120),:));
c = Temp(V130(length(V130)-num:length(V130),:));
d = Temp(V140(length(V140)-num:length(V140),:));
e = Temp(V150(length(V150)-num:length(V150),:));
f = Temp(V160(length(V160)-num:length(V160),:));
g = Temp(V170(length(V170)-num:length(V170),:));
h = Temp(V180(length(V180)-num:length(V180),:));
if exist('V190')==1
    i = Temp(V190(length(V190)-num:length(V190),:));
    y = [mean(a.M) mean(b.M) mean(c.M) mean(d.M) mean(e.M) mean(f.M) mean(g.M) mean(h.M) mean(i.M)];
    error_a = std(a.M); error_b = std(b.M);error_c = std(c.M);error_d = std(d.M);error_e = std(e.M);
    error_f = std(f.M); error_g = std(g.M);error_h = std(h.M);error_i = std(i.M);
    errors = [error_a error_b error_c error_d error_e error_f error_g error_h error_i];
    errorbar(x,y,errors,'*');
else
    x = x(1:end-1);
    y = [mean(a.M) mean(b.M) mean(c.M) mean(d.M) mean(e.M) mean(f.M) mean(g.M) mean(h.M)];
    error_a = std(a.M); error_b = std(b.M);error_c = std(c.M);error_d = std(d.M);error_e = std(e.M);
    error_f = std(f.M); error_g = std(g.M);error_h = std(h.M);
    errors = [error_a error_b error_c error_d error_e error_f error_g error_h];
    errorbar(x,y,errors,'-*');
end

% plot(1008,mean(a.M),'o',1200,mean(b.M),'o',1408,mean(c.M),'o',1633,mean(d.M),'o',1875,mean(e.M),'o',2133,mean(f.M),'o',2408,mean(g.M),'o',2700,mean(h.M),'o')
% plot(x,y,'-*','MarkerFaceColor','r')
clear
end