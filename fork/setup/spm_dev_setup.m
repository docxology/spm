function spm_dev_setup()
% SPM Developer Setup Script
% This script sets up the development environment for SPM
%
% Usage: spm_dev_setup()
%
% This script will:
% 1. Run standard SPM setup
% 2. Add development tools to path
% 3. Set up development configurations
% 4. Enable debugging and testing tools
%
% Author: SPM Development Team
% Date: October 2025

fprintf('Setting up SPM development environment...\n');

% Run standard setup first
spm_setup();

% Add development tools
dev_root = fileparts(mfilename('fullpath'));
addpath(dev_root);
addpath(fullfile(dev_root, 'dev'));
addpath(fullfile(dev_root, 'examples'));

% Set development configurations
setenv('SPM_DEVELOPMENT', 'true');

% Enable debugging
dbstop if error;
warning('on', 'verbose');

% Add development-specific paths
dev_modules = {'dev', 'examples', 'docs'};
for i = 1:length(dev_modules)
    dev_path = fullfile(dev_root, dev_modules{i});
    if exist(dev_path, 'dir')
        addpath(genpath(dev_path));
        fprintf('Added development module: %s\n', dev_modules{i});
    end
end

% Set up testing framework if available
if exist('matlab.unittest.TestSuite', 'class')
    addpath(fullfile(dev_root, 'tests'));
    fprintf('Testing framework available.\n');
end

% Display development information
fprintf('\nSPM Development Environment Setup Complete!\n');
fprintf('Development tools available:\n');
fprintf('- spm_dev_info() - Show development information\n');
fprintf('- spm_run_tests() - Run test suite\n');
fprintf('- spm_doc() - Open documentation\n');
fprintf('- spm_contribute() - Contribution guidelines\n');

end
