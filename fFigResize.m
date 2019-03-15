function fFigResize(handle, height_fraction, width_fraction, varargin)

% [] = fFigResize(handle,height_fraction/preset,...
%                        width_fraction/preset_name, varargin)
% -------------------------------------------------------------------------
% Resizes figures to fit onto a document page. 
% - The default page size is A4 portrait with text WxH = 16.65x18 cm
% - Usage:
%   1) Override page size with option-property pairs:
%      'full_width', 'full_height', in unit of [cm].
%   2) " 'landscape',1 " and " 'portrait', 1 " to enforce page orientation
%   3) Example 1. use:
%      fFigResize(handle, 0.33, 0.48)
%      when you want to fit 3 rows and 2 columns onto a single page with
%      figures of the same size.
%   4) Example 2. for a pre-set size, use:
%      fFigResize(handle, 'preset', preset_size)
%      preset sizes: '1x1' (1 row 1 col), '2x1', '2x2', '3x2', '4x2',
%                    'ppt_L', 'ppt_S'
% -------------------------------------------------------------------------
% lm808, 09/2018

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
        case 'landscape'
            if varargin{i+1}
                w = max([full_height, full_width]);
                h = min([full_height, full_width]);
                full_height = h;
                full_width = w;
            end
        case 'portrait'
            if varargin{i+1}
                w = min([full_height, full_width]);
                h = max([full_height, full_width]);
                full_height = h;
                full_width = w;
            end
        otherwise
            fRaiseError(2)
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
            error('fFigResize: Invalid preset size.')
        case 2 
            error('fFigResize: Unknown option.')
        otherwise
            error('fFigResize: Unknown error.')
    end
end