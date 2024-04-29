# COMSOL HPC Workflow Scripts

These scripts are used to run COMSOL on the WVU HPC system.

## Node Descriptions:

### ttmcm[100-101] - comsol_small.sbatch

- **Architecture:** x86_64
- **CPU op-mode(s):** 32-bit, 64-bit
- **Byte Order:** Little Endian
- **CPU(s):** 20
- **On-line CPU(s) list:** 0-19
- **Thread(s) per core:** 1
- **Core(s) per socket:** 10
- **Socket(s):** 2
- **NUMA node(s):** 2
- **Vendor ID:** GenuineIntel
- **CPU family:** 6
- **Model:** 85
- **Model name:** Intel(R) Xeon(R) Silver 4210 CPU @ 2.20GHz
- **Stepping:** 7
- **CPU MHz:** 1017.419
- **CPU max MHz:** 3200.0000
- **CPU min MHz:** 1000.0000
- **BogoMIPS:** 4400.00
- **Virtualization:** VT-x
- **L1d cache:** 32K
- **L1i cache:** 32K
- **L2 cache:** 1024K
- **L3 cache:** 14080K
- **NUMA node0 CPU(s):** 0,2,4,6,8,10,12,14,16,18
- **NUMA node1 CPU(s):** 1,3,5,7,9,11,13,15,17,19
- **Memory block size:** 1G
- **Total online memory:** 191G
- **Total offline memory:** 0B
- **MemTotal:** 196464968 kB
- **MemFree:** 183257824 kB
- **MemAvailable:** 182890196 kB
- **Buffers:** 32 kB
- **Cached:** 237024 kB
- **SwapCached:** 105784 kB

### taicm[001-004] - comsol_medium.sbatch

- **Architecture:** x86_64
- **CPU op-mode(s):** 32-bit, 64-bit
- **Byte Order:** Little Endian
- **CPU(s):** 40
- **On-line CPU(s) list:** 0-39
- **Thread(s) per core:** 1
- **Core(s) per socket:** 20
- **Socket(s):** 2
- **NUMA node(s):** 2
- **Vendor ID:** GenuineIntel
- **CPU family:** 6
- **Model:** 85
- **Model name:** Intel(R) Xeon(R) Gold 6138 CPU @ 2.00GHz
- **Stepping:** 4
- **CPU MHz:** 2000.000
- **BogoMIPS:** 4000.00
- **Virtualization:** VT-x
- **L1d cache:** 32K
- **L1i cache:** 32K
- **L2 cache:** 1024K
- **L3 cache:** 28160K
- **NUMA node0 CPU(s):** 0-19
- **NUMA node1 CPU(s):** 20-39
- **MemTotal:** 197557540 kB
- **MemFree:** 179024752 kB
- **MemAvailable:** 179287040 kB
- **Buffers:** 36 kB
- **Cached:** 1734424 kB
- **SwapCached:** 184404 kB

### ttmcm[400-401] - comsol_large.sbatch

- **Architecture:** x86_64
- **CPU op-mode(s):** 32-bit, 64-bit
- **Byte Order:** Little Endian
- **CPU(s):** 80
- **On-line CPU(s) list:** 0-79
- **Thread(s) per core:** 2
- **Core(s) per socket:** 20
- **Socket(s):** 2
- **NUMA node(s):** 2
- **Vendor ID:** GenuineIntel
- **CPU family:** 6
- **Model:** 106
- **Model name:** Intel(R) Xeon(R) Silver 4316 CPU @ 2.30GHz
- **Stepping:** 6
- **CPU MHz:** 2799.896
- **CPU max MHz:** 3400.0000
- **CPU min MHz:** 800.0000
- **BogoMIPS:** 4600.00
- **Virtualization:** VT-x
- **L1d cache:** 48K
- **L1i cache:** 32K
- **L2 cache:** 1280K
- **L3 cache:** 30720K
- **NUMA node0 CPU(s):** 0-19,40-59
- **NUMA node1 CPU(s):** 20-39,60-79
- **MemTotal:** 197262284 kB
- **MemFree:** 171983720 kB
- **MemAvailable:** 171712008 kB
- **Buffers:** 20 kB
- **Cached:** 302248 kB
- **SwapCached:** 32444 kB
