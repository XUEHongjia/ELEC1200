SPB=40;

textbit=text2bitseq(textmsg);
textwave=bitseq2waveform(textbit,SPB);
training0=zeros(1,200);
training1=ones(1,200);
training2=zeros(1,200);
trainingseq=[training0,training1,training2];

textwave1 = [ones(1,SPB),trainingseq,textwave];   

rx_wave=txrx(textwave1);

ind=find_start(rx_wave);    %<=???
training_rx0=rx_wave(1:ind);
training_rx1=rx_wave(1:ind+400);
c=min(training_rx1);
k=max(training_rx1)-c;
b=max(training_rx0);
a=(1-b/k)^(SPB+1);
decoded_rx=zeros(1,length(rx_wave));
decoded_rx(1)=rx_wave(1)/[k*(1-a)];
for m=2:length(rx_wave)
    decoded_rx(m)=(rx_wave(m)-a*rx_wave(m-1))/(k*(1-a));
end
for n=1:ind
    if training_rx0(n)==max(training_rx0)
        start=n
    end
end
threshold=[max(decoded_rx)+min(decoded_rx)]/2;
start=start+600
rxbit=zeros(1,3896);
 for i=1:3896
     if decoded_rx(start+i*SPB)>=threshold;
         decoded_rx(start+i*SPB)=1;
         rxbit(i)=decoded_rx(start+i*SPB);
     else
         decoded_rx(start+i*SPB)=0;
         rxbit(i)=decoded_rx(start+i*SPB);
     end
end
rxtext=bitseq2text(rxbit);
compute_BER(rxbit,rxtext)
a=decoded_rx(1:5*ind);
t=1:5*ind;
plot(t,a)
