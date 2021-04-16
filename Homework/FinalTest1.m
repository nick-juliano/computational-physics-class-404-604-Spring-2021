%Attempt to read audio files
%http://homepages.udayton.edu/~hardierc/ece203/sound.htm FOR REFERENCE

clear, clc

[fmty,fs]=wavread('FromMeToYou.wav');

fmtyp=fmty(1411200:2072699); 

dt=1/fs;
T=1/fs; %period
TT=15; %total time
w=2*pi/T;

dw=2*pi()/T;
W=2*pi()/dt;

%%FASTER CODE SANS LOOPS%%

a0=[(fmtyp.*dt)];

t=[(1*dt:dt:15*fs*dt)];
w=[(1*dw:dw:15*fs*dw)];
a=[2*fmtyp.*cos(w.*t)];
b=[2*fmtyp.*sin(w.*t)];
c=[sqrt(a.*a+b.*b)];

%a(20000:60000)=a(20000:60000).*a(20000:60000);

ff2=[a0/2+.5*a.*cos((fs*dw)*(fs*dt))+.5*b.*sin((fs*dw)*(fs*dt))];
%add (/2)next to a0 to make normal again

figure(1)
plot(t,fmtyp)
title('Wave for 32-47 seconds From Me To You Signal')

figure(2)
plot(w,a,'b',w,b,'g',w,c,'r')
title('Coefficient Values')

figure(3)
plot(t,ff2)
title('32-47 seconds From Me To You Signal Reproduced with coefficients')

figure(4)
plot(t(1:600),fmtyp(1:600))
grid on
title('Wave for first 600 bits of FMTYP')
xlabel('Time(s)')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x=audioplayer(fmtyp,fs)
y=audioplayer(ff2,fs)

N=length(fmtyp);

Y=fft(fmtyp,fs);
Y=Y(1:N/2+1);
%psdY=(1/(fs*N))*abs(Y).^2 ;%PowerSpectralDensity
%psdY(2:end-1)=2*psdY(2:end-1);
psdY=Y.*conj(Y)/fs;
freq=0:fs/length(fmtyp):fs/2;
figure(5)
plot(freq,10*log10(psdY)) 
grid on
title('Periodogram Using FFT')
xlabel('Frequency (Hz)')
ylabel('Logged Power/Fequency (dB/Hz)')


Z=fft(ff2,fs);
psdZ=Z.*conj(Z)/fs; 
freq=fs*(1:fs)/fs;
figure(6)
plot(freq,10*log10(psdZ)) %logged 
grid on
title('Frequency content of fmtyp')
xlabel('frequency(Hz)')
ylabel('Logged Power/Frequency')
