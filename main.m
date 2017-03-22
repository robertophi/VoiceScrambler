clear all
clc


fc = 20000;
[x,fs] = audioread('C:\Users\Roberto\Desktop\matlab Q6\Audio.wav');
x = transpose(x);
 
x4 = scramble(x,fs,fc,0);
x_2 = scramble(x4,fs,fc,0);