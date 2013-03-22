function wavplay(y,Fs,mode)
%wavplay: An adapter for matlab's M$ windows only function wavplay.
%   
%   Because wavplay is a M$ windows only function in matlab,
%   Linux, Mac, even M$ windows 64 bits user cannot use it.
%
%   For user who has a code using wavplay and do not want to
%   modify code, this function call the cross-platform matlab
%   function audioplayer to play sound.
%
%   Usage:
%       wavplay(y,Fs)
%       wavplay(y,Fs,mode)
%
%       y is mono or stereo audio signals
%       Fs is sample rate in Hz
%       mode = 'sync' or 'async'
%
%   Qing-Cheng Li (qcl) 
%   <r01922024 at csie dot ntu dot edu dot tw>
%   2013.03.22 (R.O.C.102)

if nargin < 3,mode='sync';end

ap = audioplayer(y,Fs);

if strcmp(mode,'sync')
    %sync
    playblocking(ap);               % blocking
else
    %async
    global qcl_wavplay;             % using global variable, so, after
    qcl_wavplay = {qcl_wavplay ap}; % this function ended, the audio will
    play(ap);                       % continue to play.
end

