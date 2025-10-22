function spm_setup()
% SPM Setup Script
% This script sets up the SPM environment and adds all modules to the MATLAB path
%
% Usage: spm_setup()
%
% This script will:
% 1. Add the main SPM directory to the MATLAB path
% 2. Add all module subdirectories to the path
% 3. Set up default configurations
% 4. Initialize SPM environment
%
% Author: SPM Development Team
% Date: October 2025

% Get the SPM root directory
spm_root = fileparts(mfilename('fullpath'));
spm_root = fileparts(spm_root); % Go up one level from setup/

fprintf('Setting up SPM...\n');
fprintf('SPM Root: %s\n', spm_root);

% Add main directories to path
addpath(spm_root);

% Add module directories
modules = {
    'core', 'stats', 'imaging', 'dcm', 'eeg', 'io', 'design', 'bms',
    'bayesian', 'modeling', 'math_ops', 'mesh', 'graph', 'utilities',
    'spectral', 'mixture', 'spatial'
};

for i = 1:length(modules)
    module_path = fullfile(spm_root, modules{i});
    if exist(module_path, 'dir')
        addpath(genpath(module_path));
        fprintf('Added module: %s\n', modules{i});
    end
end

% Add class directories
class_dirs = {'@file_array', '@gifti', '@meeg', '@nifti', '@slover', '@xmltree'};
for i = 1:length(class_dirs)
    class_path = fullfile(spm_root, class_dirs{i});
    if exist(class_path, 'dir')
        addpath(class_path);
        fprintf('Added class: %s\n', class_dirs{i});
    end
end

% Add other organized directories
org_dirs = {'matlabbatch', 'config', 'batches', 'canonical', 'help', 'man'};
for i = 1:length(org_dirs)
    org_path = fullfile(spm_root, org_dirs{i});
    if exist(org_path, 'dir')
        addpath(genpath(org_path));
        fprintf('Added directory: %s\n', org_dirs{i});
    end
end

% Set SPM defaults
try
    spm_defaults();
    fprintf('SPM defaults loaded successfully.\n');
catch ME
    warning('Could not load SPM defaults: %s', ME.message);
end

% Check installation
try
    spm_check_installation();
    fprintf('SPM installation check completed.\n');
catch ME
    warning('SPM installation check failed: %s', ME.message);
end

fprintf('SPM setup complete!\n');
fprintf('Type ''spm'' to start SPM GUI.\n');

end
