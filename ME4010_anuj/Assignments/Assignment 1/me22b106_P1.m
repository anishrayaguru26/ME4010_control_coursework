clear; clc;

syms s t;

G_n = input("Enter numerator:");
G_d = input("Enter denominator:");

G_sym_d = poly2sym(G_d, s); G_sym_n = poly2sym(G_n, s);

%function name is plot_bode and is being called here
plot_bode(G_n, G_d)

G = tf(G_n, G_d);

figure(2);
bode(G); title("Inbuilt bode for G");


%%%%%%%%%%%%%%%%%%%%%%
%below are the sin responses of G for w = 0.25, 2.5, 25 rad/s and are 
%plotted for a time duration of 1000 secs and checking for the last 500
%secs for the max value which is our desired number required. Then we
%manually check our graph for the corresponding value and see compare.


t1 = 0:1:1000;

figure(3);
S = tf(0.25, [1 0 0.25^2]);
R1 = S * G;
[n,d] = tfdata(R1);
R1_i = ilaplace(poly2sym(cell2mat(n),s)/poly2sym(cell2mat(d),s));
val = vpa(subs(R1_i, t, t1), 2);
plot(t1, val); title("0.25 rad/s");
disp("0.25 rad/s");
disp(max(val(500:end)));

figure(4);
S = tf(2.5, [1 0 2.5^2]);
R2 = S * G;
[n,d] = tfdata(R2);
R2_i = ilaplace(poly2sym(cell2mat(n),s)/poly2sym(cell2mat(d),s));
val = vpa(subs(R2_i, t, t1), 2);
plot(t1, val); title("2.5 rad/s");
disp("2.5 rad/s");
disp(max(val(500:end)));

figure(5);
S = tf(25, [1 0 25^2]);
R3 = S * G;
[n,d] = tfdata(R3);
R3_i = ilaplace(poly2sym(cell2mat(n),s)/poly2sym(cell2mat(d),s));
val = vpa(subs(R3_i, t, t1));
plot(t1, val); title("25 rad/s");
disp("25 rad/s");
disp(max(val(500:end)));

%%%%%%%%%%%%%%%%%%%%%%


C_n = [1 0.5]; C_d = [1 0.1];

C = tf(C_n, C_d);

%oltf is open loop transfer function
oltf = G * C;

%cltf is closed loop transfer function
cltf = oltf/(1 + oltf);

figure(6);
bode(oltf); title("Inbuilt bode for oltf");

figure(7);
bode(cltf); title("Inbuilt bode for cltf");


function plot_bode(G_n, G_d)
    syms s;
    figure(1);
    subplot(2, 1, 1);
    coeff = G_n(1)/G_d(1);%this is the overall coefficient of the transfer function
    %after setting the highest power of s in the numerator and denominator
    %as 1. This has been done for our convinience.
    zero = roots(G_n);
    poles = roots(G_d);
    G_sym_d = poly2sym(G_d, s); G_sym_n = poly2sym(G_n, s);
    w = logspace(-1, 2, 1000);%initializing range over which we want to find our plots
    assymptotes = zeros(1, length(w));
    %What we do here is find the assymptotes as an array of values and add
    %them up to a common array which gives us our final assymptote values.
    %The derivation is written in the pdf. We use piecewise functions and
    %add all of them to get the final assymptote
    i = 1;
    %process for zeros (seperately taking case of cases like zeros = 0)
    while i <= length(zero)
        if zero(i) ~= 0
            index = find(abs((w - abs(zero(i)))) == min(abs(w - abs(zero(i)))));
            first_x_nolog = w(1:index); second_x_nolog = w((index + 1):length(w));
            first_y = 20 * log10(abs(zero(i))) * ones(1, length(first_x_nolog));
            second_y = 20 * log10(second_x_nolog);
            y = cat(2, first_y, second_y);
            assymptotes = assymptotes + y;
        else
            y = 20 * log10(w);
            assymptotes = assymptotes + y;
        end
        i = i + 1;
    end
    i = 1;
    %process for poles, same as above but with flipped signs
    while i <= length(poles)
        if poles(i) ~= 0
            index = find(abs((w - abs(poles(i)))) == min(abs(w - abs(poles(i)))));
            first_x_nolog = w(1:index); second_x_nolog = w((index + 1):length(w));
            first_y = (-1) * 20 * log10(abs(poles(i))) * ones(1, length(first_x_nolog));
            second_y = (-1) * 20 * log10(second_x_nolog);
            y = cat(2, first_y, second_y);
            assymptotes = assymptotes + y;
        else
            y = (-20) * log10(w);
            assymptotes = assymptotes + y;
        end
        i = i + 1;
    end
    semilogx(w, assymptotes + 20 * log10(coeff), '--', "Color", [1 0 0]); hold on;%plotting assymptotes for the gain plot
    dec = 20 * (log10(abs(vpa(subs(G_sym_n/G_sym_d, s, complex(0, w)), 2))));
    semilogx(w, dec, "Color", [0 0 1]); grid on; title("Custom");%plotting gain plot

    %same process is followed for phase plot but here for my convinience,
    %I check for first and second order zeros and poles seperately and
    %correspondingly give the assymptote equations for each case
    subplot(2, 1, 2);
    ang = angle(vpa(subs(G_sym_n/G_sym_d, s, complex(0, w)), 2));
    assymptotes_p = zeros(1, length(w));
    l_w = length(w);
    i = 1;
    pole_check = [];
    while i <= length(poles)
        if imag(poles(i)) ~= 0 %second order
            if ismember(poles(i), pole_check) ~= 1
                pole_check(end + 1) = conj(poles(i));
                wn = abs(poles(i));
                index_0 = find(abs(w - wn/10) == min(abs(w - wn/10)));
                index_2 = find(abs(w - wn * 10) == min(abs(w - wn * 10)));
                first_y = zeros(1, index_0 - 1); last_y = ones(1, l_w - index_2) * (-180);
                middle_y = -(90) * (log10(w(index_0:index_2)) - log10(w(index_0))) + 0;
                y = cat(2, first_y, middle_y, last_y);
                assymptotes_p = assymptotes_p + y;
            end
        elseif poles(i) == 0 %pole = 0
            y = (-90) * ones(1, l_w);
        else %first order
            index_0 = find(abs(w + poles(i)/10) == min(abs(w + poles(i)/10)));
            index_2 = find(abs(w + poles(i) * 10) == min(abs(w + poles(i) * 10)));
            first_y = zeros(1, index_0 - 1); last_y = ones(1, l_w - index_2) * (-90);
            middle_y = -(45) * (log10(w(index_0:index_2)) - log10(w(index_0))) + 0;
            y = cat(2, first_y, middle_y, last_y);
            assymptotes_p = assymptotes_p + y;
        end
        i = i + 1;
    end

    %a similar process is followed for zeros
    zero_check = [];
    i = 1;
    while i <= length(zero)
        if imag(zero(i)) ~= 0
            if ismember(zero(i), zero_check) ~= 1
                zero_check(end + 1) = conj(zero(i));
                wn = abs(zero(i));
                index_0 = find(abs(w - wn/10) == min(abs(w - wn/10)));
                index_2 = find(abs(w - wn * 10) == min(abs(w - wn * 10)));
                first_y = zeros(1, index_0 - 1); last_y = ones(1, l_w - index_2) * (180);
                middle_y = (90) * (log10(w(index_0:index_2)) - log10(w(index_0))) + 0;
                y = cat(2, first_y, middle_y, last_y);
                assymptotes_p = assymptotes_p + y;
            end
        elseif zero(i) == 0
            y = (90) * ones(1, l_w);
        else
            index_0 = find(abs(w + zero(i)/10) == min(abs(w + zero(i)/10)));
            index_2 = find(abs(w + zero(i) * 10) == min(abs(w + zero(i) * 10)));
            first_y = zeros(1, index_0 - 1); last_y = ones(1, l_w - index_2) * (90);
            middle_y = (45) * (log10(w(index_0:index_2)) - log10(w(index_0))) + 0;
            y = cat(2, first_y, middle_y, last_y);
            assymptotes_p = assymptotes_p + y;
        end
        i = i + 1;
    end

    semilogx(w, assymptotes_p, '--', "Color", [1 0 0]);hold on;%plotting phase plot assymptotes
    semilogx(w, ang * (180/pi), 'Color',[0 0 1]); grid on; hold on;%plotting phase plot
    
end

