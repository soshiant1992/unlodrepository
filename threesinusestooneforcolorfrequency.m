%% test for adding three sinuses to see the shape
clear;
clc;
close all;
t=0:.0001:.2;
red=sin(450*t);
blue=sin(630*t);
green=sin(570*t);
mono=red+green+blue;
plot(t,mono);
figure(2)
scatter(real(fft(mono)),imag(fft(mono)))

figure(3)
plot(1./t,abs(fft(mono))/.2);
xlim([0,900])


















