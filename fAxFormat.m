function fAxFormat(h, varargin)

%% defualts
text_interpreter = 'latex';
tick_fontSz = 10;
label_fontSz = 11;
title_fontSz = 11;

%% parse input
n = length(varargin);
for i = 1:2:n-1
    switch varargin{i}
        case 'text_interpreter'
            text_interpreter = varargin{i+1};
        case 'tick_fontSz'
            tick_fontSz = varargin{i+1};
        case 'label_fontSz'
            label_fontSz = varargin{i+1};
        case 'title_fontSz'
            title_fontSz = varargin{i+1};
        otherwise
            error('fAxFormat: Unknown option.')
    end
end

%% set interpreter & fonts
h.TickLabelInterpreter = text_interpreter;
h.Title.Interpreter = text_interpreter;
h.XLabel.Interpreter = text_interpreter;
h.YLabel.Interpreter = text_interpreter;
h.ZLabel.Interpreter = text_interpreter;
h.FontSize = tick_fontSz;
h.LabelFontSizeMultiplier = label_fontSz / tick_fontSz;
h.TitleFontSizeMultiplier = title_fontSz / tick_fontSz;

% set grid style
set(h, 'GridAlpha', 0.15)
set(h, 'MinorGridAlpha', 0.15)

