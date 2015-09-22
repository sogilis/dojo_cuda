#include "my_cuda_example.h"
#include <ctime>
#include <stdio.h>

typedef struct
{
    float speed_x, speed_y;
    float pos_x, pos_y;
} particle;
/*************************************************************/
__global__ void my_kernel(particle* particles)
{
    particle *p = &particles[blockIdx.x*blockDim.x + threadIdx.x];
    p->pos_x += p->speed_x;
    p->pos_y += p->speed_y;
}
/*************************************************************/
void run_on_cuda()
{
    int n = 1024*1024*100;

    particle* host_pointer, *device_pointer;
    int size = n*sizeof(particle);

    //allocation
    host_pointer = (particle*)malloc(size);
    cudaMalloc(&device_pointer, size);

    //fill host data
    //srand(time(NULL));
    for(int i=0 ; i<n ; i++)
    {
        host_pointer[i].speed_x = 1.0;
        host_pointer[i].speed_y = 3.2;
        host_pointer[i].pos_x = 0.0;
        host_pointer[i].pos_y = 0.0;
    }

    //send data
    cudaMemcpy(device_pointer, host_pointer, size, cudaMemcpyHostToDevice);

    //compute
    #define CUDA_EXEC
    clock_t t = clock();
   
    #ifdef CUDA_EXEC
        my_kernel<<<n / 1024, 1024>>>(device_pointer);
    #else
        for(int i=0 ; i<n ; i++)
        {
            particle *p = &host_pointer[i];
            p->pos_x += p->speed_x;
            p->pos_y += p->speed_y;
        }
    #endif
    clock_t t2 = clock() - t;
    printf("%f secs\n", (double)t2 / CLOCKS_PER_SEC);
    //retrieve data
    cudaMemcpy(host_pointer, device_pointer, size, cudaMemcpyDeviceToHost);

    cudaFree(device_pointer);
    free(host_pointer);
}
/*************************************************************/
