function fAxFormat(h, varargin)

% [] = fAxFormat(h, ...)
% -------------------------------------------------------------------------
% Formats the axes with the desired text interpreter and font sizes.
% - Adjusts the darkness of the grid lines to make it more suitable for 
%   exporting.
% - This is a lower-level function that is normally not used directly but
%   only called by fFigCapture.m to format the figure before exporting.
% - It is a separate function because in rare cases of complicated figures 
%   (especially when multiple axes are overlapped on top of each other),
%   axes need to be formatted in a particular order. This lower-level
%   function exists to allow that flexibility.
% - If invoked directly, use ('skip_format_adj', true) with fFigCapture.m 
%   to skip all axes formatting in the latter.
% - Mandatory input: h - axes handle
% - '...' - extra option-value pairs ('option', default) :
%   ('tex_interpreter', 'Latex') - text interpreter for the figure
%   ('tick_fontsz', 10) - font size of numbers on the axis
%   ('label_fontsz', 11) - font size of the axis labels (i.e. xlabel, etc)
%   ('title_fontsz', 11) - font size of the figure title
% -------------------------------------------------------------------------
% lm808, 03/2019

%% defualts
text_interpreter = 'latex';
tick_fontSz = 10;
label_fontSz = 11;
title_fontSz = 11;

%% parse input
n = length(varargin);
for i = 1:2:n-1
    switch lower(varargin{i})
        case 'text_interpreter'
            text_interpreter = varargin{i+1};
        case 'tick_fontsz'
            tick_fontSz = varargin{i+1};
        case 'label_fontsz'
            label_fontSz = varargin{i+1};
        case 'title_fontsz'
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

% set gridline colour darkness
set(h, 'GridAlpha', 0.15)
set(h, 'MinorGridAlpha', 0.12)

