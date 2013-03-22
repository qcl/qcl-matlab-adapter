function y = wavrecord(n,Fs,ch,dtype)
%wavrecord: An adapter for matlab's M$ windows only function wavrecord.
%
%   Because wavrecord is a M$ windows only function in matlab,
%   Linux, Mac, even M$ windows 64 bits user cannot use it.
%
%   For user who has a code using wavrecord and do not want to
%   modify code, this function call the cross-platform matlab
%   function audiorecorder to record sound.
%
%   Usage:
%       y = wavrecord(n,Fs)
%       y = wavrecord(___,ch)
%       y = wavrecord(___,'dtype')
%
%       n is samples of an audio signal 
%       Fs is sample rate in Hz
%       ch = 1(mono) or 2(stereo), default is 1
%       dtype is data type for recording. default is 'uint8' 
%
%           dtype       bits/sample y Data range
%           'double'    16          -1.0 <= y <= +1.0
%           'single'    16          -1.0 <= y <= +1.0
%           'int16'     16          –32768 <= y <= +32767
%           'uint8'     8           0 <= y <= 255
%
%   Qing-Cheng Li (qcl) 
%   <r01922024 at csie dot ntu dot edu dot tw>
%   2013.03.22 (R.O.C.102)

if nargin < 3,ch = 1;dtype = 'uint8';end
if nargin < 4,
    if isa(ch,'char')
        dtype = ch;
        ch = 1;
    else 
        dtype='uint8'; 
    end; 
end
if nargin < 5,
    if isa(ch,'char')
        tmp = ch;
        ch = dtype;
        dtype = tmp;
    end;
end

if strcmp(dtype,'uint8')
    nbits = 8;
else
    nbits = 16;
end

recorder = audiorecorder(Fs,nbits,ch);
recordblocking(recorder,n/Fs);
y = getaudiodata(recorder,dtype);

return;
