function [y, fshift] = t2f(x, fs)
    % t2f - Description
    % 时域变换到频域
    % 
    % Syntax: [y, fshift] = t2f(x, fs)
    %
    % x 时域信号
    % fs 抽样频率
    % y 频域信号
    % fshift 频域横坐标
    y = fftshift(fft(x));
    fshift = [(-length(x) / 2:length(x) / 2 - 1) * (fs / length(x))]';
end
