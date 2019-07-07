close all;
clear;
clc;

fs = 50; % 抽样频率
t = -10:1 / fs:10 - 1 / fs;

sin_signal = sin(2 * pi * 1 * t);

for i = 1:length(sin_signal)

    if sin_signal(i) > 0
        squ_signal(i) = 1;
    else
        squ_signal(i) = 0;
    end

end

sin_signal_noise = awgn(sin_signal, 5); % 向正弦波信号加入信噪比为5dB的高斯白噪声
squ_signal_noise = awgn(squ_signal, 5); % 向方波信号加入信噪比为5dB的高斯白噪声

fid = fopen('data/nsin.txt', 'w');

for i = 1:length(sin_signal_noise)
    fprintf(fid, '%f %f\r\n', t(i), sin_signal_noise(i));
end

fclose(fid);

plot(t, sin_signal_noise);
