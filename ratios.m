%% Plotting Ratios
temps = linspace(40,99);
sa = 35*ones(1,length(temps));
press_sw = 20*ones(1,length(temps));
press_w = 0.2*ones(1,length(temps));

%% Plotting density ratio with temperature
figure(1)
density_sw = gsw_rho(sa,temps,press_sw);
density_w = (1./IAPWS_IF97('v_pT',press_w,temps+273.15))';
density_ratio  = density_sw./density_w;

yyaxis left
plot(temps,density_sw,temps,density_w);
ylabel('Density [kg/m^3]')
grid on
yyaxis right
plot(temps,density_ratio);
xlabel('Temperature [C]')
ylabel('Density Ratio [\rho_{sw}/\rho_{w}]')
legend('Seawater','Water','Density Ratio')

%% Plotting viscosity ratio with temperature
figure(2)

mu_sw = seawater_vis(temps,sa);
mu_w = (IAPWS_IF97('mu_pT',press_w,temps+273.15))';
mu_ratio = mu_sw./mu_w;
yyaxis left
plot(temps,mu_sw,temps,mu_w);

ylabel('Viscosity [Pa*s]')
grid on
yyaxis right
plot(temps,mu_ratio);
xlabel('Temperature [C]')
ylabel('Viscosity Ratio [\mu_{sw}/\mu_{w}]')
legend('Seawater','Water','Viscosity Ratio')





