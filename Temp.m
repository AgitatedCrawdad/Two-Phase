classdef Temp
   properties
      Value
      Time
      T1
      T2
      T3
      T4
      Ts
      T1S
      T2S
      T3S
      T4S
      P1
      P2
      P3
      Ps
      M
      Name
   end
   methods
      function obj = Temp(F)
          %{
          This is the constructor function used to create the intial
          variables once the input matrix has been entered. It is important
          that columns of the matrix follow the variable order below (i.e
          first 3 columns=Thermocouple (TC) data, the next 3 = Pressure Transducer(PT) data and then Mass Flow rate)
          
          %}
         if nargin ~= 0
             obj.Value = F;
             obj.Time = F(:,1); %Time
             obj.T1 = F(:,2); 
             obj.T2 = F(:,3);
             obj.T3 = F(:,4);
             obj.T4 = F(:,5); 
             obj.P1 = F(:,6); 
             obj.P2 = F(:,7); 
             obj.P3 = F(:,8);
             obj.M = F(:,9); 
             
             obj.Ts = F(:,2:5);
             obj.Ps = F(:,6:8);
             
         end
         
         m = size(obj.Time,1);
         
         for i = 2:m %This for loop is used to convert the date/time column into seconds
            if i == 2
                temp = obj.Time(i-1);
            end
            tdif = (obj.Time(i)-temp);
            temp = obj.Time(i);
            obj.Time(1) = 0;
            obj.Time(i) = tdif+obj.Time(i-1);
         end
         m = length(obj.T1);
         obj.T1S = zeros(m-2,1);
         obj.T2S = zeros(m-2,1);
         obj.T3S = zeros(m-2,1);
         obj.T4S = zeros(m-2,1);
         for i=1:m-2
              if i == 1;
                  obj.T1S(i,1) = obj.T1(i);
                  obj.T2S(i,1) = obj.T2(i);
                  obj.T3S(i,1) = obj.T3(i);
                  obj.T4S(i,1) = obj.T4(i);
              elseif i == 2
                  obj.T1S(i) = mean(obj.T1(1:3));
                  obj.T2S(i) = mean(obj.T2(1:3));
                  obj.T3S(i) = mean(obj.T3(1:3));
                  obj.T4S(i) = mean(obj.T4(1:3));
              else
                  obj.T1S(i) = mean(obj.T1(i-2:i+2));
                  obj.T2S(i) = mean(obj.T2(i-2:i+2));
                  obj.T3S(i) = mean(obj.T3(i-2:i+2));
                  obj.T4S(i) = mean(obj.T4(i-2:i+2));
              end
          end
      end
      function r = temps(obj) %This function is used to plot the unfiltered thermocouple(TC) data
          figure
          r = plot(obj.Time,obj.T1,obj.Time,obj.T2,obj.Time,obj.T3,obj.Time,obj.T4);
          legend('T1', 'T2', 'T3','T4');
          axes3=gca;
          set(axes3,'FontName','Times New Roman','FontSize',28,'Layer','top','LineWidth',3);
          xlabel('Time [s]')
          ylabel('Temperature [°C]')
          grid on
          g=gcf;
          g.Units='inches';
          g.Position=[-19.9896 0.4271 12.7708 9.1875];
      end
      function r = smoothtemps(obj) %This function is used to plot the filtered TC data using a moving average
          figure;
          r = plot(obj.Time(1:length(obj.T1S)),obj.T1S,obj.Time(1:length(obj.T1S)),obj.T2S,obj.Time(1:length(obj.T1S)),obj.T3S,obj.Time(1:length(obj.T1S)),obj.T4S);
          legend('T1','T2','T3','T4')
          axes3=gca;
          set(axes3,'FontName','Times New Roman','FontSize',28,'Layer','top','LineWidth',3);
          xlabel('Time [s]')
          ylabel('Temperature [°C]')
          grid on
          g=gcf;
          g.Units='inches';
          g.Position=[-19.9896 0.4271 12.7708 9.1875];
      end
      function r = press(obj) %This function plots the unfiltered PT data
          figure
          r = plot(obj.Time,obj.P1,obj.Time,obj.P2,obj.Time,obj.P3);
          legend('P1', 'P2', 'P3');
          axes3=gca;
          set(axes3,'FontName','Times New Roman','FontSize',28,'Layer','top','LineWidth',3);
          xlabel('Time [s]')
          ylabel('Temperature [°C]')
          grid on
          g=gcf;
          g.Units='inches';
          g.Position=[-19.9896 0.4271 12.7708 9.1875];
      end
      function r = mass(obj) %This function plots the filtered Mass Flow rate data using a moving average
          figure;
          m = length(obj.T1);
          Mass = zeros(m-2,1);
          for i=1:m-2
              if i == 1;
                  Mass(i,1) = obj.M(i);
              elseif i == 2
                  Mass(i) = mean(obj.M(i:3));
              else
                  Mass(i) = mean(obj.M(i-2:i+2));
              end
          end
          r = plot(obj.Time(1:length(Mass)),Mass);
%            hold on
%            plot(obj.Time,obj.M);
          legend('M');
          axes3=gca;
          set(axes3,'FontName','Times New Roman','FontSize',28,'Layer','top','LineWidth',3);
          xlabel('Time [s]');
          ylabel('Mass Flow Rate [g/s]');
          g=gcf;
          g.Units='inches';
          g.Position=[-19.9896 0.4271 12.7708 9.1875];
      end
   end
end
