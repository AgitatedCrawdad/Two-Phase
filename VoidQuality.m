%% Plot of the flow quality
f=figure(2); %Calculate void fraction from pressure drop
% trialname = 'Trial_60C_2_tapwater2'
% trialname = 'Trial_60C_points_DI_2'
trialname = 'Trial_60C_2g'
% [x1,p1,p1err]=Plot2(trialname,'P1');
% [x1,t5,t5err]=Plot2(trialname,'T5');
% [x1,m,merr]=Plot2(trialname,'M');
% [x1,p3,p3err]=Plot2(trialname,'P3');

% [x1,p1,p1err]=Plot(trialname,'P1');
% hold on
% % [x1,t5,t5err]=Plot(trialname,'T5');
% % [x1,m,merr]=Plot(trialname,'M');
% [x1,p3,p3err]=Plot(trialname,'P3');
close all

Tin = t5; %C
q = x1./1000; %kW
% p3top1dist = linspace(0,1.47,200); %m
diameter = 0.015875; %m heater diameter
heatercircum = pi*diameter;%m
heaterlength = 0.6; %m
heatflux = q/(heatercircum*heaterlength); %kW/m^2
x = linspace(0,heaterlength,100);
m_dot = m/1000; %kg/s
cp = 4.186; %kJ/kgK

Tout = zeros(length(x),length(m_dot)); %100x8
for i=1:length(Tin)
    Tout(:,i) = Tin(i) + (heatflux(i)*(pi*diameter*x))/(m_dot(i)*cp);
end

deltap = p1-p3;
heightfraction = 1-(19/58); %Used to account for height difference in measurement points
addedpress = deltap.*heightfraction;
Tsat = IAPWS_IF97('Tsat_p',(p1-addedpress)*0.00689476)-273.15; %Pressure to be given in MPa

m_dot_vap = zeros(length(x),length(m_dot)); %100x8
for i=1:length(Tsat)
    for j=1:length(Tout)
        if Tout(j,i)<Tsat(i)
        else
            deltat = Tout(j,i) - Tsat(i);
            deltaq = deltat*cp*m_dot(i);
            m_dot_vap(j,i) = deltaq/2261; %Latent heat of vaporization
            Tout(j,i) = Tsat(i);
        end
    end
end

quality = zeros(length(x),length(m_dot)); %100x8
for i=1:length(m_dot)
    quality(:,i) = m_dot_vap(:,i)./m_dot(i);
end
% v_specific_vap = 0.915506;
v_specific_vap = 0.88;
density_vap = 1/v_specific_vap;
% v_specific_liq = 0.00105951;
v_specific_liq = 0.00102;
density_liq = 1/v_specific_liq;
% % 
alpha = 1./(1+(density_vap/density_liq)*1*((1-quality)./quality));
for i =1:290
    alpha(100+i,:) = alpha(100,:); 
end
avgalpha = sum(alpha)/length(alpha);
% plot(x1,avgalpha)
% 
% figure(1)
% grid on
% yyaxis left
% plot(x,Tout)
% % figure(2)
% yyaxis right
% plot(x1,avgalpha)

f=figure(2); %Calculate void fraction from pressure drop
% Plot2('Trial_60C_1g','P1')
% trialname = 'Trial_60C_2_tapwater2'

Plot2(trialname,'P1');
xdata1=f.Children.Children.XData;
ydata1=f.Children.Children.YData;
hold on
Plot2(trialname,'P3');

% Plot2('Trial_60C_1g','P3')
xdata2=f.Children.Children.XData;
ydata2=f.Children.Children.YData;
clf
% close all

dp = ydata1-ydata2;
rhoH = ((dp-0.3)*6894.76)/(9.81*1.4478); %Calculates homogeneous density using Pstatic = rho_Homo*g*H*sin(theta)

voidfraction = (rhoH-density_liq)/(density_vap-density_liq);
plot(x1,avgalpha);
hold on
plot(xdata1,voidfraction);

legend('Method 1 - Sat. P & T','Method 2 - Pressure Drop')

