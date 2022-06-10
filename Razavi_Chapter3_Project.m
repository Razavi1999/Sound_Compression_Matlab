clc
clear

info = audioinfo('E:\Mahdi_Razavi\RazaviSample2.wav');
% disp(info);

% Read the data back into MATLAB , and listen to audio .
[y, Fs] = audioread('E:\Mahdi_Razavi\RazaviSample2.wav');
symbols = unique(y(:));

% size(y)

% size(symbols);

h = histogram(y, symbols);
h.Normalization = 'probability';
probabilities = h.Values;
probabilities(end + 1) = 0;

v = h.Values;
n = numel(y);
n

%calculate number H(Y)

logarithmV = -log2(v);
vlogv = v.*logarithmV;
H_Y = sum(vlogv, 'omitnan');
fprintf('H_Y : %i\n', H_Y);

climit = n * H_Y;
fprintf('climit : %i', climit);


size(probabilities);
size(symbols);

dict = huffmandict( symbols , probabilities');
code = huffmanenco(y(:,1) , dict);


decodedy = huffmandeco(code ,dict);


% Play wav file
player = audioplayer(decodedy ,Fs);
play( player );

newname = 'compressedhandeler.wav';
audiowrite(newname,code,Fs);
writematrix(code,'compressedhandeler.txt');
clear code Fs


