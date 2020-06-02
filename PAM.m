%FIXING FREQUENCY OF CARRIER AND MESSAGE SIGNAL
clc;

fm=input('Enter message signal frequency (in Hz): ');
fc=input('Enter carrier signal frequency (in Hz): ');
fs=input('Enter sampling frequency       (in Hz): ');   %sampling frequency
t_bound=0.5;

%Creation of a Vector of Sampling Instants (Step Size of 1/fs)

samples=0:1/fs:t_bound;
samples= samples(1:end-1); %To have exactly 500 samples

%GENERATION OF SQUARE WAVE

duty = 20;
pulse = square(2*pi*fc*samples,duty);
pulse(pulse<0) = 0;
%plot(samples, pulse)

%MESSAGE SIGNAL
type=input('Type of message signal:\n    1. Sine\n    2. Cosine\n    3. Sine+Cosine\nEnter type: ');
switch(type)
    case 1
        m=sin(2*pi*fm*samples);
    case 2
        m=cos(2*pi*fm*samples);
    case 3
        m=sin(2*pi*fm*samples)+cos(2*pi*fm*samples);
    otherwise
        m=sin(2*pi*fm*samples);
end
%plot(samples, m)

%PAM WAVE
period_samp = 2*length(samples)/fc;         %No. of samples in each pulse duration
indices = 1:period_samp:length(samples);    %First sample in each pulse duration
on_samp = ceil(period_samp * duty/100);     %No. of samples during positive cycle
pam = zeros(1,length(samples));             %Setting it to 0
for i=1:length(indices)
   pam(indices(i):indices(i) + on_samp) = m(indices(i));
end
%plot(samples, pam)
%hold
%plot(samples, m)

%FINAL OUTPUT
subplot(3,1,1);
plot(samples,pulse,'r');
title('CARRIER SIGNAL');
xlabel({'Frequency','(in Hertz)'});
ylabel('Amplitude');


subplot(3,1,2);
plot(samples,m,'b');
title('MESSAGE SIGNAL');
xlabel({'Frequency','(in Hertz)'});
ylabel('Amplitude');

subplot(3,1,3);
plot(samples,pam,'g');
title('PULSE AMPLITUDE MODULATED SIGNAL');
xlabel({'Frequency','(in Hertz)'});
ylabel('Amplitude');
clc;
