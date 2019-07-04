close all;
clear;
clc;

path = 'data/sin.txt';
[t, send_signal] = textread(path);
FS = 1 / (t(2) - t(1));

SEND_SIGNAL = fftshift(fft(send_signal)); % FT(send_signal)
f_send_signal_shift = (-length(send_signal) / 2:length(send_signal) / 2 - 1) * (FS / length(send_signal));
send_signal_mean = mean(send_signal);
send_signal_std = std(send_signal);
send_signal_autocorr = xcorr(send_signal);
send_signal_PSD = fftshift(fft(send_signal_autocorr)); %FT(send_signal_autocorr)
f_send_signal_PSD_shift = (-length(send_signal_autocorr) / 2:length(send_signal_autocorr) / 2 - 1) * (FS / length(send_signal_autocorr));

receive_signal = MatchedFilter(send_signal);

receive_signal_mean = mean(receive_signal);
receive_signal_std = std(receive_signal);
receive_signal_autocorr = xcorr(receive_signal);
receive_signal_PSD = fftshift(fft(receive_signal_autocorr)); %FT(receive_signal_autocorr)
f_receive_signal_PSD_shift = (-length(receive_signal_autocorr) / 2:length(receive_signal_autocorr) / 2 - 1) * (FS / length(receive_signal_autocorr));


% plot function
figure;
subplot(2, 1, 1);
plot(t, send_signal);
title('send signal');
xlabel('t/s');
ylabel('A');

subplot(2, 1, 2);
plot(f_send_signal_shift', abs(SEND_SIGNAL));
title('send signal frequency');
xlabel('f/Hz');
ylabel('A');
set(gca, 'XLim', [-2, 2]);

figure;
plot(2 * t, receive_signal(1:2:end));
title('receive signal');
xlabel('t/s');
ylabel('A');

figure;
subplot(2, 1, 1);
plot(t, send_signal_autocorr(1:2:end));
title('send signal autocorr');
xlabel('t/s');
ylabel('A');

subplot(2, 1, 2);
plot(t, receive_signal_autocorr(1:4:end));
title('receive signal autocorr');
xlabel('t/s');
ylabel('A');

figure;
subplot(2, 1, 1);
plot(f_send_signal_PSD_shift', abs(send_signal_PSD));
title('send signal PSD');
xlabel('f/Hz');
ylabel('A');
set(gca, 'XLim', [-2, 2]);

subplot(2, 1, 2);
plot(f_receive_signal_PSD_shift', abs(receive_signal_PSD));
title('receive signal PSD');
xlabel('f/Hz');
ylabel('A');
set(gca, 'XLim', [-2, 2]);
