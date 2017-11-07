function handle = DAQConfig()

clc %Clear the MATLAB command window
%clear %Clear the MATLAB variables

ljmAsm = NET.addAssembly('LabJack.LJM'); %Make the LJM .NET assembly visible in MATLAB

t = ljmAsm.AssemblyHandle.GetType('LabJack.LJM+CONSTANTS');
LJM_CONSTANTS = System.Activator.CreateInstance(t); %creating an object to nested class LabJack.LJM.CONSTANTS

handle = 0;

try
    %Open first found LabJack
    [ljmError, handle] = LabJack.LJM.OpenS('T7', 'ETHERNET', '470013205', handle);
%     showDeviceInfo(handle);
    
    %Setup and call eWriteNames to write values.
  %% SPECIFIES WHAT NAMES WILL HAVE VALUES ASSIGNED TO THEM
    numInputs = 47; %ADJUST ACCORDING TO NUMBER OF ADDRESSING WRITING
%     aNames = NET.createArray('System.String', numInputs);
    aNames = NET.createArray('System.String', numInputs);
    for i=0:2:4 %%This loop sets the names for 3 of thermocouples
        j = num2str(i);
        aNames(1+((i/2)*8)) = ['AIN' j '_EF_INDEX'];    %Specifies the type of thermocouple to be used
        aNames(2+((i/2)*8)) = ['AIN' j '_EF_CONFIG_B']; %Specifies that the CJC will be used from the DAQ
        aNames(3+((i/2)*8)) = ['AIN' j '_EF_CONFIG_D']; %slope for CJC reading
        aNames(4+((i/2)*8)) = ['AIN' j '_EF_CONFIG_E']; %offset for CJC reading
        aNames(5+((i/2)*8)) = ['AIN' j '_RANGE'];       %Range of voltage for TC
        aNames(6+((i/2)*8)) = ['AIN' j '_RESOLUTION_INDEX']; 
        aNames(7+((i/2)*8)) = ['AIN' j '_NEGATIVE_CH']; %Specifies negative channel (=AINX+1)
        aNames(8+((i/2)*8)) = ['AIN' j '_EF_CONFIG_A']; %Reads temp in Celsius
    end
    
    for i=6:2:10 %%This loop sets the names for the Pressure Transducers
        k = num2str(i);
        aNames(25+(((i-6)/2)*4)) = ['AIN' k '_EF_INDEX'];
        aNames(26+(((i-6)/2)*4)) = ['AIN' k '_NEGATIVE_CH'];
        aNames(27+(((i-6)/2)*4)) = ['AIN' k '_RESOLUTION_INDEX'];
        aNames(28+(((i-6)/2)*4)) = ['AIN' k '_RANGE'];
    end
    
    j = num2str(12);
    aNames(37) = ['AIN' j '_EF_INDEX'];    %Specifies the type of thermocouple to be used
    aNames(38) = ['AIN' j '_EF_CONFIG_B']; %Specifies that the CJC will be used from the DAQ
    aNames(39) = ['AIN' j '_EF_CONFIG_D']; %slope for CJC reading
    aNames(40) = ['AIN' j '_EF_CONFIG_E']; %offset for CJC reading
    aNames(41) = ['AIN' j '_RANGE'];       %Range of voltage for TC
    aNames(42) = ['AIN' j '_RESOLUTION_INDEX']; 
    aNames(43) = ['AIN' j '_NEGATIVE_CH']; %Specifies negative channel (=AINX+1)
    aNames(44) = ['AIN' j '_EF_CONFIG_A']; %Reads temp in Celsius
    
    
    aNames(45) = 'DIO0_EF_INDEX';
    aNames(46) = 'DIO_EF_CLOCK0_ENABLE';
    aNames(47) = 'DIO0_EF_ENABLE';
    
    
    
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
        aValues(5+(i*8)) = 0.1;    %Range of voltage for TC
        aValues(6+(i*8)) = 10;     %Resolution index
        aValues(7+(i*8)) = i*2+1;  %Negative Channel
        aValues(8+(i*8)) = 1;      %Read in Celsius
    end
    
    %Pressure Transducers
    for i = 0:2
        aValues(25+(i*4)) = 0;        %Index (0=disabled EF)
        aValues(26+(i*4)) = (i*2)+7;  %Negative channel
        aValues(27+(i*4)) = 12;       %Resolution index
        aValues(28+(i*4)) = 10;       %Voltage range
    end
    
    %Thermocouple at the end of the heater
    aValues(37) = 22;     %Specifies the type of Thermocouple(Type K)
    aValues(38) = 60052;  %Address of the CJC on the DAQ
    aValues(39) = 1.0;    %Slope for CJC reading
    aValues(40) = 0.0;    %Offset for CJC reading
    aValues(41) = 0.1;    %Range of voltage for TC
    aValues(42) = 12;     %Resolution index
    aValues(43) = 13;     %Negative Channel
    aValues(44) = 1;      %Read in Celsius
    
    
    aValues(45) = 3;  %Select rising or falling edges (3 or 4)
    aValues(46) = 1;  %Select Clock Source
    aValues(47) = 0;  %Turn on DIO_EF
    
    LabJack.LJM.eWriteNames(handle, numInputs, aNames, aValues, 0);

    aValues(47) = 1;  %Turn on DIO_EF

    LabJack.LJM.eWriteNames(handle, numInputs, aNames, aValues, 0);

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
