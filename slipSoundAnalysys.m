%%sound of slipping fft analyse
[y,Fs] = audioread('sound.flac');
totaltime=size(y,1)/Fs;

nonslip=y(20*Fs:23*Fs,1);
% for i1=1:size(nonslip,1)
%     nonslip(i1)=nonslip(i1)*((-1)^i1);
% end
subplot(2,1,1)
nonslipfft=fft([nonslip;nonslip*0]);
% plot(abs(nonslipfft))
plot(44100*(1:size(nonslipfft,1))/size(nonslipfft,1),abs(nonslipfft)/size(nonslipfft,1))
xlim([0,400])
% 
% xlim([1.31*10^5,1.34*10^5])
ylim([0,.025])

title('noslip')

a=17;
b=20;
slip=y(a*Fs:b*Fs,1);
% plot(slip)

% for i1=1:size(slip,1)
%     slip(i1)=slip(i1)*((-1)^i1);
% end
slipfft=fft([slip;slip*0]);
subplot(2,1,2)
plot(44100*(1:size(slipfft,1))/size(slipfft,1),abs(slipfft)/size(slipfft,1))
% xlim([1.31*10^5,1.34*10^5])
xlim([0,400])

ylim([0,.025])
title('slip')

% subplot(2,1,3)
% 
% plot(abs(slipfft-nonslipfft))
% xlim([1.31*10^5,1.34*10^5])


