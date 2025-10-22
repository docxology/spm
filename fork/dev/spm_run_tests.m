function results = spm_run_tests(module)
% Run SPM Tests
% Runs the test suite for SPM modules
%
% Usage: results = spm_run_tests(module)
%
% Inputs:
%   module - (optional) specific module to test, or 'all' for all modules
%
% Outputs:
%   results - test results structure
%
% Author: SPM Development Team
% Date: October 2025

if nargin < 1
    module = 'all';
end

fprintf('Running SPM Tests...\n');

% Check if MATLAB testing framework is available
if ~exist('matlab.unittest.TestSuite', 'class')
    warning('MATLAB testing framework not available. Cannot run tests.');
    results = [];
    return;
end

spm_root = fileparts(fileparts(mfilename('fullpath')));
test_root = fullfile(spm_root, 'tests');

if ~exist(test_root, 'dir')
    mkdir(test_root);
    fprintf('Created tests directory: %s\n', test_root);
end

% Define modules to test
modules = {
    'core', 'stats', 'imaging', 'dcm', 'eeg', 'io', 'design', 'bms', ...
    'bayesian', 'modeling', 'math_ops', 'mesh', 'graph', 'utilities'
};

results = struct();

if strcmp(module, 'all')
    % Test all modules
    for i = 1:length(modules)
        fprintf('Testing module: %s\n', modules{i});
        try
            module_test_path = fullfile(test_root, [modules{i}, '_tests']);
            if exist(module_test_path, 'dir')
                suite = matlab.unittest.TestSuite.fromFolder(module_test_path);
                results.(modules{i}) = run(suite);
            else
                fprintf('  No tests found for %s\n', modules{i});
                results.(modules{i}) = [];
            end
        catch ME
            warning('Error testing %s: %s', modules{i}, ME.message);
            results.(modules{i}) = [];
        end
    end
else
    % Test specific module
    if ismember(module, modules)
        fprintf('Testing module: %s\n', module);
        try
            module_test_path = fullfile(test_root, [module, '_tests']);
            if exist(module_test_path, 'dir')
                suite = matlab.unittest.TestSuite.fromFolder(module_test_path);
                results.(module) = run(suite);
            else
                fprintf('  No tests found for %s\n', module);
                results.(module) = [];
            end
        catch ME
            warning('Error testing %s: %s', module, ME.message);
            results.(module) = [];
        end
    else
        error('Unknown module: %s', module);
    end
end

% Summary
fprintf('\nTest Summary:\n');
fprintf('=============\n');

total_passed = 0;
total_failed = 0;
total_tests = 0;

fields = fieldnames(results);
for i = 1:length(fields)
    if ~isempty(results.(fields{i}))
        if isstruct(results.(fields{i}))
            % Single test result
            if isfield(results.(fields{i}), 'Passed')
                passed = sum([results.(fields{i}).Passed]);
                failed = sum([results.(fields{i}).Failed]);
                total = passed + failed;
                fprintf('%s: %d/%d passed\n', fields{i}, passed, total);
            end
        else
            % Multiple test results
            passed = 0;
            failed = 0;
            for j = 1:length(results.(fields{i}))
                if isfield(results.(fields{i})(j), 'Passed')
                    passed = passed + sum([results.(fields{i})(j).Passed]);
                    failed = failed + sum([results.(fields{i})(j).Failed]);
                end
            end
            total = passed + failed;
            if total > 0
                fprintf('%s: %d/%d passed\n', fields{i}, passed, total);
            end
        end
        total_passed = total_passed + passed;
        total_failed = total_failed + failed;
        total_tests = total_tests + (passed + failed);
    end
end

if total_tests > 0
    fprintf('\nOverall: %d/%d tests passed (%.1f%%)\n', ...
        total_passed, total_tests, 100*total_passed/total_tests);
else
    fprintf('No tests were run.\n');
end

end
