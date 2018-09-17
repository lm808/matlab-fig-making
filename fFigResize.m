function fFigResize(handle,height_fraction, width_fraction, varargin)

% Sets figure size to a fraction of the size of the whole page. 
% The page is defined as A4 portrait with text WxH = 16.65x18 cm (IC Thesis)
% Override this with option-property pairs:
%       'full_width', 'full_height', in unit of [cm].
% Usage:
%       1) fFigResize(handle, height_fraction, width_fraction)
%          e.g. to fit 3 rows and 2 columns onto a single page with
%          figures of the same size, use fFigResize(handle,0.33,0.48)
%       2) fFigResize(handle, 'preset', preset_size)
%          preset sizes: 1x1 (1 row 1 col), 2x1, 2x2, 3x2, 4x2
%                        'ppt_L', 'ppt_S'
% lm808@ic.ac.uk
% 09/2018

%% defaults
full_width = 16.65; % [cm]
full_height = 18;   % [cm]

%% parse inputs
n = length(varargin);
for i = 1:2:n-1
    switch varargin{i}
        case 'full_width'
            full_width = varargin{i+1};
        case 'full_height'
            full_height = varargin{i+1};
        otherwise
            error('fFigResize: Unknown option.')
    end
end

%% set figure size
if isnumeric(height_fraction) && isnumeric(width_fraction)
    
    figSize = [full_width * width_fraction, full_height * height_fraction];
    
elseif strcmpi(height_fraction, 'preset')
    
    switch width_fraction
        case '1x1'
            figSize = [full_width, full_height];
        case '2x1'
            figSize = [full_width, 0.5 * full_height];
        case '2x2'
            figSize = [full_width * 0.48, full_height * 0.48];
        case '3x2'
            figSize = [full_width * 0.48, full_height * 0.33];
        case '4x2'
            figSize = [full_width * 0.25, full_height * 0.48];
        case 'ppt_L'
            figSize = [16.65, 12];
        case 'ppt_S'
            figSize = [16.65 * 0.7, 18 * 0.5];
        otherwise
            ffRaiseError(1)
    end
    
else
    ffRaiseError(1)
end

set(handle,'units','centimeters');
pos = get(handle,'position');
set(handle,'position',[pos(1:2),figSize]);

end

function ffRaiseError(errNo)
    switch errNo
        case 1
            error('fFigResize: invalid size option.')
        otherwise
            error('fFigResize: Unknown error.')
    end
end