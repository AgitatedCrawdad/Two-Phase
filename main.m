import Temp
load('Trial_80C_1.mat')
a = Temp(V110(length(V110)-500:length(V110),:));
b = Temp(V120(length(V120)-500:length(V120),:));
c = Temp(V130(length(V130)-500:length(V130),:));
d = Temp(V140(length(V140)-500:length(V140),:));
e = Temp(V150(length(V150)-500:length(V150),:));
f = Temp(V160(length(V160)-500:length(V160),:));
g = Temp(V170(length(V170)-500:length(V170),:));
h = Temp(V180(length(V180)-500:length(V180),:));
mean(a.M)
mean(b.M)
mean(c.M)
mean(d.M)
mean(e.M)
plot(1008,mean(a.M),'o',1200,mean(b.M),'o',1408,mean(c.M),'o',1633,mean(d.M),'o',1875,mean(e.M),'o',2133,mean(f.M),'o',2408,mean(g.M),'o',2700,mean(h.M),'o')