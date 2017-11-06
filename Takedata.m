function y=Takedata(handle)
% import DAQConfig
% handle = DAQConfig();
%
% Demonstrates how to use the eReadNames (LJM_eReadNames) function using .NET.
%
% support@labjack.com
%

% clc %Clear the MATLAB command window
% clear %Clear the MATLAB variables
% 
% ljmAsm = NET.addAssembly('LabJack.LJM'); %Make the LJM .NET assembly visible in MATLAB
% 
% t = ljmAsm.AssemblyHandle.GetType('LabJack.LJM+CONSTANTS');
% LJM_CONSTANTS = System.Activator.CreateInstance(t); %creating an object to nested class LabJack.LJM.CONSTANTS
% 
% handle = 0;

try
    %Open first found LabJack
    %[ljmError, handle] = LabJack.LJM.OpenS('ANY', 'ANY', 'ANY', handle);
    %[ljmError, handle] = LabJack.LJM.Open(LJM_CONSTANTS.dtANY, LJM_CONSTANTS.ctANY, 'ANY', handle);

%     showDeviceInfo(handle);

    %Setup and call eReadNames to read values.
    numFrames = 9;
    aNames = NET.createArray('System.String', numFrames);
    aNames(1) = 'AIN0_EF_READ_A';
    aNames(2) = 'AIN2_EF_READ_A';
    aNames(3) = 'AIN4_EF_READ_A';
    aNames(4) = 'AIN6';
    aNames(5) = 'AIN8';
    aNames(6) = 'AIN10';
    aNames(7) = 'AIN12_EF_READ_A';
    aNames(8) = 'DIO0_EF_READ_A_F';
    aNames(9) = 'DIO0_EF_READ_B_F';
%     aNames(4) = 'RTC_TIME_S';
    aValues = NET.createArray('System.Double', numFrames);
    LabJack.LJM.eReadNames(handle, numFrames, aNames, aValues, 0);

    y=zeros(numFrames,1);
    for i = 1:numFrames
        y(i) = aValues(i);
    end

catch e
    showErrorMessage(e)
end

% try
%     % Close handle
%     LabJack.LJM.Close(handle);
% catch e
%     showErrorMessage(e)
% end
end