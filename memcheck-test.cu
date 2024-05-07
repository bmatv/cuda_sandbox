#include <assert.h>
#include <stdio.h>
 
#define N 1023
 
__global__ void scaleArray(float* array, float value) {
  int threadGlobalID    = threadIdx.x + blockIdx.x * blockDim.x;
  array[threadGlobalID] = array[threadGlobalID]*value;
  return;
}
 
int main() {
  float* array;
  cudaMallocManaged(&array, N*sizeof(float)); // Allocate, visible to both CPU and GPU
  for (int i=0; i<N; i++) array[i] = 1.0f;    // Initialize array
 
  printf("Before: Array 0, 1 .. N-1: %f %f %f\n", array[0], array[1], array[N-1]);
  scaleArray<<<4, 256>>>(array, 3.0);
  cudaDeviceSynchronize();
 
  printf("After : Array 0, 1 .. N-1: %f %f %f\n", array[0], array[1], array[N-1]);
  assert(array[N/2] == 3.0); // Check it's worked
  exit(0);
}
