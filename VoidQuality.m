%% Plot of the flow quality
trialname = 'Trial_60C_1_tapwater2'
% trialname = 'Trial_60C_points_DI_2'
% trialname = 'Trial_60C_2g'
figure(100)
[x1,p1,p1err]=Plot2(trialname,'P1');
[x1,t5,t5err]=Plot2(trialname,'T5');
[x1,m,merr]=Plot2(trialname,'M');
[x1,p3,p3err]=Plot2(trialname,'P3');
% 
% [x1,p1,p1err]=Plot(trialname,'P1');
% hold on
% [x1,t5,t5err]=Plot2('Trial_60C_2_tapwater2','T5');
% [x1,m,merr]=Plot(trialname,'M');
% [x1,p3,p3err]=Plot(trialname,'P3');
close gcf

figure(8)

Tin = t5; %C
q = x1./1000; %kW
% p3top1dist = linspace(0,1.47,200); %m
heaterdiameter = 0.015875; %m heater diameter
heatercircum = pi*heaterdiameter;%m
heaterlength = 0.6; %m
heatflux = q/(heatercircum*heaterlength); %kW/m^2
x = linspace(0,heaterlength,100);
m_dot = m/1000; %kg/s
cp = 4.186; %kJ/kgK

Tout = zeros(length(x),length(m_dot)); %100x8
for i=1:length(Tin)
    Tout(:,i) = Tin(i) + (heatflux(i)*(pi*heaterdiameter*x))/(m_dot(i)*cp);
end

deltap = p1-p3;
heightfraction = 1-(19/58); %Used to account for height difference in measurement points
addedpress = deltap.*heightfraction;
% Tsat = IAPWS_IF97('Tsat_p',(p1-addedpress)*0.00689476)-273.15; %Pressure to be given in MPa

pdistr = zeros(length(x),length(m_dot)); %100x8
for i=1:length(x1)
    pdistr(:,i) = linspace(p1(i),p3(i));
end

Tsat = IAPWS_IF97('Tsat_p',(pdistr)*0.00689476)-273.15; %Pressure to be given in MPa

m_dot_vap = zeros(length(x),length(m_dot)); %100x8
deltat = zeros(length(x),length(m_dot));
for i=1:length(x1)
    for j=1:length(Tout)
        if Tout(j,i)<Tsat(j,i)
        else
            deltat(j,i) = Tout(j,i) - Tsat(j,i);
%             deltat = Tout(j,i) - Tsat(i);
            deltaq(j,i) = deltat(j,i)*cp*m_dot(i);
            m_dot_vap(j,i) = deltaq(j,i)/(IAPWS_IF97('hV_p',0.2)-IAPWS_IF97('hL_p',0.2)); %Latent heat of vaporization
            Tout(j,i) = Tsat(j,i);
        end
    end
end

quality = zeros(length(x),length(m_dot)); %100x8
for i=1:length(m_dot)
    quality(:,i) = m_dot_vap(:,i)./m_dot(i);
end

density_vap = 1/IAPWS_IF97('v_pT',mean(pdistr(end,:))*0.00689476,mean(Tsat(end,:))+273.16);
density_liq = 1/IAPWS_IF97('v_pT',mean(pdistr(end,:))*0.00689476,mean(Tsat(end,:))+273);


alpha = 1./(1+(density_vap/density_liq)*1*((1-quality)./quality));
for i =1:140
    alpha(100+i,:) = alpha(100,:); 
    quality(100+i,:) = quality(100,:);
end
alpha_stomma = 1-(((alpha.^2)-(quality.^2))./(2*((log((1-quality)./(1-alpha)))-(alpha-quality))));
alpha_stomma(isnan(alpha_stomma))=0;
avgalpha_stomma = sum(alpha_stomma)/(length(alpha));
avgalpha = sum(alpha)/length(alpha);

dp = p1-p3;

rhoH = ((dp)*6894.76)/(9.81*1.4478); %Calculates homogeneous density using Pstatic = rho_Homo*g*H*sin(theta)

voidfraction = (rhoH-density_liq)/(density_vap-density_liq);
% plot(x1,avgalpha);
% hold on
% plot(x1,avgalpha_stomma);
% plot(x1,voidfraction)
% grid on
% ylabel('Void Fraction [\alpha]')
% xlabel('Power [Watts]')
% legend('Method 1 - Thermo. Eq.','Method 2 - Stomma','Method 3 - Pressure Drop','Location','SouthEast')
% axes3=gca;
% set(axes3,'FontName','Times New Roman','FontSize',28,'Layer','top','LineWidth',3);
% grid on
% set(findall(gca, 'Type', 'Line'),'LineWidth',5);
% xlim([1000 3000])
% g=gcf;
% g.Position=[515 393 805 595];
% 
channeldiameter = 0.0254; %m
channelarea = pi*(channeldiameter/2)^2;
massflux = (m/1000)/channelarea;

