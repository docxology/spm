```
   ___  ____  __  __
  / __)(  _ \(  \/  )  
  \__ \ )___/ )    (   Statistical Parametric Mapping
  (___/(__)  (_/\/\_)  SPM - https://www.fil.ion.ucl.ac.uk/spm/
```

[![Platform: MATLAB](https://img.shields.io/badge/MATLAB-orange.svg?style=plastic)](https://www.mathworks.com)
[![Open in MATLAB Online](https://www.mathworks.com/images/responsive/global/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=spm/spm)
[![License: GPL](https://img.shields.io/badge/license-GPL-blue.svg)](https://opensource.org/licenses/GPL-2.0)
[![Tests](https://github.com/spm/spm/actions/workflows/matlab.yml/badge.svg)](https://github.com/spm/spm/actions/workflows/matlab.yml)

This README gives a brief introduction to the SPM software. Full details
can be found on the [SPM website](https://www.fil.ion.ucl.ac.uk/spm/).
 
See also `Contents.m`, `AUTHORS.txt` and `LICENCE`.
  
# SPM25 - Refactored Modular Structure

Statistical Parametric Mapping is the construction and assessment of
spatially extended statistical processes used to test hypotheses about
functional imaging data. These ideas have been instantiated in a
free and open source software that is called SPM.

This release (SPM25) features a **completely reorganized modular structure**
that improves code organization, maintainability, and usability while
maintaining **full backward compatibility** with existing SPM code.

## Key Features

- **Modular Organization**: 819 functions organized into logical modules
- **Improved Maintainability**: Clear separation of concerns
- **Enhanced Documentation**: Comprehensive module documentation
- **Development Tools**: Setup scripts, testing framework, and development utilities
- **Backward Compatibility**: Existing code continues to work without changes

## Module Organization

The SPM codebase is now organized into specialized modules:

### Core Modules
- **core/** - Basic utilities and operations
- **stats/** - Statistical functions and distributions
- **imaging/** - Image processing and spatial operations

### Specialized Modules
- **dcm/** - Dynamic Causal Modeling
- **eeg/** - EEG/MEG processing
- **io/** - File I/O operations
- **design/** - Experimental design
- **bms/** - Bayesian Model Selection

### Advanced Modules
- **bayesian/** - Bayesian inference methods
- **modeling/** - Statistical modeling
- **mesh/** - Mesh operations
- **graph/** - Graph analysis
- **spectral/** - Spectral analysis

## Installation and Setup

### Quick Start
```matlab
% Standard setup (recommended for users)
spm_setup()

% Development setup (for contributors)
spm_dev_setup()
```

### Development Tools
- `spm_dev_info()` - Show development information
- `spm_run_tests()` - Run test suite
- `fork/docs/` - Comprehensive documentation
- `fork/examples/` - Usage examples

## Documentation

- **Main Documentation**: See `fork/README.md` for detailed module information
- **Function Documentation**: Each module contains detailed help text
- **Examples**: Usage examples in `fork/examples/`
- **Development Guide**: Contributing guidelines in `fork/dev/`

# Software

The SPM software is a suite of MATLAB functions, scripts and data files,
with some externally compiled C routines, implementing Statistical
Parametric Mapping.  For the best experience, we recommend running 
SPM using MATLAB, a commercial engineering mathematics package. 
MATLAB is produced by [MathWorks, Natick, MA,
USA](https://www.mathworks.com/). Standalone versions of SPM that 
do not require MATLAB are also available.

SPM requires only core MATLAB to run (no special toolboxes are required).

SPM is tested using the versions of MATLAB from the last 4-5 years. 
Binaries of the external C-MEX routines are provided for Windows, Linux
and Mac.  The source code is supplied and can be compiled with a C
compiler (Makefile provided). See [https://www.fil.ion.ucl.ac.uk/spm/software/spm12/](https://www.fil.ion.ucl.ac.uk/spm/docs/development/compilation/) for details.

Although SPM will read image files from previous versions of SPM, there
are differences in the algorithms, templates and models used.  Therefore,
we recommend you use a single SPM version for any given project.

# File format

SPM uses the NIFTI-1 data format as standard.  Take a look at
https://nifti.nimh.nih.gov/ for more information on the NIFTI-1 file
format.

The old SPM2 version of Analyze format can be read straight into SPM,
but results will be written out as NIFTI-1.  If you still use this format,
then it is important that you ensure that `spm_flip_analyze_images` has
been set appropriately for your data.

The MINC and ECAT7 formats can not be read straight into SPM, although
conversion utilities have been provided.  Similarly, a number of DICOM
flavours can also be converted to NIFTI-1 using tools in SPM.

# Resources

The SPM documentation website is the central repository for SPM resources:
[https://www.fil.ion.ucl.ac.uk/spm/docs/](https://www.fil.ion.ucl.ac.uk/spm/docs/)

Introductory material, installation details, documentation and course details
are published on the site.

There is an SPM email discussion list, hosted at <spm@jiscmail.ac.uk>.
The list is monitored by the authors, and discusses theoretical,
methodological and practical issues of Statistical Parametric Mapping and
SPM.  The SPM website has further details:
https://www.fil.ion.ucl.ac.uk/spm/support/

Please report bugs via the [Issues page](https://github.com/spm/spm/issues) 
on SPM's Github repository.

# Authors

SPM is developed under the auspices of the Methods Group at the Functional 
Imaging Laboratory (FIL), within the Department of Imaging Neuroscience, 
UCL Queen Square Institute of Neurology, University College London (UCL), UK.

SPM94 was written primarily by Karl Friston in the first half of 1994,
with assistance from John Ashburner (MRC-CU), Jon Heather (WDoIN), and
Andrew Holmes (Department of Statistics, University of Glasgow).
Subsequent development, under the direction of Prof. Karl Friston at the
Wellcome Department of Imaging Neuroscience, has benefited from
substantial input (technical and theoretical) from: John Ashburner
(WDoIN), Andrew Holmes (WDoIN & Robertson Centre for Biostatistics,
University of Glasgow, Scotland), Jean-Baptiste Poline (WDoIN &
CEA/DRM/SHFJ, Orsay, France), Christian Buechel (WDoIN), Matthew Brett
(MRC-CBU, Cambridge, England), Chloe Hutton (WDoIN) and Keith Worsley
(Department of Statistics, McGill University, Montreal Canada).

See `AUTHORS.txt` for a complete list of SPM co-authors.

We would like to thank everyone who has provided feedback on SPM.

# Disclaimer, copyright & licencing

SPM is free software; you can redistribute it and/or modify it under the
terms of the GNU General Public License as published by the Free Software
Foundation; either version 2 of the License, or (at your option) any later
version.

This program is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
for more details.

You should have received a copy of the GNU General Public License along
with this program.  If not, see <https://www.gnu.org/licenses/>.

SPM is supplied as is: No formal support or maintenance is provided or
implied.

```
Copyright (C) 1991,1994-2025 Functional Imaging Laboratory
```
