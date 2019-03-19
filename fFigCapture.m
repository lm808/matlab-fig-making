function []=fFigCapture(handle, destinationFile, varargin)

% [] = fFigCapture(handle, destinationFile, ...)
% -------------------------------------------------------------------------
% Exports MATLAB figures 'as is', with formatting options for texts.
% - Choose file format by ending the file name with the desired extension:
%   'pdf' - PDF vector image, recommended for pdflatex
%   'png' - PNG bitmap image
%   'fig' - editable MATLAB figure file
%   'try' - run through all formatting options without exporting a file
% - '...': extra option-value pairs ('option', default) :
%   ('dpi', 300) - dots per inch of the output image
%   ('tex_interpreter', 'Latex') - text interpreter for the figure
%   ('tick_fontsz', 10) - font size of numbers on the axis
%   ('label_fontsz', 11) - font size of the axis labels (i.e. xlabel, etc)
%   ('title_fontsz', 11) - font size of the figure title
%   ('skip_format_adj', false) - skip interpreter or font changes
% -------------------------------------------------------------------------
% lm808, 03/2019

%% defualts
dpi = 300;
text_interpreter = 'Latex';
tick_fontSz = 10;
label_fontSz = 11;
title_fontSz = 11;
skip_format_adj = false;

%% parse input
n = length(varargin);
for i = 1:2:n-1
    switch lower(varargin{i})
        case 'dpi'
            dpi = varargin{i+1};
        case 'tex_interpreter'
            text_interpreter = varargin{i+1};
        case 'tick_fontsz'
            tick_fontSz = varargin{i+1};
        case 'label_fontsz'
            label_fontSz = varargin{i+1};
        case 'title_fontsz'
            title_fontSz = varargin{i+1};
        case 'skip_format_adj'
            skip_format_adj = varargin{i+1};
        otherwise
            error('fFigCapture: Unknown option.')
    end
end
type = strsplit(destinationFile, '.');
type = type{end};

%% set interpreter & font sizes
if ~skip_format_adj
    h = findobj(handle,'type','Axes');
    for i = 1:length(h)
        fAxFormat(h(i), 'tick_fontSz', tick_fontSz, ...
                        'label_fontSz', label_fontSz, ...
                        'title_fontSz', title_fontSz, ...
                        'text_interpreter', text_interpreter);
    end
    h = findobj(handle,'type','Legend');
    for i = 1:length(h)
        h(i).Interpreter = text_interpreter;
    end
    h = findobj(handle,'type','ColorBar');
    for i = 1:length(h)
        h(i).TickLabelInterpreter = text_interpreter;
    end
    h = findobj(handle,'type','Text');
    for i = 1:length(h)
        h(i).Interpreter = text_interpreter;
    end
end

%% output figure
switch lower(type)
    case 'fig'
        hgsave(handle,destinationFile)
    case 'pdf'
        save2pdf(handle, destinationFile, dpi)
        [status,~] = system(['pdfcrop ', destinationFile, ' ', destinationFile]);
        if status ~= 0
            warning(['fFigCapture: unable to remove PDF white margins. ',...
                     'Check if ''pdfcrop'' is installed and in PATH. ',...
                     'See ''Dependencies'' in ''README.md.'''])
        end
    case 'png'
        save2png(handle, destinationFile, dpi)
        [status,~] = system(['convert ', destinationFile, ' -trim ', destinationFile]);
        if status ~= 0
            warning(['fFigCapture: unable to remove PNG white margins. ',...
                     'Check if ''imagemagick/convert'' is installed and in PATH. ',...
                     'See ''Dependencies'' in ''README.md.'''])
        end
    case 'try'
        % trial run only, no output will be created.
    otherwise
        disp('Unsupported file format, saving as MATLAB fig file.')
        fFigCapture(handle,[destinationFile,'.fig'])
end

%% PNG export
function save2png(handle, destinationFile, dpi)

% Backup previous settings
prePaperPosition = get(handle,'PaperPosition');

% Export figure
set(handle, 'PaperPositionMode', 'auto');
print(handle,destinationFile,'-dpng',sprintf('-r%d',dpi))

% Restore the previous settings
set(handle,'PaperPosition',prePaperPosition);

%% PDF export
function save2pdf(handle, pdfFileName, dpi)

% Backup previous settings
prePaperType = get(handle,'PaperType');
prePaperUnits = get(handle,'PaperUnits');
preUnits = get(handle,'Units');
prePaperPosition = get(handle,'PaperPosition');
prePaperSize = get(handle,'PaperSize');

% Make changing paper type possible
set(handle,'PaperType','<custom>');

% Set units to all be the same
set(handle,'PaperUnits','inches');
set(handle,'Units','inches');

% Set the page size and position to match the figure's dimensions
position = get(handle,'Position');
set(handle,'PaperPosition',[0,0,position(3:4)]);
set(handle,'PaperSize',position(3:4));

% Save the pdf (this is the same method used by "saveas")
print(handle,'-painters', '-dpdf',pdfFileName,sprintf('-r%d',dpi))

% Restore the previous settings
set(handle,'PaperSize',prePaperSize);
set(handle,'PaperPosition',prePaperPosition);
set(handle,'Units',preUnits);
set(handle,'PaperUnits',prePaperUnits);
set(handle,'PaperType',prePaperType);