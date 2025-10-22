# SPM Fork - Development and Documentation

This `fork/` directory contains the development methods, documentation, setup scripts, and examples for the refactored SPM package.

## Directory Structure

```
fork/
├── docs/           # Documentation
├── setup/          # Setup and installation scripts
├── dev/            # Development tools and utilities
└── examples/       # Usage examples and tutorials
```

## Setup

### For Users
Run the standard setup script:
```matlab
spm_setup()
```

### For Developers
Run the development setup script:
```matlab
spm_dev_setup()
```

## Modules Overview

The refactored SPM is organized into the following modules:

### Core Modules
- **core/** - Core utilities and basic operations
  - `array/` - Array manipulation functions
  - `math/` - Mathematical operations
  - `file/` - File operations
  - `system/` - System utilities
  - `utils/` - Display and utility functions

- **stats/** - Statistical functions
  - `distributions/` - Probability distributions
  - `tests/` - Statistical tests
  - `inference/` - Statistical inference

### Specialized Modules
- **imaging/** - Image processing and spatial operations
  - `spatial/` - Spatial transformations
  - `smoothing/` - Smoothing operations
  - `segmentation/` - Image segmentation
  - `rendering/` - Visualization

- **dcm/** - Dynamic Causal Modeling
  - `estimation/` - DCM estimation
  - `specification/` - DCM specification
  - `results/` - DCM results
  - `peb/` - Parametric Empirical Bayes
  - `dem/` - Dynamic Expectation Maximization
  - `adem/` - Active Inference

- **eeg/** - EEG/MEG processing
  - `preprocessing/` - Signal preprocessing
  - `inversion/` - Source inversion
  - `source/` - Source analysis
  - `connectivity/` - Connectivity analysis

### Support Modules
- **io/** - File I/O operations
  - `nifti/` - NIfTI format support
  - `dicom/` - DICOM format support
  - `data/` - Data reading/writing

- **design/** - Experimental design
  - `specification/` - Design specification
  - `contrasts/` - Contrast definitions

- **bms/** - Bayesian Model Selection
  - `core/` - Core BMS functions
  - `analysis/` - BMS analysis
  - `display/` - BMS visualization

### Advanced Modules
- **bayesian/** - Bayesian inference methods
- **modeling/** - Statistical modeling
- **math_ops/** - Mathematical operations
- **mesh/** - Mesh operations
- **graph/** - Graph analysis
- **utilities/** - General utilities
- **spectral/** - Spectral analysis
- **mixture/** - Mixture modeling
- **spatial/** - Spatial operations

## Development

### Adding New Functions
1. Determine the appropriate module for your function
2. Place the function in the corresponding module directory
3. Update the module's Contents.m file
4. Add documentation and examples
5. Update tests if applicable

### Testing
Run the test suite:
```matlab
spm_run_tests()
```

### Documentation
- Update module documentation in `docs/`
- Add examples in `examples/`
- Update function help text

## Contributing

See the contribution guidelines in `dev/CONTRIBUTING.md`.

## Compatibility

This refactored structure maintains backward compatibility with existing SPM code through:
- Path compatibility scripts
- Function forwarding where needed
- Consistent naming conventions
- Preserved API interfaces

## Support

For issues and questions:
- Check the documentation in `docs/`
- Review examples in `examples/`
- Consult the development tools in `dev/`
