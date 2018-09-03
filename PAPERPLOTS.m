%% Plots Tap Water Results
% figure(1)
% Plot2('Trial_60C_1_tapwater','M')
% hold on
% Plot2('Trial_60C_2_tapwater','M')
% ylabel('Flow Rate [g/s]')
% figure(2)
% Plot2('Trial_60C_1_tapwater2','M')
% hold on
% Plot2('Trial_60C_2_tapwater2','M')
% ylabel('Flow Rate [g/s]')
% figure(3)
% Plot2('Trial_60C_2_tapwater2','M')
% hold on
% ylabel('Flow Rate [g/s]')
% yyaxis right
% Plot2('Trial_60C_2_tapwater2','P1')

%% Plots of Salt Water Results
% figure(4)
% Plot2('Trial_60C_2g','C1')
% yyaxis right
% Plot2('Trial_60C_2g','T5')

%% Plots of DI Water Results

% figure(6)
% Plot('Trial_60C_points_DI_1','P1')

%
% figure(7)
% hold
% Plot2('Trial_60C_2g','M')
% Plot2('Trial_60C_1_tapwater2','M')
% Plot('Trial_60C_points_DI_1','M')
% ylabel('Mass Flowrate [g/s]')
% legend('Seawater','Tap Water','Deionized Water','Location','NorthWest')
% 
%% Plot Conductivty Values
% figure(8)
% Plot2('Trial_60C_2g','C1')
% hold on
% Plot2('Trial_60C_1g','C1')
% legend('Trial 1','Trial 2','Location','NorthEast')
% ylabel('Electrical Conductivity [mS/cm]')
% axes3=gca;
% set(axes3,'FontName','Times New Roman','FontSize',28,'Layer','top','LineWidth',3);
% grid on
% set(findall(gca, 'Type', 'Line'),'LineWidth',2);
% g=gcf;
% g.Position=[515 393 805 595];
% xlim([1000 3000])
% ylim([50 60])

% load('Trial_60C_1g')
% figure(81)
% a = Temp2(V110);
% b = Temp2(V120);
% c = Temp2(V130);
% d = Temp2(V140);
% e = Temp2(V150);
% f = Temp2(V160);
% g = Temp2(V170);
% h = Temp2(V180);
% num=230;
% 
% % yyaxis left
% % plot(a.Time(end-num:end)-a.Time(end-num),a.T4(end-num:end))
% hold on
% plot(a.Time(end-num:end)-a.Time(end-num),a.C1(end-num:end))
% % plot(b.Time(end-num:end)-b.Time(end-num),b.C1(end-num:end))
% % plot(c.Time(end-num:end)-c.Time(end-num),c.C1(end-num:end))
% plot(d.Time(end-num:end)-d.Time(end-num),d.C1(end-num:end))
% plot(e.Time(end-num:end)-e.Time(end-num),e.C1(end-num:end))
% % plot(f.Time(end-num:end)-f.Time(end-num),f.C1(end-num:end))
% % plot(g.Time(end-num:end)-g.Time(end-num),g.C1(end-num:end))
% plot(h.Time(end-num:end)-h.Time(end-num),h.C1(end-num:end))
% 
% % legend('110V','120V','130V','140V','150V','160V','170V','180V','Location','NorthWest')
% % legend('110V','120V','130V','140V','150V','160V','170V','Location','NorthWest')
% legend('110V','140V','150V','180V','Location','NorthWest')
% ylabel('Electrical Conductivity [mS/cm]')
% 
% axes3=gca;
% set(axes3,'FontName','Times New Roman','FontSize',28,'Layer','top','LineWidth',3);
% % ylim([58.5 61.5])
% % hold on
% % yyaxis right
% % plot(a.Time(end-num:end)-a.Time(end-num),a.P1(end-num:end))
% % ylim([28 30])
% % % axes3=gca;
% % set(axes3,'FontName','Times New Roman','FontSize',28,'Layer','top','LineWidth',3);
% grid on
% 
% xlabel('Time [s]')
% % ylabel('Pressure [psia]')
% set(findall(gca, 'Type', 'Line'),'LineWidth',2);
% g=gcf;
% g.Position=[515 393 805 595];
% xlim([0 500])
% ylim([52 60])

%% Plot Heater Rod Temperatures
% figure(9)
% Plot2('Trial_60C_2g','T4')
% hold on
% Plot2('Trial_60C_2_tapwater2','T4')
% Plot('Trial_60C_points_DI_2','T4')
% legend('Seawater','Tap Water','Deionized Water','Location','NorthWest')
% ylabel('Heater Temperature [^\circC]')
% axes3=gca;
% set(axes3,'FontName','Times New Roman','FontSize',28,'Layer','top','LineWidth',3);
% grid on
% set(findall(gca, 'Type', 'Line'),'LineWidth',2);
% g=gcf;
% g.Position=[515 393 805 595];
% xlim([1000 3000])


%% Plot Pressures
% figure(11)
% hold on
% Plot2('Trial_60C_2g','P1')
% Plot2('Trial_60C_2g','P2')
% Plot2('Trial_60C_2g','P3')
% legend('P1','P2','P3','Location','NorthEast')
% ylabel('Pressure [psi]')
% axes3=gca;
% grid on
% set(axes3,'FontName','Times New Roman','FontSize',28,'Layer','top','LineWidth',3);
% set(findall(gca, 'Type', 'Line'),'LineWidth',2);
% g=gcf;
% g.Position=[515 393 805 595];
% xlim([1000 3000])

% figure(10) %PLOT OF CHANGE IN PRESSURE FROM P1 TO P3
% hold on
% PlotdP('Trial_60C_2g','P1','P3')
% PlotdP('Trial_60C_1g','P1','P3')
% % PlotdP('Trial_60C_2_tapwater2','P1','P3')
% % PlotdP('Trial_60C_1_tapwater2','P1','P3')
% % PlotdP('Trial_60C_points_DI_2','P1','P3')
% % PlotdP('Trial_60C_points_DI_1','P1','P3')
% legend('Trial 1','Trial 2','Location','NorthEast')
% ylabel('\Delta Pressure [psi]')
% axes3=gca;
% grid on
% set(axes3,'FontName','Times New Roman','FontSize',28,'Layer','top','LineWidth',3);
% ylim([0.8 1.8])
% set(findall(gca, 'Type', 'Line'),'LineWidth',2);
% g=gcf;
% g.Position=[515 393 805 595];
% xlim([1000 3000])


%% Plot of Steady State Conditions PRESSURE AND TEMPERATURE
% load('Trial_60C_1g')
% figure(11)
% a = Temp2(V180);
% num=230;
% yyaxis left
% % plot(a.Time(end-num:end)-a.Time(end-num),a.T4(end-num:end))
% plot(a.Time(end-num:end)-a.Time(end-num),a.T5(end-num:end))
% axes3=gca;
% set(axes3,'FontName','Times New Roman','FontSize',28,'Layer','top','LineWidth',3);
% ylim([58.5 61.5])
% ylabel('Temperature [°C]')
% hold on
% yyaxis right
% plot(a.Time(end-num:end)-a.Time(end-num),a.P1(end-num:end))
% ylim([28 30])
% % axes3=gca;
% % set(axes3,'FontName','Times New Roman','FontSize',28,'Layer','top','LineWidth',3);
% xlabel('Time [s]')
% ylabel('Pressure [psia]')
% grid on
% set(findall(gca, 'Type', 'Line'),'LineWidth',2);
% g=gcf;
% g.Position=[515 393 805 595];


% clear

%% Plot of Steady State heater temps
% f=figure(18);
% Plot2('Trial_60C_1g','T2')
% xdata1=f.Children.Children.XData;
% ydata1=f.Children.Children.YData;
% hold on
% Plot2('Trial_60C_1g','T3')
% xdata2=f.Children.Children.XData;
% ydata2=f.Children.Children.YData;
% clf
% plot(xdata1,ydata1,xdata2,ydata2)
% tempdif = ydata2-ydata1;
% m_dot = 1.26; %kg/s or 20 gpm
% cp = 4.2; %kJ/kgK
% q = m_dot*cp*tempdif;
% plot(xdata1,q)

% Plot('Trial_60C_points_DI_1','M')
% Plot2('Trial_60C_2_tapwater2','M')
% legend('Seawater','Tap Water','Deionized Water','Location','NorthWest')
% axes3=gca;
% set(axes3,'FontName','Times New Roman','FontSize',28,'Layer','top','LineWidth',3);
% grid on
% set(findall(gca, 'Type', 'Line'),'LineWidth',2);
% xlim([1000 3000])
% g=gcf;
% g.Position=[515 393 805 595];
% ylabel('Mass Flow Rate [g/s]')


%% Plot of oscillations of each flow
% figure(12)
% load('Trial_60C_1g')
% a = Temp2(V180);
% clearvars -except a
% load('Trial_60C_points_DI_1')
% b = Temp(V180);
% clearvars -except a b
% load('Trial_60C_2_tapwater2')
% c = Temp2(V180);
% num=110;
% num2 = 160;
% num3 = 110;
% p1 = plot(a.Time(end-num:end)-a.Time(end-num),a.M(end-num:end))
% hold on
% p3 = plot(c.Time(end-num3:end)-c.Time(end-num3),c.M(end-num3:end))
% p2 = plot(b.Time(end-num2:end)-b.Time(end-num2),b.M(end-num2:end))
% 
% p1.Color(4) = 0.5;
% p2.Color(4) = 0.5;
% p3.Color(4) = 0.5;
% xlabel('Time [s]')
% ylabel('Mass Flow Rate [g/s]')
% legend('Seawater','Tap Water','Deionized Water','Location','NorthWest')
% axes3=gca;
% set(axes3,'FontName','Times New Roman','FontSize',28,'Layer','top','LineWidth',3);
% grid on
% set(findall(gca, 'Type', 'Line'),'LineWidth',2);
% g=gcf;
% g.Position=[515 393 805 595];

%% Plot mass flow rate versus power
% figure(13)
% Plot2('Trial_60C_1g','M')
% hold on
% Plot('Trial_60C_points_DI_1','M')
% Plot2('Trial_60C_2_tapwater2','M')
% legend('Seawater','Tap Water','Deionized Water','Location','NorthWest')
% axes3=gca;
% set(axes3,'FontName','Times New Roman','FontSize',28,'Layer','top','LineWidth',3);
% grid on
% set(findall(gca, 'Type', 'Line'),'LineWidth',2);
% xlim([1000 3000])
% g=gcf;
% g.Position=[515 393 805 595];
% ylabel('Mass Flow Rate [g/s]')

%% Calculate Saturation Temperature at the Tip of the Heater
% f=figure(21);
% Plot2('Trial_60C_1g','P1')
% xdata1=f.Children.Children.XData;
% ydata1=f.Children.Children.YData;
% hold on
% Plot2('Trial_60C_1g','P3')
% xdata2=f.Children.Children.XData;
% ydata2=f.Children.Children.YData;
% clf
% % plot(xdata1,ydata1,xdata2,ydata2)
% deltap = ydata1-ydata2;
% heightfraction = 1-(19/58); %Used to account for height difference in measurement points
% addedpress = deltap.*heightfraction;
% Tsat = IAPWS_IF97('Tsat_p',(ydata1-addedpress)*0.00689476)-273.15; %Pressure to be given in MPa
% % plot(xdata1,Tsat)
% errorbar(xdata1,Tsat,Tsat*0.006,'-o','LineWidth',2)
% hold on
% Plot2('Trial_60C_1g','T4')
% 
% legend('Saturation Temperature','Measured Temperature','Location','NorthWest')
% axes3=gca;
% set(axes3,'FontName','Times New Roman','FontSize',28,'Layer','top','LineWidth',3);
% grid on
% set(findall(gca, 'Type', 'Line'),'LineWidth',2);
% xlim([1000 3000])
% g=gcf;
% g.Position=[515 393 805 595];
% ylabel('Saturation Temperature [°C]')
% xlabel('Power [Watts]')
%% Calculate Expected Electrical Conductivity using TEOS-10
% figure(18)
% % Plot2('Trial_60C_2g','C1')
% % hold on
% 
% C1 = 55*ones(100,1);
% temps = linspace(20,60);
% plot(temps,C1)
% hold on
% salinity = 35*ones(100,1);
% press = 20*ones(100,1);
% C = gsw_C_from_SP(salinity,temps',press);
% plot(temps,C,'-','LineWidth',2)
% axes3=gca;
% set(axes3,'FontName','Times New Roman','FontSize',28,'Layer','top','LineWidth',3);
% grid on
% set(findall(gca, 'Type', 'Line'),'LineWidth',2);
% xlim([1000 3000])
% g=gcf;
% g.Position=[515 393 805 595];
% ylabel('Electrical Conductivty [mS/cm]')
% xlabel('Temperature [°C]')
% legend('Measured Conductivity','TEOS-10 Conductivity','Location','NorthWest')
% 

%% Plot of the flow quality

% Tin = 60; %C
% q = 1; %kW
% p3top1dist = linspace(0,1.47,200); %m
% heatercircum = pi*0.015875;%m
% heaterlength = 0.6; %m
% heatflux = q/(heatercircum*heaterlength); %kW/m^2
% x = linspace(0,heaterlength);
% diameter = 0.015875;
% m_dot = 0.004;
% cp = 4.186;
% Tout = Tin + (heatflux*(pi*diameter*x))/(m_dot*cp);
% % plot(x,Tout)
% m_dot_vap = zeros(1,length(Tout));
% for i=1:length(Tout)
%     if Tout(i)<118.6434
%         
%     else
%         deltat = Tout(i) - 118.6434;
%         deltaq = deltat*cp*m_dot;
%         m_dot_vap(i) = deltaq/2260; 
%         Tout(i) = 118.6434;
%         
%     end
% end
% quality = m_dot_vap./m_dot;
% % % v_specific_vap = 0.915506;
% v_specific_vap = 0.88;
% density_vap = 1/v_specific_vap;
% % % v_specific_liq = 0.00105951;
% v_specific_liq = 0.00102;
% density_liq = 1/v_specific_liq;
% % 
% alpha = 1./(1+(density_vap/density_liq)*1*((1-quality)./quality));
% 
% alpha(101:200) = alpha(100); 
% avgalpha = sum(alpha)/length(alpha);
% 
% figure(1)
% grid on
% yyaxis left
% plot(x,Tout)
% % figure(2)
% yyaxis right
% % plot(x,quality)
% % hold on
% % plot(x,alpha)
% % plot(p3top1dist,alpha)
% plot(p3top1dist,avgalpha*ones(length(alpha)));
% 
% f=figure(2); %Calculate void fraction from pressure drop
% % Plot2('Trial_60C_1g','P1');
% Plot2('Trial_60C_2_tapwater2','P1')
% xdata1=f.Children.Children.XData;
% ydata1=f.Children.Children.YData;
% hold on
% Plot2('Trial_60C_2_tapwater2','P3')
% 
% % Plot2('Trial_60C_1g','P3')
% xdata2=f.Children.Children.XData;
% ydata2=f.Children.Children.YData;
% clf
% % close all
% 
% dp = ydata1-ydata2;
% rhoH = (dp*6894.76)/(9.81*1.4478); %Calculates homogeneous density using Pstatic = rho_Homo*g*H*sin(theta)
% 
% voidfraction = (rhoH-density_liq)/(density_vap-density_liq);
% 
% plot(xdata1,voidfraction)
% 
% 








