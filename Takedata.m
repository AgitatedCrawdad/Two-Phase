function y=Takedata()
import DAQConfig
handle = DAQConfig();
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
    numFrames = 3;
    aNames = NET.createArray('System.String', numFrames);
    aNames(1) = 'AIN0_EF_READ_A';
    aNames(2) = 'AIN2_EF_READ_A';
    aNames(3) = 'AIN4_EF_READ_A';
%     aNames(4) = 'RTC_TIME_S';
    aValues = NET.createArray('System.Double', numFrames);
    LabJack.LJM.eReadNames(handle, numFrames, aNames, aValues, 0);

    disp('eReadNames results:')
    y=aValues(1);
%     for i=1:numFrames,
%         disp(['  Name: ' char(aNames(i)) ', value: ' num2str(aValues(i))])
%     end
%     pause(2.5)
catch e
    showErrorMessage(e)
end

try
    % Close handle
    LabJack.LJM.Close(handle);
catch e
    showErrorMessage(e)
end
end