fs = 144000
rec = audiorecorder(fs,16,1,1)

recordblocking(rec, 2);
y = getaudiodata(rec);
audiowrite('C:\Users\Roberto\Desktop\matlab Q6\Audio.wav',y,fs)
plot(y);
sound(5*y,fs)