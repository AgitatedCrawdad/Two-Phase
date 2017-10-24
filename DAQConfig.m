function handle = DAQConfig()
% %function [ output_args ] = WriteDAQ( ConfigFile )
% %WriteDAQ Reads analog inputs from DAQ 1 time
% %   Detailed explanation goes here
% load(ConfigFile);
% NumChannels=length(Ain);

clc %Clear the MATLAB command window
%clear %Clear the MATLAB variables

ljmAsm = NET.addAssembly('LabJack.LJM'); %Make the LJM .NET assembly visible in MATLAB

t = ljmAsm.AssemblyHandle.GetType('LabJack.LJM+CONSTANTS');
LJM_CONSTANTS = System.Activator.CreateInstance(t); %creating an object to nested class LabJack.LJM.CONSTANTS

handle = 0;

try
    %Open first found LabJack
    [ljmError, handle] = LabJack.LJM.OpenS('T7', 'ETHERNET', '470013205', handle);
    %[ljmError, handle] = LabJack.LJM.Open(LJM_CONSTANTS.dtANY, LJM_CONSTANTS.ctANY, 'ANY', handle);
%     showDeviceInfo(handle);
    
    %Setup and call eWriteNames to write values.
  %% SPECIFIES WHAT NAMES WILL HAVE VALUES ASSIGNED TO THEM
    numInputs = 24; %ADJUST ACCORDING TO NUMBER OF ADDRESSING WRITING
%     aNames = NET.createArray('System.String', numInputs);
    aNames = NET.createArray('System.String', numInputs);
    for i=0:2:4
        j = num2str(i);
        aNames(1+((i/2)*8)) = ['AIN' j '_EF_INDEX'];    %Specifies the type of thermocouple to be used
        aNames(2+((i/2)*8)) = ['AIN' j '_EF_CONFIG_B']; %Specifies that the CJC will be used from the DAQ
        aNames(3+((i/2)*8)) = ['AIN' j '_EF_CONFIG_D']; %slope for CJC reading
        aNames(4+((i/2)*8)) = ['AIN' j '_EF_CONFIG_E']; %offset for CJC reading
        aNames(5+((i/2)*8)) = ['AIN' j '_RANGE'];
        aNames(6+((i/2)*8)) = ['AIN' j '_RESOLUTION_INDEX'];
        aNames(7+((i/2)*8)) = ['AIN' j '_NEGATIVE_CH'];
        aNames(8+((i/2)*8)) = ['AIN' j '_EF_CONFIG_A'];
    end


    % EF INDEX VALUES FOR THERMOCOUPLES
    % 20: Thermocouple type E
    % 21: Thermocouple type J
    % 22: Thermocouple type K
    % 23: Thermocouple type R
    % 24: Thermocouple type T
    % 25: Thermocouple type S
    % 30: Thermocouple type C
    
    %EXAMPLE
    % AIN3_EF_INDEX = 22           // feature index for type K thermocouple
    % AIN3_EF_CONFIG_B = 60052     // CJC source, address for device temperature sensor
    % AIN3_EF_CONFIG_D = 1.0       // slope for CJC reading
    % AIN3_EF_CONFIG_E = 0.0       // offset for CJC reading
   
    %% ASSIGNS VALUES TO THE NAMES THAT WERE PREVIOUSLY SPECIFIED
    aValues = NET.createArray('System.Double', numInputs);
    for i = 0:2
        aValues(1+(i*8)) = 22;     %Specifies the type of Thermocouple(Type K)
        aValues(2+(i*8)) = 60052;  %Address of the CJC on the DAQ
        aValues(3+(i*8)) = 1.0;    %Slope for CJC reading
        aValues(4+(i*8)) = 0.0;    %Offset for CJC reading
        aValues(5+(i*8)) = 0.1;
        aValues(6+(i*8)) = 10;
        aValues(7+(i*8)) = i*2+1;
        aValues(8+(i*8)) = 1;
    end

    LabJack.LJM.eWriteNames(handle, numInputs, aNames, aValues, 0);
%     disp('eWriteNames:');
%     for i=1:numInputs,
%         disp(['  Name: ' char(aNames(i)) ', value: ' num2str(aV(i))])
%     end
%     
    aValues = NET.createArray('System.Double', numInputs);
    
    AIN = NET.createArray('System.String', numInputs);
    AIN(1) = 'AIN0_EF_READ_A';
    LabJack.LJM.eReadNames(handle, 1, AIN, aValues, 0);
%     disp(['  Name: ' char(AIN(1)) ', value: ' num2str(aValues(1))])
%     for i=1:numInputs,
%         disp(['  Name: ' char(aNames(i)) ', value: ' num2str(aValues(i))])
%     end

catch e
    showErrorMessage(e)
end
% 
% try
%     % Close handle
%     LabJack.LJM.Close(handle);
% catch e
%     showErrorMessage(e)
% end

end
