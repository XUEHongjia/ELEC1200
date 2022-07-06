function rxtext=receive(rx_wave)
SPB=40;
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

