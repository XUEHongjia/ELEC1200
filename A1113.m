Fs = 44100; 
nBits = 16; 
nChannels = 2; 
ID = -1; % default audio input device 
 recObj = audiorecorder(Fs,nBits,nChannels,ID);
 disp('Start speaking.')
 recordblocking(recObj, 2);
 disp('End of Recording.');
 m = getaudiodata(recObj);
 filename = 'word_demo.wav';
 audiowrite(filename,m,Fs);
 % load your wav file 
 [z,Fs]= audioread('word_demo.wav');
 z1=z(1:88200);
 z2=z(88201:176400);
 z=[z1,z2];
 z=fseries(z);

load see_spectrum.mat
load car_spectrum.mat
load yes_spectrum.mat

m1=(z-x)*(z-x)';
m2=(z-y)*(z-y)';
m3=(z-n)*(z-n)';
M=[m1,m2,m3]
if m1==min(M) 
    disp('word_live is SEE' )
elseif m2==min(M)
    disp('word_live is CAR')
else
    disp('word_live is YES')
end
