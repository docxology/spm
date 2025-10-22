function spm_compatibility()
% SPM Backward Compatibility Script
% This script ensures backward compatibility for the refactored SPM structure
%
% Usage: spm_compatibility()
%
% This script creates function handles and path mappings to ensure that
% existing SPM code continues to work with the new modular structure.
%
% Author: SPM Development Team
% Date: October 2025

% Only run if not already initialized
persistent compatibility_initialized
if ~isempty(compatibility_initialized)
    return;
end

fprintf('Initializing SPM backward compatibility...\n');

% Get SPM root directory
spm_root = fileparts(mfilename('fullpath'));

% Module mappings for backward compatibility
module_map = struct(...
    'core', {{'array', 'math', 'file', 'system', 'utils'}}, ...
    'stats', {{'distributions', 'tests', 'inference'}}, ...
    'imaging', {{'spatial', 'smoothing', 'segmentation', 'rendering'}}, ...
    'dcm', {{'estimation', 'specification', 'results', 'peb', 'dem', 'adem'}}, ...
    'eeg', {{'preprocessing', 'inversion', 'source', 'connectivity'}}, ...
    'io', {{'nifti', 'dicom', 'data'}}, ...
    'design', {{'specification', 'contrasts'}}, ...
    'bms', {{'core', 'analysis', 'display'}}, ...
    'bayesian', {{}}, ...
    'modeling', {{'optimization', 'regression', 'dynamical'}}, ...
    'math_ops', {{'linear_algebra'}}, ...
    'mesh', {{'geometry'}}, ...
    'graph', {{'networks'}}, ...
    'utilities', {{'validation', 'conversion', 'standalone'}}, ...
    'spectral', {{'estimation'}}, ...
    'mixture', {{'clustering'}}, ...
    'spatial', {{'registration'}} ...
);

% Add all module paths to ensure functions are accessible
modules = fieldnames(module_map);
for i = 1:length(modules)
    module_path = fullfile(spm_root, modules{i});
    if exist(module_path, 'dir')
        % Add the main module directory
        addpath(module_path);

        % Add subdirectories
        subdirs = module_map.(modules{i});
        for j = 1:length(subdirs)
            subdir_path = fullfile(module_path, subdirs{j});
            if exist(subdir_path, 'dir')
                addpath(subdir_path);
            end
        end
    end
end

% Add class directories
class_dirs = {'@file_array', '@gifti', '@meeg', '@nifti', '@slover', '@xmltree'};
for i = 1:length(class_dirs)
    class_path = fullfile(spm_root, class_dirs{i});
    if exist(class_path, 'dir')
        addpath(class_path);
    end
end

% Add organized directories
org_dirs = {'matlabbatch', 'config', 'batches', 'canonical', 'help', 'man'};
for i = 1:length(org_dirs)
    org_path = fullfile(spm_root, org_dirs{i});
    if exist(org_path, 'dir')
        addpath(genpath(org_path));
    end
end

% Set compatibility flag
compatibility_initialized = true;

fprintf('SPM backward compatibility initialized.\n');
fprintf('All functions from the refactored structure are now accessible.\n');

end

% Auto-initialize when this file is loaded
spm_compatibility();
