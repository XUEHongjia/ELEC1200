% Let TA pick from the pre-recorded wav file or record your spoken word live:
Fs = 44100; 
nBits = 16; 
nChannels = 2 ; 
ID = -1;  % default audio input device 

% f-transform of the wavelength of 'see'
x=audioread('SEE.wav');
x=x'; % do a tanspose
x1=x(1:88200);
x2=x(88201:176400);
x=[x1,x2];
x=fseries(x);


% f-transform of the wavelength of 'car'
y=audioread('CAR.wav');
y=y'; % do a transpose
y1=y(1:88200);
y2=y(88201:176400);
y=[y1,y2];
y=fseries(y);

prompt = 'type 0 (record live), 1 (wav file 1) or 2 (wav file 2) then hit enter => ';
p = input(prompt);
if p == 0
 recObj = audiorecorder(Fs,nBits,nChannels,ID);
 disp('Start speaking.')
 recordblocking(recObj, 2);
 disp('End of Recording.');
 z = getaudiodata(recObj);
elseif p == 1
 [z, Fs] = audioread('SEE.wav');
 sound(z,Fs);
elseif p == 2
 [z,Fs] = audioread('CAR.wav');
 sound(z,Fs);
else
 disp('Error!');
end
% y <= speech sound samples
 z=z';
 z1=z(1:88200);
 z2=z(88201:176400);
 z=[z1,z2];
 z=fseries(z);

m1=(z-x)*(z-x)';
m2=(z-y)*(z-y)';
if m1 < m2 
    disp('word_live is SEE' )
    [X,Fs] = audioread('SEE.wav');
    sound(X,Fs);
else
    disp('word_live is CAR')
    [Y,Fs] = audioread('CAR.wav');
    sound(Y,Fs);
end
