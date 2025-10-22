# ADEM Learning Example Documentation

## Overview

This example demonstrates **value learning** using the mountain car problem within the Active Inference framework (ADEM - Active DEM). It shows how agents can learn complicated and adaptive behaviors under the **free-energy principle** without requiring reinforcement learning paradigms or explicit reward/utility functions.

### Key Concepts Demonstrated

- **Free-energy minimization** as a unifying principle for perception, learning, and action
- **Active inference** where agents adjust internal states and environmental sampling to minimize free-energy
- **Self-supervised learning** of environmental dynamics and causal structure
- **Equilibrium density** as a way to specify desired behavioral policies
- **Generative modeling** of environmental dynamics

## State Space

The mountain car problem operates in a 2D continuous state space:

### State Variables
- **Position** (`x₁`): Car position along the track ∈ [-2, 2]
- **Velocity** (`x₂`): Car velocity ∈ [-2, 2]

### State Dynamics
The mountain car follows these physical dynamics:
```
ẋ₁ = x₂
ẋ₂ = a + v - dH/dx - x₂/η
```

Where:
- `a`: Action force (bounded by tanh)
- `v`: Exogenous perturbations
- `dH/dx`: Gravity component (height derivative)
- `η`: Friction coefficient (global variable, default = 8)

## Variables and Parameters

### Model Parameters (P structure)
```matlab
P.a     = 0;        % 0th order force coefficient
P.b     = [0 0];    % 1st order force coefficients [b₁, b₂]
P.c     = [0 0 0 0];% 2nd order force coefficients [c₁₁, c₁₂, c₂₁, c₂₂]
P.d     = 0;        % Action coefficient
```

### Precision Parameters
```matlab
pC      = speye(length(spm_vec(P)));  % Parameter prior covariance
pC(end) = 0;                          % Fixed action coefficient
```

### Generative Model Structure (G)
```matlab
G(1).E.s = 1/2;     % Smoothness prior (position)
G(1).E.n = 4;       % Smoothness prior (velocity)
G(1).E.d = 2;       % Smoothness prior (action)

G(1).x  = [0; 0];   % Initial state [position; velocity]
G(1).f  = 'spm_fx_mountaincar';  % State transition function
G(1).g  = @(x,v,a,P) x;          % Observation function (identity)

G(1).pE = P;        % Expected parameters
G(1).pC = pC;       % Parameter precision
G(1).V  = exp(8);   % State noise precision
G(1).W  = exp(8);   % Observation noise precision

G(2).a  = 0;        % Action (second level)
G(2).v  = 0;        % Inputs (second level)
G(2).V  = exp(16);  % Higher precision for action
```

### Recognition Model Structure (M)
Similar structure to G but represents the agent's internal model of the environment.

## Functions and Operations

### Core SPM Functions Called

#### 1. `spm_fx_mountaincar(x, v, a, P)`
**Purpose**: State transition function for mountain car dynamics
**Inputs**:
- `x`: State vector [position, velocity]
- `v`: Exogenous force
- `a`: Action
- `P`: Parameter structure
**Outputs**: `f` - Flow vector ẋ = [ẋ₁, ẋ₂]
**Key Operations**:
- Computes action force: `a = tanh((P.d*a + P.a + P.b*x + P.c*kron(x,x))/2)`
- Calculates gravity: `dHdx` (piecewise function for left/right sides)
- Returns: `ẋ = [x₂; a + v - dHdx - x₂/η] * dt`

#### 2. `spm_mountaincar_Q(x)`
**Purpose**: Computes desired equilibrium density for the mountain car
**Inputs**: `x` - State space grid points
**Outputs**: `Q` - Probability density values
**Key Operations**:
- Defines target states: `qE = [1, -1; 0, 0]` (positions 1 and -1, zero velocity)
- Uses Gaussian mixture: `q = spm_MNpdf(qE(:,k)', qC, x(i,:))`
- Normalizes by number of components

#### 3. `spm_ADEM_M_set(G)`
**Purpose**: Sets up hierarchical (multi-level) ADEM structure
**Inputs**: `G` - Generative model structure
**Outputs**: `G` - Configured model with proper hierarchical structure

#### 4. `spm_ndgrid(x)`
**Purpose**: Creates multi-dimensional grids for evaluation
**Inputs**: `x` - Cell array of 1D coordinate vectors
**Outputs**: `[X, x]` - Grid points and coordinate arrays

#### 5. `spm_fmin('spm_mountaincar_fun', P, pC, G)`
**Purpose**: Optimizes parameters to maximize equilibrium density
**Inputs**:
- Function name: `'spm_mountaincar_fun'`
- Initial parameters: `P`
- Prior covariance: `pC`
- Model structure: `G`
**Outputs**: `P` - Optimized parameters

#### 6. `spm_fp_display_density(M, x)`
**Purpose**: Displays flow field and equilibrium density
**Inputs**:
- `M` - Model structure
- `x` - Grid coordinates
**Outputs**: Visualization of vector field and density

#### 7. `spm_fp_display_nullclines(M, x)`
**Purpose**: Displays nullclines (where ẋ₁=0 and ẋ₂=0)
**Inputs**:
- `M` - Model structure
- `x` - Grid coordinates
**Outputs**: Nullcline visualization

#### 8. `spm_conv(C, 4)`
**Purpose**: Convolves perturbation signal with smoothing kernel
**Inputs**:
- `C` - Input signal
- Kernel size: `4`
**Outputs**: `C` - Smoothed signal

#### 9. `spm_ADEM(DEM)`
**Purpose**: Runs Active DEM inference algorithm
**Inputs**: `DEM` - Complete DEM structure with M, G, C, U
**Outputs**: `DEM` - Updated structure with posterior beliefs

#### 10. `spm_DEM_qU(DEM.qU, DEM.pU)`
**Purpose**: Displays posterior expectations and uncertainty
**Inputs**:
- `DEM.qU` - Posterior expectations
- `DEM.pU` - Posterior uncertainty
**Outputs**: Visualization of belief trajectories

#### 11. `spm_mountaincar_movie(DEM)`
**Purpose**: Creates animation of mountain car trajectory
**Inputs**: `DEM` - DEM structure with trajectory data
**Outputs**: Interactive movie visualization

## Algorithm Flow

### Phase 1: Model Setup (Lines 25-58)
1. Initialize generative model `G` with smoothness priors
2. Set initial parameters `P` (naive model)
3. Configure level 1: dynamics and observation functions
4. Configure level 2: action and input handling
5. Set up model using `spm_ADEM_M_set(G)`

### Phase 2: Environment Optimization (Lines 77-96)
1. Load pre-optimized parameters or run optimization
2. Use `spm_fmin` to maximize equilibrium density
3. Save optimized model to `mountaincar_model.mat`

### Phase 3: Visualization (Lines 106-143)
1. Display uncontrolled vs controlled flow fields
2. Show nullclines for both naive and optimized models
3. Compare equilibrium densities

### Phase 4: Learning Phase (Lines 147-182)
1. Create naive recognition model `M` with initial parameters `P0`
2. Generate perturbation sequence `C` for training
3. Run `spm_ADEM(DEM)` to learn environmental dynamics
4. Save learned model

### Phase 5: Evaluation (Lines 205-244)
1. Set up uncontrolled environment with action capability
2. Generate test perturbations
3. Run active inference with learned model
4. Visualize performance and create movie

## Data Structures

### DEM Structure
```matlab
DEM.M    = M;       % Recognition model (agent's beliefs)
DEM.G    = G;       % Generative model (environment)
DEM.C    = C;       % Perturbations/observations
DEM.U    = U;       % Actions/control signals
```

### Model Components
- `.f`: State transition function
- `.g`: Observation function
- `.pE`: Expected parameters
- `.pC`: Parameter precision/covariance
- `.V`: State noise precision
- `.W`: Observation noise precision
- `.E`: Smoothness hyperparameters

## Key Insights Demonstrated

1. **No explicit rewards**: Behavior emerges from equilibrium density specification
2. **Self-supervised learning**: Agent learns by minimizing free-energy during environmental interaction
3. **Active inference**: Agent selects actions to minimize expected free-energy
4. **Hierarchical modeling**: Multi-level generative models for dynamics and actions
5. **Parameter learning**: Online optimization of model parameters through inference

## Usage Notes

- Set `DEMO = 1` to run parameter optimization phase
- Set `DEMO = 2` to run full optimization including `spm_fmin`
- Results are saved to `mountaincar_model.mat` for reuse
- Interactive movie requires clicking on the car visualization

## References

This implementation is based on the mountain car problem from:
> "Gaussian Processes in Reinforcement Learning" by Carl Edward Rasmussen and Malte Kuss

The active inference framework is developed in the free-energy principle literature by Karl Friston and colleagues.
