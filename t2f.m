function X = t2f(x, dt)
    X = fftshift(fft(x)) * dt;
end
