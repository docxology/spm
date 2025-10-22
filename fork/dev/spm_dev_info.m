function info = spm_dev_info()
% SPM Development Information
% Returns information about the SPM development environment
%
% Usage: info = spm_dev_info()
%
% Returns a structure with development information including:
% - Version information
% - Module organization
% - Path information
% - Development status
%
% Author: SPM Development Team
% Date: October 2025

info = struct();

% Version information
info.version = 'SPM25 (Refactored)';
info.release_date = datestr(now, 'yyyy-mm-dd');
info.matlab_version = version();

% Module information
info.modules = {
    'core', 'stats', 'imaging', 'dcm', 'eeg', 'io', 'design', 'bms', ...
    'bayesian', 'modeling', 'math_ops', 'mesh', 'graph', 'utilities', ...
    'spectral', 'mixture', 'spatial'
};

% Count functions in each module
for i = 1:length(info.modules)
    module_path = fullfile(fileparts(mfilename('fullpath')), '..', '..', info.modules{i});
    if exist(module_path, 'dir')
        info.module_counts(i) = length(dir(fullfile(module_path, '**', 'spm_*.m')));
    else
        info.module_counts(i) = 0;
    end
end

info.module_counts = info.module_counts';

% Path information
info.spm_root = fileparts(fileparts(mfilename('fullpath')));
info.dev_root = fileparts(mfilename('fullpath'));
info.matlab_path = path();

% Environment information
info.development_mode = getenv('SPM_DEVELOPMENT');
info.platform = computer();

% Display information
fprintf('SPM Development Information:\n');
fprintf('==========================\n');
fprintf('Version: %s\n', info.version);
fprintf('Release Date: %s\n', info.release_date);
fprintf('MATLAB Version: %s\n', info.matlab_version);
fprintf('Platform: %s\n', info.platform);
fprintf('Development Mode: %s\n', info.development_mode);

fprintf('\nModule Organization:\n');
for i = 1:length(info.modules)
    fprintf('  %s: %d functions\n', info.modules{i}, info.module_counts(i));
end

total_functions = sum(info.module_counts);
fprintf('\nTotal Functions: %d\n', total_functions);

fprintf('\nPaths:\n');
fprintf('  SPM Root: %s\n', info.spm_root);
fprintf('  Dev Root: %s\n', info.dev_root);

end
