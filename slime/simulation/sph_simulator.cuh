#ifndef SPH_SIMULATOR_H
#define SPH_SIMULATOR_H

#include "marching_cubes.h"
#include <glm/glm.hpp>
#include <memory>
#include <slime/constants/sph_simulator_constants.h>

namespace slime {

struct Particle {
  glm::vec3 position, velocity, acceleration;
  float density, pressure, mass;
  glm::vec4 color;
  float life;
};

__global__ void updateScalarFieldDevice(float *colorFieldDevice,
                                        Particle *particlesDevice,
                                        int gridSize);

class SPHSimulator {

public:
  SPHSimulator();
  ~SPHSimulator();

  void initScalarField();
  void updateScalarField();
  void updateParticles(double deltaTime);

  float poly6Kernel(glm::vec3 r, float h);
  float spikyKernel(glm::vec3 r, float h);
  float gradientSpikyKernel(glm::vec3 r, float h);
  float viscosityKernel(glm::vec3 r, float h);
  float laplacianViscosityKernel(glm::vec3 r, float h);

  void computeDensity();
  void computePressureForce(double deltaTime);
  void computeViscosityForce(double deltaTime);
  void computeGravity(double deltaTime);

  std::vector<MarchingCubes::Triangle> extractSurface();

private:
  std::vector<Particle *> particles;
  Particle *particlesDevice;

  static constexpr int GRID_SIZE = 200;
  float colorField[GRID_SIZE][GRID_SIZE][GRID_SIZE];
  float *colorFieldDevice;

  // float densityField[GRID_SIZE][GRID_SIZE][GRID_SIZE];
  // float pressureField[GRID_SIZE][GRID_SIZE][GRID_SIZE];
  // float viscosityField[GRID_SIZE][GRID_SIZE][GRID_SIZE];
  // float surfaceTensionField[GRID_SIZE][GRID_SIZE][GRID_SIZE];
};

} // namespace slime
#endif