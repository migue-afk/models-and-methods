info = audioinfo('Yabu_mono.wav')
[y,Fs] = audioread('Yabu_mono.wav');
t = 0:seconds(1/Fs):seconds(info.Duration);
t = t(1:end-1);
%figure,plot(t,y);
%sound(y,Fs)

%FOURIER TRANSFORM OF THE ORIGINAL WAVEFORM
Y=fft(y);
L=length(y);
P2=abs(Y/L);
P1=P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
        %FOURIER TRANSFORM OF THE ORIGINAL WAVEFORM
        f = Fs*(0:(L/2))/L;
        figure, plot(f,P1) 
        title('Fourier Transform of y(t)')
        xlabel('f (Hz)')
        ylabel('FT Magnitude')

%DETERMINATION OF FILTER COEFFICIENTS
Wp=[400 1000]/(Fs/2);
Ws=[200 1500]/(Fs/2);
Rp=1;
Rs=60;
[n, Wn]=ellipord(Wp, Ws, Rp,Rs);

%DEFINITION AND PLOT OF ELLIPTIC BANDPASS FILTER
[b,a] = ellip(n,Rp,Rs,Wn);  %SELECTED FREQUENCY FROM 301 Hz TO 5 kHz
[H,w] = freqz(b,a,512);   %filter frequency w (512 samples)  complex H (512 samples)
size(w)
size(H)
figure, plot(w*Fs/(2*pi),abs(H));
xlabel('Frequency (Hz)'); ylabel('Frequency Response');
grid;
        %FILTER APPLIED TO THE ORIGINAL AUDIO
        sf = filter(b,a,y);
        SF= fft(sf);
        L=length(y);
        P2=abs(SF/L);
        P1=P2(1:L/2+1);
        P1(2:end-1) = 2*P1(2:end-1);
            %PLOT OF FILTER APPLIED TO AUDIO
            f = Fs*(0:(L/2))/L;
            figure, plot(f,P1) 
            title('ELLIPTIC BANDPASS FILTER APPLIED')
            xlabel('f (Hz)')
            ylabel('FT Magnitude')
            sound(sf,Fs)

