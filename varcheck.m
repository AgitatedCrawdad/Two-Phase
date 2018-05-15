function y=varcheck()
% varcheck makes sure that the first charcter for a run name begins with a
% letter
newName = input('Voltage of run, Enter as V### (e.g for 100V run enter V100):', 's');
TF = isstrprop(newName,'digit');
k =1;
if TF(1) == 1;
    while k == 1
        newName = input('Voltage of run, Enter as V### (e.g for 100V run enter V100):', 's');
        TF = isstrprop(newName,'digit');
        if TF(1) == 0;
            k = 0;
        end
    end
end
y=newName;