function [ out ] = deal2struct(varargin)
% Performs Matlab's missing >> out.(Fields{:}) = BaseStruct + deal(Data(:));
%
% Inputs:
%     'Fields'     : cell array of field names
%     'Data'       : 1D array or cell array of values
%     'BaseStruct' : Base structure to append Data to (OPTIONAL)
% Outputs:
%     out: structure with Fields valued as Data(:);
%
% Note: If a Fields{#} already exists in BaseStruct,
%       then its value will be overwritten.
%
% Modifications:
%    7/10/19 (rgc) Original version
%
%---|----1----|----2----|----3----|----4----|----5----|----6----|----7----|
for i = 1:2:nargin
    switch varargin{i}
        case {'Fields','fields','Names','names'}
            Fields = varargin{i+1};
        case {'Data','data','In','in','Input','input'}
            Data = varargin{i+1};
        case {'BaseStruct','baseStruct','basestruct',...
                'base','struct','old','appendto'}
            out = varargin{i+1};
        otherwise
            error('deal2struct:UnknwnParam > Unknown parameter encountered.');
    end % switch varargin{:}
end % parse Dataputs


if length(Fields) ~= numel(Fields)
    error('deal2struct:2+DFields > Input field name array must be 1D');
end % linear Fields array

if ~isa(Fields,'cell') || ~isa(Fields{1},'char')
    error('deal2struct:NameType > Input field name array must be a cellstr');
end % cellstring Fields array

if length(Data) ~= numel(Data)
    error('deal2struct:2+DIn > Input data array must be 1D');
end % linear Data data

if exist('out','var') & ~isa(out,'struct') %#ok<AND2>
    error('deal2struct:Unstruct> BaseStruct must be a struct.');
end % base type check

len = length(Fields);

if len ~= length(Data)
    error('deal2struct:Uneven > Inputs must be the same length.');
end % size match


if isa(Data,'cell')
    for i = 1:len
        out.(Fields{i}) = Data{i};
    end % traverse cell array
else
    for i = 1:len
        out.(Fields{i}) = Data(i);
    end % traverse array
end

end % deal2struct()
