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

 [z,Fs]= audioread('word_demo.wav');
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

