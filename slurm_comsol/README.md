# COMSOL HPC Workflow Scripts
These script are used to run COMSOL on WVU HPC system.

#Node Descriptions:

##ttmcm[100-101] - comsol_small.sbatch
Architecture:          x86_64
CPU op-mode(s):        32-bit, 64-bit
Byte Order:            Little Endian
CPU(s):                20
On-line CPU(s) list:   0-19
Thread(s) per core:    1
Core(s) per socket:    10
Socket(s):             2
NUMA node(s):          2
Vendor ID:             GenuineIntel
CPU family:            6
Model:                 85
Model name:            Intel(R) Xeon(R) Silver 4210 CPU @ 2.20GHz
Stepping:              7
CPU MHz:               1017.419
CPU max MHz:           3200.0000
CPU min MHz:           1000.0000
BogoMIPS:              4400.00
Virtualization:        VT-x
L1d cache:             32K
L1i cache:             32K
L2 cache:              1024K
L3 cache:              14080K
NUMA node0 CPU(s):     0,2,4,6,8,10,12,14,16,18
NUMA node1 CPU(s):     1,3,5,7,9,11,13,15,17,19

Memory block size:         1G
Total online memory:     191G
Total offline memory:      0B

MemTotal:       196464968 kB
MemFree:        183257824 kB
MemAvailable:   182890196 kB
Buffers:              32 kB
Cached:           237024 kB
SwapCached:       105784 kB
Active:           104848 kB
Inactive:         328096 kB
Active(anon):      30492 kB
Inactive(anon):   182892 kB
Active(file):      74356 kB
Inactive(file):   145204 kB
Unevictable:     6291456 kB
Mlocked:         6291456 kB
SwapTotal:      10485756 kB
SwapFree:        9845356 kB
Dirty:                 8 kB
Writeback:             0 kB
AnonPages:       6387096 kB
Mapped:           189696 kB
Shmem:             17496 kB
Slab:             350496 kB
SReclaimable:      96700 kB
SUnreclaim:       253796 kB
KernelStack:       17168 kB
PageTables:        22944 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:    108718240 kB
Committed_AS:    7608548 kB
VmallocTotal:   34359738367 kB
VmallocUsed:      982836 kB
VmallocChunk:   34257989344 kB
Percpu:            66560 kB
HardwareCorrupted:     0 kB
AnonHugePages:   6131712 kB
CmaTotal:              0 kB
CmaFree:               0 kB
HugePages_Total:       0
HugePages_Free:        0
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:       2048 kB
DirectMap4k:      622508 kB
DirectMap2M:     9472000 kB
DirectMap1G:    191889408 kB

##taicm[001-004] - comsol_medium.sbatch
Architecture:          x86_64
CPU op-mode(s):        32-bit, 64-bit
Byte Order:            Little Endian
CPU(s):                40
On-line CPU(s) list:   0-39
Thread(s) per core:    1
Core(s) per socket:    20
Socket(s):             2
NUMA node(s):          2
Vendor ID:             GenuineIntel
CPU family:            6
Model:                 85
Model name:            Intel(R) Xeon(R) Gold 6138 CPU @ 2.00GHz
Stepping:              4
CPU MHz:               2000.000
BogoMIPS:              4000.00
Virtualization:        VT-x
L1d cache:             32K
L1i cache:             32K
L2 cache:              1024K
L3 cache:              28160K
NUMA node0 CPU(s):     0-19
NUMA node1 CPU(s):     20-39

MemTotal:       197557540 kB
MemFree:        179024752 kB
MemAvailable:   179287040 kB
Buffers:              36 kB
Cached:          1734424 kB
SwapCached:       184404 kB
Active:          1060284 kB
Inactive:        1176124 kB
Active(anon):     546784 kB
Inactive(anon):   864884 kB
Active(file):     513500 kB
Inactive(file):   311240 kB
Unevictable:     6403348 kB
Mlocked:         6403348 kB
SwapTotal:      10485756 kB
SwapFree:       10027616 kB
Dirty:                 0 kB
Writeback:             0 kB
AnonPages:       6741960 kB
Mapped:           342708 kB
Shmem:            900704 kB
Slab:             419140 kB
SReclaimable:     151860 kB
SUnreclaim:       267280 kB
KernelStack:       23200 kB
PageTables:        26028 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:    109264524 kB
Committed_AS:    8758140 kB
VmallocTotal:   34359738367 kB
VmallocUsed:     1027860 kB
VmallocChunk:   34256290388 kB
Percpu:            13056 kB
HardwareCorrupted:     0 kB
AnonHugePages:   6240256 kB
CmaTotal:              0 kB
CmaFree:               0 kB
HugePages_Total:       0
HugePages_Free:        0
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:       2048 kB
DirectMap4k:      791628 kB
DirectMap2M:     9334784 kB
DirectMap1G:    190840832 kB

##ttmcm401 - comsol_large.sbatch
Architecture:          x86_64
CPU op-mode(s):        32-bit, 64-bit
Byte Order:            Little Endian
CPU(s):                80
On-line CPU(s) list:   0-79
Thread(s) per core:    2
Core(s) per socket:    20
Socket(s):             2
NUMA node(s):          2
Vendor ID:             GenuineIntel
CPU family:            6
Model:                 106
Model name:            Intel(R) Xeon(R) Silver 4316 CPU @ 2.30GHz
Stepping:              6
CPU MHz:               2799.896
CPU max MHz:           3400.0000
CPU min MHz:           800.0000
BogoMIPS:              4600.00
Virtualization:        VT-x
L1d cache:             48K
L1i cache:             32K
L2 cache:              1280K
L3 cache:              30720K
NUMA node0 CPU(s):     0-19,40-59
NUMA node1 CPU(s):     20-39,60-79

MemTotal:       197262284 kB
MemFree:        171983720 kB
MemAvailable:   171712008 kB
Buffers:              20 kB
Cached:           302248 kB
SwapCached:        32444 kB
Active:         11751008 kB
Inactive:         264152 kB
Active(anon):   11617476 kB
Inactive(anon):   114904 kB
Active(file):     133532 kB
Inactive(file):   149248 kB
Unevictable:     6291456 kB
Mlocked:         6291456 kB
SwapTotal:      10485756 kB
SwapFree:        9507996 kB
Dirty:                12 kB
Writeback:             0 kB
AnonPages:      17974668 kB
Mapped:           415436 kB
Shmem:             19488 kB
Slab:             529916 kB
SReclaimable:     173932 kB
SUnreclaim:       355984 kB
KernelStack:       29072 kB
PageTables:        53956 kB
NFS_Unstable:          0 kB
Bounce:                0 kB
WritebackTmp:          0 kB
CommitLimit:    109116896 kB
Committed_AS:   15935176 kB
VmallocTotal:   34359738367 kB
VmallocUsed:     1086636 kB
VmallocChunk:   34257781652 kB
Percpu:            18880 kB
HardwareCorrupted:     0 kB
AnonHugePages:  13305856 kB
CmaTotal:              0 kB
CmaFree:               0 kB
HugePages_Total:       0
HugePages_Free:        0
HugePages_Rsvd:        0
HugePages_Surp:        0
Hugepagesize:       2048 kB
DirectMap4k:      909784 kB
DirectMap2M:    19406848 kB
DirectMap1G:    180355072 kB