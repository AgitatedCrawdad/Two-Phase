classdef Temp
   properties
      Value
      Time
      T1
   end
   methods
      function obj = Temp(F)
         if nargin ~= 0
            m = size(F,1);
            n = size(F,2);
            obj(m,n) = Temp;
            for i = 1:m
               for j = 1:n
                  obj(i,j).Value = F(i,j);
               end
            end
            for i = 1:m
                obj(i,1).Time = F(i,1);
                obj(i,1).T1 = obj(i,2).Value; 
            end
         
         end
      end
      function r = print(obj,n)
          r = obj(:,n).Value;
      end
      function r = temps(obj,n)
          r = plot(obj(:,1).Value,obj(:,n).Value);
      end
   end
end