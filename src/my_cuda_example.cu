#include "my_cuda_example.h"

/*************************************************************/
__device__ int my_kernel_helper(int a, int b)
{
    return a*b;
}
/*************************************************************/
__global__ void my_kernel()
{
    // extern __shared__ int my_dyn_shared_mem[];
    //        __shared__ int my_stat_shared_mem[42];
    //        __shared__ int shared_var;
    //
    // blockIdx.x
    // blockDim.x
    // threadIdx.x
    //
    // __syncthreads();
    //
    // atomicAdd(&shared_var, 167);
}
/*************************************************************/
void run_on_cuda()
{
    float* device_pointer;
    int size = 1024*sizeof(float);

    cudaMalloc(&device_pointer, size);
    //
    // cudaMemcpy(device_pointer, host_pointer, size, cudaMemcpyHostToDevice);
    //
    // my_kernel<<<a, b, c>>>();
    //
    // cudaMemcpy(host_pointer, device_pointer, size, cudaMemcpyDeviceToHost);
    //
    cudaFree(device_pointer);
}
/*************************************************************/
