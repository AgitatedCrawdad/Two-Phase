function y=varcheck()
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