---
layout: post
title: CUDA basics
date: "2020-03-28 00:00:00"
description: Introduction to CUDA concepts
lang: en
locale: en_US
author: Paul-Emmanuel Broux
excerpt: General purpose processing on graphics processing units (GPGPU) have gained a huge interest within past decades. GPGPU rests on CPU deciding to delegate heavy arithmetic and parallel work to GPU. This more and more common type of task is hardly done by CPU. Having GPU already among nearly all servers and laptops avoids creating and introducing new specific and costly hardware componant for some aplications. GPGPU is therefore a solid solution to apply and to probe.
comments: true
hidden: false
---



General purpose processing on graphics processing units (GPGPU) have gained a huge interest within past decades. GPGPU rests on CPU deciding to delegate heavy arithmetic and parallel work to GPU. This more and more common type of task is hardly done by CPU. Having GPU already among nearly all servers and laptops avoids creating and introducing new specific and costly hardware componant for some aplications. GPGPU is therefore a solid solution to apply and to probe.

# CUDA

As its name suggests, GPU is specified for graphic processing. This component has been upgraded through years to answer the constant growing need of gamers. Consequently, graphic approach was the only perspective to programm a GPU with tools like OpenGL or Microsoft Direct3D. To fill this gap, Nvidia has developed CUDA (Compute Unified Device Architecture) to fully exploit all Nvidia's GPUs potential.    

Of course, there are other solutions like CTM (Close to Metal) from AMD and even a proprietary free one called OpenCL. But CUDA has several assets on its own. First of all is CUDA's owning company, Nvidia's GPUs hold the most part of the market. Developping on the most widespread component is an obvious choice. Furthermore, CUDA is the subject of an active and constant support by both Nvidia and the community. We can find a tremendous amount of knowledge and help out there. Finally, as it is the same company that develop the API and its related GPUs, we observe better performances. Sadly, the main drawback about CUDA is the proprietary aspect. Even with the best will, we can't obtain every details of how GPUs and CUDA really work. Despite that, CUDA is still a powerfull and valuable application programming interface (API) that works with several languages such as C, C++ and Fortran.  

This post will present the basic aspects of CUDA and concepts to understand. First we will introduce the programmer point of view followed by the hardware one. Finally we will highlight the key role of memories in CUDA by matching the programmer view with memories. Then presenting the global GPU architecture around memories and detail each important one of them.   

## Basic Concepts

In CUDA, it's important to distinguish the programmer and hardware view. But first let's notice that we are programming with two major components, the CPU also called host and the GPU which is the device. All the code will be passed by the host and it will allocate then transfer all needed data to the device. Finally, the host will launch at some point the device code aka kernel code. 

### Compute capability (CC)

CUDA is an evolving API. In fact it started in 2007 and has evoluated as GPUs do. Thus, CUDA will have more and more functionnalities through  years. An interesting and valuable aspect of CUDA is its ability to still run on old GPUs. This is why CUDA has introduced an attribute on all different GPU's series to inform about the device capacity to achieve certain CUDA functionalities. This attribute has been called *compute capability*. According to its value, it can change the behavior of some basic concepts or architectural functionalities and even given reference values. So we will present an introduction but we always need to check the Nvidia's documentation about our own CC.  

Currently, this paper is written in a project context working with a Jetson TX2 and a 6.2 (major.minor) CC. As a consequence, concepts and values are more specific to our CC architecture. For further informations and details, check the [Nvidia CUDA C programming guide](https://docs.nvidia.com/cuda/cuda-c-programming-guide/ "CUDA Toolkit Documentation"). 

### Programmer view

These are concepts we are going to manipulate in our code. They are really important to understand and for that reason we choose to take a top-down approach.  

##### Kernel

This is the parallel code we are going to launch through the host on the device. In fact we will call the kernel code defined with the `__global__` declaration specifier inside host's main function. This call has to be done with two parameters expressing the total amount of threads we want to execute the kernel code in parallel. The syntax is :

```c++

__global__ kernelFunctionName(arg1, arg2, ..., arg n){
    //Find the thread's id which is executing the kernel code 
    int i = threadIdx.x;

    //Kernel code to excute 
    ....
    ....
}


int main(int argc, char *argv[] ){

    //host code containing also device memory allocation and transfer
    ....
    ....

    //Lauching the kernel code
    kernelFunctionName<<<Grid,ThreadsPerBlock>>>(arg1, arg2, ..., arg n);

}
    
```

As we can see, the `__global__` function - aka kernel -  is launched by the main host code with the *Grid* and *ThreadsPerBlock* parameters. The grid is the total amount of blocks which contain *ThreadsPerBlock* threads. So we launch our kernel code with ThreadsPerBlock*Grid threads seperated equally in grid's blocks.  

A kernel code is typically asynchronous. So we will be able to continue our host code and some times even other device instructions according to the CC.  

Kernel code is stored into what we call the global memory (the main device's memory) with a limited size corresponding to 512 million instructions. It will also use the instruction memory caches.



##### Grid

Created when a kernel in launched, the grid is composed of blocks. A grid can be either of 1, 2 or 3-dimensions accorgind to CC. Blocks in a grid will present the exact same amount of threads per blocks. Every block of a grid is able to run in a total independant and parallel way. Thus, there are no synchronizations between those blocks and no dedicated communication way.  

A grid size is limited to 65 535 blocks in each dimension except for x which has been change to 2^31 - 1. The grid argument given in kernel function call can either be a dim3 structure or a simple int. That way, we can decide specifically the grid we want as presented on the figure below. 

<p align="center">
<img 
    src="{{ site.baseurl }}/assets/images/blog/cuda/programmer_view_grid.png"/>
</p>

In CUDA, the two reasons to choose a multi-dimensional grid is on one hand to overtake the one-dimensional block size limitation and by extension the thread number limitation. And on the other hand to get a better representation of a potential multi dimensional problem.

##### Blocks

A block is a group of threads in 1, 2 or 3 dimensions. These dimensions are set when launching the kernel with the *ThreadsPerBlock* argument. A block is composed of 1024 threads as a maximum. Therefore we have threads in each dimension x,y and z that follow this inequation : x*y*z <= 1024. But only x and y dimension can handle 1024 threads. Z dimension is limited by an amount of 64 threads. A block consist of a group of dedicated ressources - registers (32K at the maximum) and shared memory -  when executed on a GPU's so called processor also known as CUDA core.

Block represents a group of threads that can easily synchronize (barrier) and communicate through different hardware components along with the CUDA API. As a consequence, sizing blocks must take into account the need to communicate and synchronize among threads. Block is a subdivision of the whole problem that has to be solved independantly.

<p align="center">
<img src="{{ site.baseurl }}/assets/images/blog/cuda/programmer_view_block.png">
</p>



##### Thread

Finally we have the smallest coarse-grained of configuration which is the thread. As explained, thread is what will execute a kernel code in parallel. One of the most important thing is the thread id. This id will split the whole work and therefore data to treat between threads. There are two ways to have the thread ID depending of the perspective. We have the local thread id within a block and the global one which considers all the threads in the launched grid. Local ID can easily be found with CUDA API. The global one depends on the grid configuration and need what we call a linearization. 

```c++

__global__ kernelFunctionName(arg1, arg2, ..., arg n){
    //Find the thread's id which is executing the kernel code.  
    
    //Local ID
    int x = threadIdx.x; //1D component 
    int y = threadIdx.y; //2D component if exists
    int z = threadIdx.z; //3D component if exists

    //Global ID
    int idx = blockIdx.x * blockDim.x + threadIdx.x;    // x global ID in 1D
    int idy = blockIdx.y * blockDim.y + threadIdx.y;    // y global ID in 1D 
    int w   = blockDim.x * gridDim.x;                   // Grid width
    int global2D = y * w + x;                           // Global ID in 2D

    //Kernel code to excute 
    ....
    ....
}

    
```



The above example try to highlight ways to obtain local and global IDs in 1D and 2D. Of course in most kernel codes, we only need few of these IDs (only global 1D ID or even just local 1D ID as example, it depends of the problem to solve). The one needed will only depends of the kernel code and the grid architecture decided. We see that make use of dimensions make global index calculation more difficult to get.

Following figure represent a 2D grid with 4x3 blocks of 4x3 threads. It represents global index for each threads and local with grey contour. 

<p align="center">
<img src="{{ site.baseurl }}/assets/images/blog/cuda/thread_index_calculation.png">
</p>

Threads are running into a block which allocate some ressources. By extension, a thread will take a part of its block's ressources. Therefore we put a limit to the amount ressources dedicated per thread. This limit can be tuned by the compiler. In term of registers it's about 255. On account of performance purpose, compiler limit drastically the amount of registers used by a thread. Approximately, it will choose a number that allows a certain amount of parallelism and prevent too much register spilling.

### Hardware view

When launching a kernel through programmer view concepts, the hardware will transpose those notions with hardware reality to fullfill its work. 

##### Streaming Multiprocessor (SM)

Streaming Multiprocessor is the highest coarse-grained in hardware. Each GPU consist of a group of SMs. It gathers all crucial ressources needed to execute blocks of a grid as :  

* Execution units :
    - 128 CUDA cores for arithmetic operations,
    - 32 special function units (SFUs) for single precision floating-point functions,
    - ...
* Caches :  
    - L1/Texture
    - Constant (Read-only)
    - Texture (Read-only)
* 4 warp schedulers,
* 32-bit registers (64K),
* ...

The hardware will assigned blocks to a SM according to available ressources. Block's threads will only run onto one and same SM. Threads of that block will be able to communicate and synchronize through ressources given by the SM. Thus, active (resident) blocks per SM is limited to 32. When a SM executes a block, it executes all the inner threads at once. The only way to free ressources is to finish the whole execution of a block. 

Like blocks, resident threads are limited on a SM. This limit is set to 2048 for our CC. Thereby, block size will be taken into account to set the maximum of resident blocks per SM. These limitations correspond to the need to keep at least enough ressources for performance. This has been showned by [Vasily Volkov](https://www.nvidia.com/content/GTC-2010/pdfs/2238_GTC2010.pdf "Better Performance at Lower Occupancy") [2].

##### Warp

To use fully ressources offered by GPU, CUDA introduce an abstraction which is an implicitly synchronized group of 32 threads called warp. Each block of threads is divided into warps. So it is obviously better to create a blocksize multiple of 32. Warps are created all in the same way, each warp contains threads of consecutive ID beginning with 0. As a block executes the same kernel code, threads within a warp execute the same instruction at each row. When a block is launched, it is considered active as long as its warps haven't been executed entirely. When a warp is assigned for execution, it will be distributed among SM's inner schedulers. On any warp's time issue - caused by data dependencies or read/write operations - the involved warp won't let go any of its registers. This feature limits the number of registers available but offers a fast switch context. Then each scheduler will transmit - if possible - one instruction of one among its assigned warps that is ready to execute (already posess its registers). Other warps will launch only if ressources allow to do so. By now, resident warps on a SM is limited to 64.  

The whole point of warps is to exploit SIMT (Single Instruction Multiple Thread) architecture. A warp executes one common instruction at a time. So it all take sense when the same instruction has to be executed for all threads at the same time. The only change between threads being executed is the thread index exploited. Taking that into account, we can see that threads within a same block and by extension within a same warp can execute different instructions or access different adresses. If threads do so, then we loose the SIMT point all we'll have a serialize execution which will flow drastically performance. About memory access, having different adresses but adjacent don't serialize threads and can still take advantage of SIMT.  


The image below resume the link between programmer view and how it is executed on hardware. 

<p align="center">
<img src="{{ site.baseurl }}/assets/images/blog/cuda/hardware_view.png">
</p>

Warp have also their own id inside a block called *warp ID* (warpid). Then we also have the coordinate of the thread in a warp : *lane ID* (laneid).  
warpid = threadIdx.x / 32  
laneid = threadIdx.x % 32  

In a multi-dimensional block, we have a x major ordering. So we just find the local ID taking into account dimensions and divide it by 32.  
 
NB : Threads can directly access their laneid through a special register *%laneid*.  

### Memories

Memory hold an important place into CUDA programming. This chapter will be divided into two main parts. First it will introduce the memory hierarchy. It represents the associations between coarse-grained concepts and associated memory spaces. Then we will present one by one those memories and corresponding outline with a clear representation.

##### Memory hierarchy

The main point here is summed up in the figure below. Relations underline that each thread has its own local memory and each block its own shared one. Communication through depicted memories is possible between enclosed concepts of each level. For example, threads within a same block can communicate through the dedicated shared memory. One thing to notice is that it's possible to launch multiple kernels and thus grids but overlapping won't necessarily happen since ressources are limited and one kernel will often "fill up" the whole GPU. 

<p align="center">
<img src="{{ site.baseurl }}/assets/images/blog/cuda/memory_hierarchy.png">
</p>


##### Memories and architecture

Before getting into details about each memory, let's have a quick general look on GPU's architecture focusing on memories. 

<p align="center">
<img src="{{ site.baseurl }}/assets/images/blog/cuda/memory_architecture.png">
</p>

This figure help us to understand more clearly the importance of memories. Some points to highlight are first the device DRAM memory where we have the global memory but also the texture and constant memories are out of the chip. Therefore, accessing any of these data will take a non negligible amount of time. Secondly, constant cache is directly connected to device memory. So a data miss on constant cache involves loosing a lot of time. Finally the last point to highlight is that the L1 and texture cache are the same space divided logically and can be hand-tuned partially as some other cache's behaviors.  

To get deeper into memories, we will detail some aspect in a speed hierarchy approach beginning with the slowest one.

##### Global and local memory

Both those memories are handled in the off-chip DRAM. Memories inside the DRAM are persistent through kernel calls. But accessing those part take the most amount of possible time for a thread. Thankfully, global and local access is hold by a 524 KB L2 cache shared by all SM. Furthermore, global memory can use 24 KB L1 cache of each SM to gain even more efficiancy. Moreover, data being read-only for the entire kernel execution time can be detected by the compiler and therefore placed in the L1/texture cache. This placement is done thanks to the __lgd() function call used when the compiler detected the read-only property. To help the compiler, we can place some marking pointers as *const* or *\_\_restrict\_\_*.   

Global memory is a read and write 8 GB (on our card) acces memory for both device and host. It carries data and also the kernel code with a limit of 512 million instructions. Global memory can be accessed by any threads running on the device. On the other hand, local memory is accessible by only the corresponding thread.  

##### Texture and surface memories

Initially dedicated to graphic uses, texture and surface memories (often just called [texture memory](https://docs.nvidia.com/cuda/cuda-c-programming-guide/index.html#texture-memory "Texture memory")) are among those in the off-chip DRAM with an amount of 64 KB. Texture memory also have an around 24 KB on-chip cache which is shared with L1 cache. This shared space can be hand-tuned partially for specific purposes. This cache allows fast and efficient read-only access with an optimized 2D spatial locality. So threads of the same warps reading texture or surface adresses that are close in a 2D perspective will achieve best performace. Furthermore, texture memory can offer adressing calculation realised by dedicated units and other valuable advantages.  

Accessible as a read-only memory by all threads, it's the host job to allocate and tranfer all data needed.

##### Constant memory

Last out-device memory, its 64 KB are used to store constant data - initialized by the host - during a whole kernel execution. It can count on its 8 KB dedicated cache inside all SM. Reading from constant memory can give tremondous performance if threads within the same warp request the same or nearby adress. If not, accesses will be serialized. 

##### Shared memory

Shared memory is present in each SM and divided between resident blocks. On our Jetson TX2 we have 64 KB of shared memory which is designed to be close to each processor inside a SM. Each block can handle a maximum of 48 KB of shared memory. Therefore this memory is a precious ressource that avoid us to cross all the way down to the device memory.  

When the host declares data for the shared memory, the compiler will treat those data differently and create as many copies as resident blocks among SM. When a block is chosen to be executed, shared memory will be initialized for this block and be limited to the same block's lifetime.  

It is the only way to communicate and synchronize between all threads within the same block. This opportunity also bring race condition issues.  


##### Registers and shuffle

Registers are private on a thread level. As stated, a thread can have a maximum of 255 registers but the compiler limit it drastically to better parallelism and also keep a certain amount to prevent from spilling. When it occurs, spilling can be handled partially by L2 cache in our CC. In fact, caches behavior depends of the CC and also on the partial possible configuration offered.  

Thanks to warp's regroupment, CUDA has introduced a new warp level concept working on registers called shuffle. Shuffle (SHFL) is a set of instructions to exchange data between threads of the same warp by "reading" others registers. Shuffle can help a lot with applications that depends on available shared memory.  


##### Memory optimization  

All different caches, shared memory, registers and the shuffle set instruction are determining tools to minimize data transfer with off-chip DRAM. Exploiting them properly will lead to best possible performance. Learning them is a key part of a CUDA developper. 



---

## References

[1] Nvidia, [CUDA C++ Programming Guide v10.2.89](https://docs.nvidia.com/cuda/cuda-c-programming-guide/), Nov 2019.  

[2] Vasily Volkov, [Better Performance at Lower Occupancy](https://www.nvidia.com/content/GTC-2010/pdfs/2238_GTC2010.pdf), UC Berkely, Sept 2010.  

