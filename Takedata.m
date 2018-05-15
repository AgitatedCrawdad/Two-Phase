function y=Takedata(handle)

try


    %Setup and call eReadNames to read values.
    numFrames = 11;
    aNames = NET.createArray('System.String', numFrames);
    aNames(1) = 'AIN0_EF_READ_A';
    aNames(2) = 'AIN1_EF_READ_A';
    aNames(3) = 'AIN2_EF_READ_A';
    aNames(4) = 'AIN6';
    aNames(5) = 'AIN8';
    aNames(6) = 'AIN10';
    aNames(7) = 'AIN12_EF_READ_A';
    aNames(8) = 'DIO0_EF_READ_A_F'; 
    aNames(9) = 'DIO0_EF_READ_B_F';
    aNames(10) = 'AIN4';
    aNames(11) = 'AIN5';
%     aNames(4) = 'RTC_TIME_S';
    aValues = NET.createArray('System.Double', numFrames);
    LabJack.LJM.eReadNames(handle, numFrames, aNames, aValues, 0); %Reads values from Labjack

    y=zeros(numFrames,1);
    for i = 1:numFrames
        y(i) = aValues(i); %Writes values to variable y 
    end

catch e
    showErrorMessage(e)
end

end