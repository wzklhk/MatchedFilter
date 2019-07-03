close all;
clear;
clc;

path = 'data/sin.txt';
[t, send_signal] = textread(path);
send_signal_mean = mean(send_signal);
send_signal_std = std(send_signal);
send_signal_autocorr = xcorr(send_signal);
send_signal_PSD = t2f(send_signal_autocorr, length(send_signal_autocorr));

receive_signal = MatchedFilter(send_signal);

receive_signal_mean = mean(receive_signal);
receive_signal_std = std(receive_signal);
receive_signal_autocorr = xcorr(receive_signal);
receive_signal_PSD = t2f(receive_signal_autocorr, length(receive_signal_autocorr));

figure(1);
plot(t, send_signal);
title('send signal');
xlabel('t');
ylabel('A');
figure(2);
plot(2 * t, receive_signal(1:2:end));
title('receive signal');
xlabel('t');
ylabel('Amplitude');

figure(3);
subplot(2, 1, 1);
plot(t, send_signal_autocorr(1:2:end));
title('send signal autocorr');
xlabel('t');
ylabel('Amplitude');
subplot(2, 1, 2);
plot(t, receive_signal_autocorr(1:4:end));
title('receive signal autocorr');
xlabel('t');
ylabel('Amplitude');

figure(4);
subplot(2, 1, 1);
plot(t, abs(send_signal_PSD(1:2:end)));
title('send signal PSD');
xlabel('f');
ylabel('Amplitude');
subplot(2, 1, 2);
plot(t, abs(receive_signal_PSD(1:4:end)));
title('receive signal PSD');
xlabel('f');
ylabel('Amplitude');

