voltage = zeros(1,8);
for i = 1:8
    voltage(i) = 100+10*i; %Heater voltage
end
heater_power = (voltage.^2/12)/1000; %Power in kW
x = zeros(length(heater_power),5);
for i=1:length(heater_power)
    x0 = [0,  0.001, 0, 0, heater_power(i)];
    lb = [0,      0, 0, 0, heater_power(i)];
    ub = [1000, 0.1, 1, 1, heater_power(i)];
    fun = @VoidTheory;
    A = [];
    b = [];
    Aeq = [];
    beq = [];
    

    x(i,:) = fmincon(fun,x0,A,b,Aeq,beq,lb,ub)
end
figure(10)
plot(x(:,5)*1000,x(:,2)*1000,'k','LineWidth',5);
grid on
xlabel('Power [kW]')
ylabel('Flow Rate [g/s]')
