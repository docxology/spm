% Statistical Parametric Mapping - Refactored Modular Structure
% Version 25.00 (SPM25) <date>
%__________________________________________________________________________
%  ___  ____  __  __
% / __)(  _ \(  \/  )
% \__ \ )___/ )    (   Statistical Parametric Mapping
% (___/(__)  (_/\/\_)  SPM - https://www.fil.ion.ucl.ac.uk/spm/
%__________________________________________________________________________
%
% SPM25 - Refactored Modular Structure
%
% This version of SPM features a completely reorganized modular structure
% that improves code organization, maintainability, and usability while
% maintaining full backward compatibility.
%
% NEW MODULAR ORGANIZATION:
% ========================
%
% Core Modules:
% ------------
% core/          - Core utilities and basic operations
%   array/       - Array manipulation (spm_zeros, spm_cat, etc.)
%   math/        - Mathematical operations (spm_cross, spm_dot, etc.)
%   file/        - File operations (spm_existfile, spm_check_*, etc.)
%   system/      - System utilities (spm_check_installation, etc.)
%   utils/       - Display utilities (spm_axis, spm_barh, etc.)
%
% stats/         - Statistical functions and distributions
%   distributions/ - Probability distributions (spm_Bcdf, spm_Fcdf, etc.)
%   tests/       - Statistical tests (spm_P_Bonf, spm_P_clusterFDR, etc.)
%   inference/   - Statistical inference (spm_inv*, spm_vb_*, etc.)
%
% Specialized Modules:
% -------------------
% imaging/       - Image processing and spatial operations
%   spatial/     - Spatial transformations (spm_coreg, spm_realign, etc.)
%   smoothing/   - Smoothing operations (spm_bsplinc, spm_conv_*, etc.)
%   segmentation/ - Image segmentation (spm_preproc8, etc.)
%   rendering/   - Visualization (spm_render, spm_orthviews, etc.)
%
% dcm/           - Dynamic Causal Modeling
%   estimation/  - DCM estimation (spm_dcm_estimate, spm_dcm_fit, etc.)
%   specification/ - DCM specification (spm_dcm_specify, spm_dcm_ui, etc.)
%   results/     - DCM results (spm_dcm_results, spm_dcm_display, etc.)
%   peb/         - Parametric Empirical Bayes (spm_dcm_peb_*)
%   dem/         - Dynamic Expectation Maximization (spm_DEM_*)
%   adem/        - Active Inference (spm_ADEM_*)
%
% eeg/           - EEG/MEG processing
%   preprocessing/ - Signal preprocessing (spm_eeg_*prep, spm_eeg_*artefact)
%   inversion/   - Source inversion (spm_eeg_inv_*)
%   source/      - Source analysis (spm_eeg_*source, spm_eeg_*dipfit)
%   connectivity/ - Connectivity analysis (spm_eeg_*connectivity, spm_eeg_*tf)
%
% Support Modules:
% ---------------
% io/            - File I/O operations
%   nifti/       - NIfTI format support
%   dicom/       - DICOM format support
%   data/        - Data reading/writing
%
% design/        - Experimental design
%   specification/ - Design specification (spm_design_*)
%   contrasts/   - Contrast definitions (spm_*contrasts, spm_*ppi)
%
% bms/           - Bayesian Model Selection
%   core/        - Core BMS functions (spm_BMS_*)
%   analysis/    - BMS analysis (spm_bms_*)
%   display/     - BMS visualization (spm_bms_display_*)
%
% Advanced Modules:
% ----------------
% bayesian/      - Bayesian inference methods (spm_vb_*, spm_kl_*, etc.)
% modeling/      - Statistical modeling (spm_*reml, spm_*glm, etc.)
% math_ops/      - Mathematical operations (spm_*svd, spm_*eig, etc.)
% mesh/          - Mesh operations (spm_mesh_*)
% graph/         - Graph analysis (spm_graph_*)
% utilities/     - General utilities (remaining functions)
% spectral/      - Spectral analysis (spm_*spectral, spm_*mtf, etc.)
% mixture/       - Mixture modeling (spm_*mixture, spm_*kmeans)
% spatial/       - Spatial operations (spm_*slice, spm_*grid, etc.)
%
% Development and Documentation:
% ------------------------------
% fork/          - Development methods and documentation
%   docs/        - Documentation
%   setup/       - Setup scripts (spm_setup.m, spm_dev_setup.m)
%   dev/         - Development tools (spm_dev_info.m, spm_run_tests.m)
%   examples/    - Usage examples
%
% SETUP:
% ======
% For standard use:   spm_setup()
% For development:    spm_dev_setup()
%
% See README.md and fork/README.md for detailed information.
%__________________________________________________________________________
% Copyright (C) 1991,1994-2025 Wellcome Centre for Human Neuroimaging


%==========================================================================
% PROGRAMMERS NOTE:
% This <Contents.m> is the contents file for the refactored SPM25, used by
% spm('Ver') and MATLAB's ver to recover version information.
%   Line1: Toolbox Description
%   Line2: Version YY.0M[.MICRO] (SPMYY) dd-mmm-yyyy
% where SPMYY indicates the SPM version and YY.0M[.MICRO] is the revision:
% (https://www.fil.ion.ucl.ac.uk/spm/docs/development/versioning/)
% The github release action will automatically replace 25.00 and <date>
% with the release tag and date of the release.
%==========================================================================
