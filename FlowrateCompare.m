P = 29; %Pressure [PSI]
T = 60; %Temperature [C]
m_dot = 0.003979974020503; %Mass Flow Rate [kg/s] 
flow_area = 5.067E-4; %Flow area [m^2]
flow_diam = 0.0254; %[m]
length = 1.5; %[m]
heater_length = 0.6; %[m]
% heater_power = 1.0083; %[kW]
g = 9.81; %Acceleration due to gravity [m/s^2]

mass_flux = m_dot/flow_area; %[kg/m^2*s]
Tsat = IAPWS_IF97('Tsat_p',P*0.00689476)-273.15; %Pressure to be given in MPa
rho_liq =  1./IAPWS_IF97('v_pT',P*0.00689476,T+273); %Find liquid density using Pressure and Temperature [MPA] [K]
rho_vap =  1./IAPWS_IF97('v_pT',P*0.00689476,Tsat+273.16); %Find vapor density using Pressure and Temperature [MPA] [K]
rho_liq_sat =  1./IAPWS_IF97('v_pT',P*0.00689476,Tsat+273); %Find liquid density using Pressure and Temperature [MPA] [K]


h_fsat = IAPWS_IF97('h_pT',P*0.00689476,Tsat+273.15); %Saturated Liquid Enthalpy
h_vsat = IAPWS_IF97('h_pT',P*0.00689476,Tsat+273.16); %Saturated Vapor Enthalpy
h_in = IAPWS_IF97('h_pT',P*0.00689476,T+273.15); %Inlet Liquid Enthalpy
hfg = h_vsat-h_fsat; %Latent Heat of Vaporization

% h_gain = heater_power/m_dot;
% quality = ((heater_power./m_dot)+(h_in-h_fsat)')./(hfg');
% if quality < 0
%     quality = 0;
% end
voltage = zeros(1,8);
for i = 1:20
    voltage(i) = 100+10*i; %Heater voltage
end

heater_power = (voltage.^2/12)/1000; %Power in kW
L = 1.5;
K = 50;
cp = 4.186; %kJ/kgK
quality = @(m_dot,heater_power) ((m_dot*cp*(Tsat-T)-heater_power)/(-hfg*m_dot));

left = @(m_dot,heater_power) ((rho_liq-rho_liq_sat)+((-rho_vap+rho_liq_sat)/(1+(rho_vap/rho_liq_sat)*((1-quality(m_dot,heater_power))/quality(m_dot,heater_power)))))*g*L;
right = @(m_dot,heater_power) (1+quality(m_dot,heater_power)*((rho_liq_sat/rho_vap)-1))*((K*(m_dot.^2))/(2*rho_liq_sat*(flow_area^2)));

n=numel(voltage);
values = zeros(n,2);
for i=1:n
error = @(x) sum((right(x(1),heater_power(i))-left(x(1),heater_power(i)))).^2;
x0 = 0.1*ones(n,1);
A = [];
b = [];
Aeq =[];
beq = [];
lb = [0];
ub = [1];
[x, fval, exitflag, output] = fmincon(error,x0(i),A,b,Aeq,beq,lb,ub);
values(i,:) = x;
end
fval
plot(heater_power*1000,values(:,1)*1000,'--b','LineWidth',5)
grid on
xlabel('Power [kW]')
ylabel('Flow Rate [g/s]')
% hold on 
% plot(P,m,'o')