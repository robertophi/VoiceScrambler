function [ x4 ] = scramble( x, fs,fc, plotAll )

    D = 2;
    t = linspace(0,D,D*fs);
    fm = 4000; %fm = 440*2^((-5)/12); % fm = 261.6256 (do' medio)
    fc2 = fc+5000;
    frequencia_FPA= fc;
    frequencia_FPB= fc;
    carrier = 2*cos(2*pi*fc*t);
    x1 = x.*carrier;




    %criando as variáveis auxiliares, f, N, f0, etc.
    N = length(t);
    f0 = fs/N;
    f = (-floor(N/2)+[0:N-1])*f0;


    %transformadas de x e x1
    X = fftshift(fft((x)))/fs;
    X1 = fftshift(fft(x1))/fs;


    %filtro passa alta, frequencia de corte
    X2 = X1.*(abs(f)>frequencia_FPA);
    x2 = fftshift(ifft(ifftshift(X2)))*fs;

    carrier2 = 2*cos(2*pi*fc2*t);
    x3 = x2.*carrier2;
    X3 = fftshift(fft(x3))/fs;

    X4 = X3.*(abs(f)<frequencia_FPB);
    x4 = fftshift((ifft(ifftshift(X4))))*fs;






    %------------------------------------------
    %plot de x e X
    figure(1);
    subplot(2,1,1); 
    plot(t,x,'b-','LineWidth',2); 
    ylim([-max(abs(x)) max(abs(x))]); 
    %xlim([D/2 D/2+5/fm]);
    title('Plot 1: x(t)');

    subplot(2,1,2); 
    plot(f,abs(X),'b-','LineWidth',2); 
    title('Plot 2: X(f)');
    xlim([-10000 10000]);

    %------------------------------------------




    if plotAll == 1
        %------------------------------------------
        figure(2);
        subplot(2,2,1);
        plot(t,x1,'b-','LineWidth',2); 
        ylim([-max(abs(x1)) max(abs(x1))]); 
        %xlim([D/2 D/2+5/fm]);
        title('Plot 3: x1(t)');

        subplot(2,2,2); 
        plot(f,abs(X1),'b-','LineWidth',2); 
        title('Plot 4: X1(f)');
        hold off;


        subplot(2,2,3);
        plot(f,abs(X2),'r','LineWidth',2);
        title('Plot 5: X2(f)')
        subplot(2,2,4);
        plot(t,x2,'r','LineWidth',2);
        ylim([-max(abs(x2)) max(abs(x2))]); 
        %xlim([D/2 D/2+5/fm]);
        title('Plot 6: x2(t)')
        %------------------------------------------






        %------------------------------------------
        figure(3);
        subplot(2,1,1);
        plot(f,abs(X3),'r','LineWidth',2);
        title('Plot 7: X3(f)')

        subplot(2,1,2);
        plot(t,x2,'r','LineWidth',2);
        ylim([-max(abs(x3)) max(abs(x3))]); 
        %xlim([D/2 D/2+5/fm]);
        title('Plot 8: x3(t)')
        %------------------------------------------
    end






    %------------------------------------------
    figure(4);
    subplot(2,1,2);
    plot(f,abs(X4),'r','LineWidth',2);
    title('Plot 9: X4(f)')
    xlim([-10000 10000]);

    subplot(2,1,1);
    plot(t,x4,'r','LineWidth',2);
    ylim([-max(abs(x4)) max(abs(x4))]); 
    %xlim([D/2 D/2+5/fm]);
    title('Plot 10: x4(t)');
    %------------------------------------------






end

