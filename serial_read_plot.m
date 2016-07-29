% Clear all the variables including serial object 
instrumentObjects=instrfind; % don't pass it anything - find all of them.
delete(instrumentObjects)
clear;
close all;
clc;
%-----------------------------------------------------

%----------------------------------------
% Setup Serial Port 
baudRate = 38400;
arduino = serial('COM3', 'BaudRate', baudRate);
fopen(arduino);
%-----------------------------------------

% Setup variables
acc_steps = 0 ;     % Accumulate steps
acc_data = 0;       % 
samples = 0;
startSpot = 0;
step = 0.01 ;        % lowering step has a number of cycles and then acquire more data


while ( 1 )    
    analog_val = fscanf(arduino, '%d'); %fread(arduino);
    samples = samples + 1;
    
%     disp(analog_val);
    voltage_val = analog_val * (5 / 1024);
    
%     disp(voltage_val);
%     disp(samples);
    
    fprintf('No of Sample : %d \t Digital Value : %d, \t Analog voltage %f\n', samples, analog_val, voltage_val);
    
    acc_data = [ acc_data, voltage_val ];      
    plot(acc_data) ;
        
      if ((acc_steps/step) - 200 < 0)
          startSpot = 0;
      else
          startSpot = (acc_steps/step)-200;
      end
      
      axis([startSpot (acc_steps/step+20) -1 6]);
      
      grid
      
      acc_steps = acc_steps + step;
      
      drawnow;
%       pause(0.01)
  end