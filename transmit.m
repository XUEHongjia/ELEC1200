function textwave1 = transmit(textmsg)
SPB=40;

textbit = text2bitseq(textmsg);
textwave = bitseq2waveform(textbit,SPB);
training0 = zeros(1,200);
training1 = ones(1,200);
training2 = zeros(1,200);
trainingseq = [training0,training1,training2];

textwave1 = [ones(1,SPB),trainingseq,textwave];   
