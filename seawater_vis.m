function [mu]=seawater_vis(T,sal)
% Source: El-Dessouky, Ettouny (2002): Fundamentals of Sea Water Desalination (Appendix A: Themodynamic Properties)		
% Takes temperature in Celsius and salinity in g/kg
% Returns dynamic viscosity in units of Pa*s
A = (1.474E-3)+(1.5E-5)*T-(3.927E-8)*T^2;
B = (1.0734E-5)-(8.5E-8)*T+(2.23E-10)*T^2;
mu_r = 1 + A*sal + B*sal^2;
mu_w = exp(-3.79418+(604.129/(139.18+T)));

mu = mu_r*mu_w*(10^-3);

end