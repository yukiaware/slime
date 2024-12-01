# slime
3D Slime (Viscoelastic Fluid) Simulation using OpenGL (in progress)

## Features
- SPH-based Fluid Simulation
- Surface Extraction using Marching Cubes Algorithm
- Parallelized Using CUDA

## Clone with submodules
```bash
git clone --recursive https://github.com/harutea/slime.git
```
Or,
```bash
git clone https://github.com/harutea/slime.git
cd slime
git submodule update --recursive --init
```

## How to build
```bash
mkdir build
cd build
cmake ..
cmake --build . --config Release
```
