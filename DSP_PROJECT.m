%STEP 1(18.03.2020)
% MyVoice = audiorecorder(44100,16,1); %audiorecorder of MATLAB
% recordblocking(MyVoice, 5); %limiting the time of audio
MyVoiceData= getaudiodata(MyVoice); %getting data of audio 
t1=linspace(0,5,220500); %time variable
% plot(t1,MyVoiceData) % plotting of the audio signal
% title('STEP 1'); %adding title of graph
% xlabel('Time');  %adding labels name
% ylabel('Audio Signal');


%STEP 2 (20.03.2020)
% save MyVoice.mat; %saving of the recorded audio to be .mat extension
load MyVoice.mat; %load .mat file
% filename= 'MyVoice.wav'; %creating any .wav file
% audiowrite(filename,MyVoiceData,44100); %writing from  recorded and saved .mat audio file to .wav file
% clear y Fs;
% [y,Fs]= audioread('MyVoice.wav'); %reading from .wav file 


% STEP 3(12.04.2020)
fs=44100; %sampling frequency
ts=1/fs; %sampling period
L=length(t); %length of time domain signal (audio signal)
Y=fft(MyVoiceData); %FFT of audio signal
f=linspace(0,44.1,length(Y)); %frequency vector
interval1=(f>=0 & f<=22.05); %first half part of frequency domain
Ydb=20*log10(abs(Y)); %convert magnitude to decibels
Yph=unwrap(angle(Y)); %phase response of original signal
% subplot(2,1,1); %choosing subplot
% plot(f(interval1),Ydb(interval1)) %plotting magnitude response of audio signal
% title('Magnitude Response of FFT'); %ading title
% xlabel('Frequency (kHz)'); %adding labels name
% ylabel('Magnitude (dB)');
% grid on; %adding grids
% subplot(2,1,2);
% plot(f(interval1),Yph(interval1)) %plotting phase response of audio signal
% title('Phase Response of FFT'); %adding title
% xlabel('Frequency(kHz)'); %adding labels name
% ylabel('Phase (\pi)');
% grid on;

%STEP 4 (14.04.2020)
mag1=max(abs(MyVoiceData)); %magnitude of Generareted audiotone
GnrSgn=(2*mag1*sin(2*pi*10000*t1))'; %generating tone signal
% plot(t1,GnrSgn) %plotting of generated signal 
% title('STEP 4'); %adding title
% xlabel('Time (sec)'); %adding labels name
% ylabel('Generated Signal');


%STEP 5 (14.04.2020)
DistSgn= GnrSgn+MyVoiceData;
% plot(t1,DistSgn) %plotting of generated signal 
% title('STEP 5'); %adding title
% xlabel('Time (sec)'); %adding labels name
% ylabel('Distorted Signal');

%STEP 6 (14.04.2020)
Z=fft(DistSgn);%FFT of distorted signal
Zdb=20*log10(abs(Z)); %convert magnitude to decibels
Zph=unwrap(angle(Z)); %phase response of original signal
% subplot(2,1,1); %choosing subplot
% plot(f(interval1),Zdb(interval1)) %plotting magnitude response of distorted signal
% title('Magnitude Response of FFT'); %ading title
% xlabel('Frequency (kHz)'); %adding labels name
% ylabel('Magnitude (dB)');
% grid on; %adding grids
% subplot(2,1,2); %choosing subplot
% plot(f(interval1),Zph(interval1)) %plotting phase response of distorted signal
% title('Phase Response of FFT'); %adding title
% xlabel('Frequency(kHz)'); %adding labels name
% ylabel('Phase (\pi)');
% grid on;


% STEP 7 (14.04.2020)
% subplot(3,1,1) %creating and choosing subplots
% plot(t1,MyVoiceData); %plotting original signal
% title('Original Signal'); %adding title
% xlabel('Time (sec)'); %adding labels name
% ylabel('Amplitude(V)');
% subplot(3,1,2)  %creating and choosing subplots
% plot(t1,GnrSgn); %plotting generated signal
% title('Generated Signal'); %adding title
% xlabel('Time (sec)');%adding labels name
% ylabel('Amplitude(V)');
% subplot(3,1,3)  %creating and choosing subplots
% plot(t1,DistSgn);%plotting distorted signal
% title('Distorted Signal'); %adding title
% xlabel('Time (sec)');%adding labels name
% ylabel('Amplitude(V)');

% STEP 8 (14.04.2020)
% subplot(2,2,1); %choosing subplot
% plot(f(interval1),Ydb(interval1)) %plotting magnitude response of audio signal
% title('Magnitude Response of FFT'); %ading title
% xlabel('Frequency (kHz)'); %adding labels name
% ylabel('Magnitude (dB)');
% grid on; %adding grids
% subplot(2,2,2);
% plot(f(interval1),Yph(interval1)) %plotting phase response of audio signal
% title('Phase Response of FFT'); %adding title
% xlabel('Frequency(kHz)'); %adding labels name
% ylabel('Phase (\pi)');
% grid on;
% subplot(2,2,3); %choosing subplot
% plot(f(interval1),Zdb(interval1)) %plotting magnitude response of distorted signal
% title('Magnitude Response of FFT'); %ading title
% xlabel('Frequency (kHz)'); %adding labels name
% ylabel('Magnitude (dB)');
% grid on; %adding grids
% subplot(2,2,4); %choosing subplot
% plot(f(interval1),Zph(interval1)) %plotting phase response of distorted signal
% title('Phase Response of FFT'); %adding title
% xlabel('Frequency(kHz)'); %adding labels name
% ylabel('Phase (\pi)');
% grid on;


%STEP 9(30.04.2020)
fpass=9490;
fstop=9990 ;%and also stopband frequency is equal to 6kHz
rp=0.001; %Passband ripple unit is dB
att=95; %Stopband attenuation is equal to twice of maximum number of magnitude response of original signal. 
fs=44100; %Sampling  frequency
%Designing filter that called minimum order of FIR Lowpass Filter
fltr=designfilt('lowpassfir','PassbandFrequency', fpass, 'StopbandFrequency', fstop, 'PassbandRipple', rp, 'StopbandAttenuation', att,'SampleRate',fs);


%STEP 10 (30.04.2020)
% fvtool(fltr) %Filter Visualization Tool

%STEP 11 (30.04.2020)
filteredSignal= filter(fltr,DistSgn); %Filtering the distorted signal via filter
% plot(t1, filteredSignal);
% title('STEP 11');%adding title
% xlabel('Time (sec)'); %adding labels name
% ylabel('Filtered Signal');

%Step 12 (30.04.2020)
W=fft(filteredSignal);%FFT of filtered signal
Wdb=20*log10(abs(W)); %convert magnitude to decibels
Wph=unwrap(angle(W)); %phase response of original signal
% subplot(2,1,1); %choosing subplot
% plot(f(interval1),Wdb(interval1)) %plotting magnitude response of filtered signal
% title('Magnitude Response of Filtered Signal'); %ading title
% xlabel('Frequency (kHz)'); %adding labels name
% ylabel('Magnitude (dB)');
% grid on; %adding grids
% subplot(2,1,2);
% plot(f(interval1),Wph(interval1)) %plotting phase response of filtered signal
% title('Phase Response of Filtered Signal'); %adding title
% xlabel('Frequency(kHz)'); %adding labels name
% ylabel('Phase (\pi)');
% grid on;



% STEP 13(30.04.2020)
% subplot(3,2,1); %choosing subplot
% plot(f(interval1),Ydb(interval1)) %plotting magnitude response of audio signal
% title('Magnitude Response of Original Signal'); %ading title
% xlabel('Frequency (kHz)'); %adding labels name
% ylabel('Magnitude (dB)');
% grid on; %adding grids
% subplot(3,2,2);
% plot(f(interval1),Yph(interval1)) %plotting phase response of audio signal
% title('Phase Response of Original Signal'); %adding title
% xlabel('Frequency(kHz)'); %adding labels name
% ylabel('Phase (\pi)');
% grid on;
% subplot(3,2,3); %choosing subplot
% plot(f(interval1),Zdb(interval1)) %plotting magnitude response of distorted signal
% title('Magnitude Response of Distorted Signal'); %ading title
% xlabel('Frequency (kHz)'); %adding labels name
% ylabel('Magnitude (dB)');
% grid on; %adding grids
% subplot(3,2,4); %choosing subplot
% plot(f(interval1),Zph(interval1)) %plotting phase response of distorted signal
% title('Phase Response of Distorted Signal'); %adding title
% xlabel('Frequency(kHz)'); %adding labels name
% ylabel('Phase (\pi)');
% grid on;
% subplot(3,2,5); %choosing subplot
% plot(f(interval1),Wdb(interval1)) %plotting magnitude response of filtered signal
% title('Magnitude Response of Filtered Signal'); %ading title
% xlabel('Frequency (kHz)'); %adding labels name
% ylabel('Magnitude (dB)');
% grid on; %adding grids
% subplot(3,2,6);%choosing subplot
% plot(f(interval1),Wph(interval1)) %plotting phase response of filtered signal
% title('Phase Response of Filtered Signal'); %adding title
% xlabel('Frequency(kHz)'); %adding labels name
% ylabel('Phase (\pi)');
% grid on;



%STEP 14 (30.04.2020)
interval=(t1>1.5 & t1<=1.55); %time interval such that 0.05 seconds
% plot(t1(interval),MyVoiceData(interval),'b') %plotting original signal that between the time interval
% hold on % keep plotting other signal in same window
% plot(t1(interval),filteredSignal(interval), 'm') %plotting filtered signal that between the time interval
% hold on % keep plotting other signal in same window
% legend('Original Signal','Filtered Signal'); %adding legend
% title('STEP 14'); %adding title
% xlabel('Time (sec)'); %adding labels name
% ylabel('Amplitude(V)');

%STEP 15 (30.04.2020)
delay = mean(grpdelay(fltr)); %delay caused by the filter.
t2=t1(1:end-delay); %compensated time vector
compensatedSignal = filteredSignal; %compensated signal is equal to time shift of filtered signal that shift by #delay samples
compensatedSignal(1:delay)= []; %remove the last delay samples
% plot(t2,compensatedSignal); %plotting compensated signal
% title('STEP 15'); %adding title
% xlabel('Time (sec)'); %adding labels name
% ylabel('Amplitude(V)');


%STEP 16 (03.05.2020)
X=fft(compensatedSignal); %FFT of compensated signal
Xdb=20*log10(abs(X)); %convert magnitude to decibels
Xph=unwrap(angle(X)); %phase response of compensated signal
% subplot(2,1,1); %choosing subplot
% plot(f(interval1),Xdb(interval1)) %plotting magnitude response of compensated signal
% title('Magnitude Response of Compensated Signal'); %ading title
% xlabel('Frequency (kHz)'); %adding labels name
% ylabel('Magnitude (dB)');
% grid on; %adding grids
% subplot(2,1,2);
% plot(f(interval1),Xph(interval1)) %plotting phase response of compensated signal
% title('Phase Response of Compensated Signal'); %adding title
% xlabel('Frequency(kHz)'); %adding labels name
% ylabel('Phase (\pi)');
% grid on;


% %STEP 17 (03.05.2020)
% subplot(3,2,1); %choosing subplot
% plot(f(interval1),Ydb(interval1)) %plotting magnitude response of audio signal
% title('Magnitude Response of Original Signal'); %ading title
% xlabel('Frequency (kHz)'); %adding labels name
% ylabel('Magnitude (dB)');
% grid on; %adding grids
% subplot(3,2,2);
% plot(f(interval1),Yph(interval1)) %plotting phase response of audio signal
% title('Phase Response of Original Signal'); %adding title
% xlabel('Frequency(kHz)'); %adding labels name
% ylabel('Phase (\pi)');
% grid on;
% subplot(3,2,3); %choosing subplot
% plot(f(interval1),Wdb(interval1)) %plotting magnitude response of filtered signal
% title('Magnitude Response of Filtered Signal'); %ading title
% xlabel('Frequency (kHz)'); %adding labels name
% ylabel('Magnitude (dB)');
% grid on; %adding grids
% subplot(3,2,4);%choosing subplot
% plot(f(interval1),Wph(interval1)) %plotting phase response of filtered signal
% title('Phase Response of Filtered Signal'); %adding title
% xlabel('Frequency(kHz)'); %adding labels name
% ylabel('Phase (\pi)');
% grid on;
% subplot(3,2,5); %choosing subplot
% plot(f(interval1),Xdb(interval1)) %plotting magnitude response of compensated signal
% title('Magnitude Response of Compensated Signal'); %ading title
% xlabel('Frequency (kHz)'); %adding labels name
% ylabel('Magnitude (dB)');
% grid on; %adding grids
% subplot(3,2,6);
% plot(f(interval1),Xph(interval1)) %plotting phase response of compensated signal
% title('Phase Response of Compensated Signal'); %adding title
% xlabel('Frequency(kHz)'); %adding labels name
% ylabel('Phase (\pi)');
% grid on;

%STEP 18 (03.05.2020)
% subplot(2,1,1);
% plot(t1(interval),MyVoiceData(interval),'b') %plotting original signal that between the time interval
% hold on % keep plotting other signal in same window
% plot(t1(interval),filteredSignal(interval), 'm') %plotting filtered signal that between the time interval
% hold on % keep plotting other signal in same window
% legend('Original Signal','Filtered Signal'); %adding legend
% title('STEP 14'); %adding title
% xlabel('Time (sec)'); %adding labels name
% ylabel('Amplitude(V)');
% subplot(2,1,2);
% plot(t1(interval),MyVoiceData(interval),'b') %plotting original signal that between the time interval
% hold on % keep plotting other signal in same window
% plot(t1(interval),compensatedSignal(interval), 'm') %plotting compensated signal that between the time interval
% hold on % keep plotting other signal in same window
% legend('Original Signal','Compensated Signal'); %adding legend
% title('STEP 14'); %adding title
% xlabel('Time (sec)'); %adding labels name
% ylabel('Amplitude(V)');

% %STEP 19
% sound(MyVoice); %playing original signal
% sound(GnrSgn); %playing generated signal
% sound(DistSgn); %playing distorted signal
% sound(filteredSignal); %playing filtered signal
% sound(compensatedSignal); %playing compensated signal

