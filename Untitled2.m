clear all;
clc;

fs = 48000;
D = 2;
t = linspace(0,D,D*fs);
fm = 300; %fm = 440*2^((-5)/12); % fm = 261.6256 (do' medio)
x = cos(2*pi*fm*t);
Px = mean(x.^2);
figure(1); plot(t,x,'b-'); axis([0 0.02 -1.1 1.1])
SNR_dB = 0;
SNR = 10^(SNR_dB/10);
Pz = Px/SNR;
z = sqrt(Pz)*randn(1,length(t));
figure(2); plot(t,z,'b-'); xlim([0 0.02]); %axis([0 0.02 -1.1 1.1])
y = x+z;
figure(3); plot(t,y,'b-'); xlim([0 0.02]);

%break

%sound(x,fs)
%sound(z,fs)
%sound(y,fs)

N = length(t);
f0 = fs/N;
f = (-floor(N/2)+[0:N-1])*f0;

W = 350;
X = fftshift(fft((x)))/fs;
Y = fftshift(fft((y)))/fs;
V = Y.*(abs(f)<W);
v = fftshift(ifft(ifftshift(V)))*fs;

hold off;
figure(4);
subplot(2,1,1); hold off;
plot(t,y,'b-','LineWidth',2); 
%hold on;
%plot(t,v,'r-','LineWidth',2);
ylim([-max(abs(y)) max(abs(y))]); xlim([D/2 D/2+5/fm]);
subplot(2,1,2);  hold off;
plot(f,abs(Y),'b-','LineWidth',2); 
%hold on;
%plot(f,abs(V),'r-','LineWidth',2);
%plot([-W -W W W],[-10 10 10 -10],'k--');
%ylim([0 0.03]); xlim([-fs/24 fs/24]);
hold off;

hold off;
figure(5);
subplot(2,1,1); hold off;
plot(t,y,'b-','LineWidth',2); hold on;
plot(t,v,'r-','LineWidth',2);
ylim([-max(abs(y)) max(abs(y))]); xlim([D/2 D/2+5/fm]);
subplot(2,1,2);  hold off;
plot(f,abs(Y),'b-','LineWidth',2); hold on;
plot(f,abs(V),'r-','LineWidth',2);
%plot([-W -W W W],[-10 10 10 -10],'k--');
ylim([0 0.03]); xlim([-fs/24 fs/24]);
hold off;
