close all;
clear;
clc;

path = 'data/nsin.txt';
[t, send_signal] = textread(path);
fs = 1 / (t(2) - t(1)); % 抽样频率

[SEND_SIGNAL, f_send_shift] = t2f(send_signal, fs); % 求输入信号的频域
send_signal_mean = mean(send_signal);
send_signal_std = std(send_signal);
send_signal_autocorr = xcorr(send_signal);
% 根据维纳-辛钦定理，求输入信号自相关函数的频域得到功率谱密度
[send_signal_PSD, f_send_PSD_shift] = t2f(send_signal_autocorr, fs); 

receive_signal = MatchedFilter(send_signal); % 对输入信号匹配滤波

receive_signal_mean = mean(receive_signal);
receive_signal_std = std(receive_signal);
receive_signal_autocorr = xcorr(receive_signal);
% 根据维纳-辛钦定理，求输出信号自相关函数的频域得到功率谱密度
[receive_signal_PSD, f_receive_PSD_shift] = t2f(receive_signal_autocorr, fs); 

% 画图象
figure;
subplot(2, 1, 1);
plot(t, send_signal);
title('输入信号');
xlabel('t/s');
ylabel('A');
subplot(2, 1, 2);
plot(f_send_shift, abs(SEND_SIGNAL));
title('输入信号频域图');
xlabel('f/Hz');
ylabel('A');
set(gca, 'XLim', [-5, 5]);

figure;
plot(2 * t, receive_signal(1:2:end));
title('匹配滤波后的信号');
xlabel('t/s');
ylabel('A');

figure;
subplot(2, 1, 1);
plot(2 * t, send_signal_autocorr(1:2:end));
title('输入信号自相关函数');
xlabel('t/s');
ylabel('A');
subplot(2, 1, 2);
plot(4 * t, receive_signal_autocorr(1:4:end));
title('匹配滤波后信号自相关函数');
xlabel('t/s');
ylabel('A');

figure;
subplot(2, 1, 1);
plot(f_send_PSD_shift, abs(send_signal_PSD));
title('输入信号功率谱密度');
xlabel('f/Hz');
ylabel('A');
set(gca, 'XLim', [-2, 2]);
subplot(2, 1, 2);
plot(f_receive_PSD_shift, abs(receive_signal_PSD));
title('匹配滤波后信号功率谱密度');
xlabel('f/Hz');
ylabel('A');
set(gca, 'XLim', [-2, 2]);
