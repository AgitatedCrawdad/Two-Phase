import Temp
v = 0;
for i = 1:8
    v(i) = 100+10*i;
end
num = 200;
x = v.^2/12;
load('Trial_60C_1.mat')
a = Temp(V110(length(V110)-num:length(V110),:));
b = Temp(V120(length(V120)-num:length(V120),:));
c = Temp(V130(length(V130)-num:length(V130),:));
d = Temp(V140(length(V140)-num:length(V140),:));
e = Temp(V150(length(V150)-num:length(V150),:));
f = Temp(V160(length(V160)-num:length(V160),:));
% g = Temp(V170(length(V170)-500:length(V170),:));
g = Temp(V170(1:400,:));
h = Temp(V180(length(V180)-num:length(V180),:));
y = [mean(a.M) mean(b.M) mean(c.M) mean(d.M) mean(e.M) mean(f.M) mean(g.M) mean(h.M)];
% plot(1008,mean(a.M),'o',1200,mean(b.M),'o',1408,mean(c.M),'o',1633,mean(d.M),'o',1875,mean(e.M),'o',2133,mean(f.M),'o',2408,mean(g.M),'o',2700,mean(h.M),'o')
plot(x,y,'-o','MarkerFaceColor','b')
clear
num = 200;
for i = 1:8
    v(i) = 100+10*i;
end
x = v.^2/12;

hold on
load('Trial_80C_1.mat')
a = Temp(V110(length(V110)-num:length(V110),:));
b = Temp(V120(length(V120)-num:length(V120),:));
c = Temp(V130(length(V130)-num:length(V130),:));
d = Temp(V140(length(V140)-num:length(V140),:));
e = Temp(V150(length(V150)-num:length(V150),:));
f = Temp(V160(length(V160)-num:length(V160),:));
g = Temp(V170(length(V170)-num:length(V170),:));
h = Temp(V180(length(V180)-num:length(V180),:));
y = [mean(a.M) mean(b.M) mean(c.M) mean(d.M) mean(e.M) mean(f.M) mean(g.M) mean(h.M)];
% plot(1008,mean(a.M),'o',1200,mean(b.M),'o',1408,mean(c.M),'o',1633,mean(d.M),'o',1875,mean(e.M),'o',2133,mean(f.M),'o',2408,mean(g.M),'o',2700,mean(h.M),'o')
plot(x,y,'-*','MarkerFaceColor','r')

clear
num = 200;
for i = 1:8
    v(i) = 100+10*i;
end
x = v.^2/12;

hold on
load('Trial_90C_1.mat')
a = Temp(V110(length(V110)-num:length(V110),:));
b = Temp(V120(length(V120)-num:length(V120),:));
c = Temp(V130(length(V130)-num:length(V130),:));
d = Temp(V140(length(V140)-num:length(V140),:));
e = Temp(V150(length(V150)-num:length(V150),:));
f = Temp(V160(length(V160)-num:length(V160),:));
g = Temp(V170(length(V170)-num:length(V170),:));
h = Temp(V180(length(V180)-num:length(V180),:));
y = [mean(a.M) mean(b.M) mean(c.M) mean(d.M) mean(e.M) mean(f.M) mean(g.M) mean(h.M)];
% plot(1008,mean(a.M),'o',1200,mean(b.M),'o',1408,mean(c.M),'o',1633,mean(d.M),'o',1875,mean(e.M),'o',2133,mean(f.M),'o',2408,mean(g.M),'o',2700,mean(h.M),'o')
plot(x,y,'-d','MarkerFaceColor','[0.93 0.69 0.13]')

xlabel('Power (W)')
ylabel('Mass Flow Rate (g/s)')
legend('60°C','80°C','90°C','Location','northwest')