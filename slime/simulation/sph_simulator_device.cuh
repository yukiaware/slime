#ifndef SPH_SIMULATOR_DEVICE_CUH
#define SPH_SIMULATOR_DEVICE_CUH

#include <cuda.h>
#include <cuda_runtime.h>
#include <device_launch_parameters.h>
#include "sph_simulator.cuh"

namespace slime {
extern __device__ float poly6KernelDevice(float3 r, float h);
extern __device__ float spikyKernelDevice(float3 r, float h);
extern __device__ float gradientSpikyKernelDevice(float3 r, float h);
extern __device__ float viscosityKernelDevice(float3 r, float h);
extern __device__ float laplacianViscosityKernelDevice(float3 r, float h);

extern __global__ void updateScalarFieldDevice(float *colorFieldDevice,
                                               Particle *particlesDevice,
                                               int gridSize,
                                               float maxColorQuantity);

extern __global__ void computeDensityDevice(Particle *particlesDevice);

extern __global__ void computePressureDevice(Particle *particlesDevice);

extern __global__ void computePressureForceDevice(Particle *particlesDevice,
                                                  double deltaTime);

extern __global__ void computeViscosityForceDevice(Particle *particlesDevice,
                                                   double deltaTime);

extern __global__ void computeSurfaceTensionDevice(Particle *particlesDevice,
                                                   double deltaTime);

extern __global__ void computeGravityDevice(Particle *particlesDevice,
                                            double deltaTime);

extern __global__ void computeWallConstraintDevice(Particle *particlesDevice,
                                                   double deltaTime);

extern __global__ void computePositionDevice(Particle *particlesDevice,
                                             double deltaTime);

extern __global__ void updateSpatialHash(Particle *particlesDevice);

extern __global__ void copyPositionToVBO(float *d_positions,
                                         Particle *particlesDevice);
} // namespace slime

#endif