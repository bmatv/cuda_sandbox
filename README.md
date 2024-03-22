# cuda_sandbox
CUDA testing and installation manuals

## How to install CUDA for Nvidia Kepler on Ubuntu 22.04 
The GeForce GTX TITAN Black "Compute Capability" 3.5 which makes it compatible with CUDA up to 11.8, in theory. This, however is not true as **the latest driver as of now is 470.223.02 that limits CUDA to version 11.4!**

## Important to remove all signs of previous cuda/nvidia installations and drivers

`sudo apt purge cuda-*`

`sudo apt purge *nvidia*`

`sudo apt autoremove`

## Method 1 (CUDA 11.4 bundle)
It is possible to download a CUDA+Nvidia driver bundle for 11.4, however, the installation of the bundled 470.57.02 driver fails, either due to nouveau driver being in use or nvidia kernel module in use, depending on what driver is running the system.

`sudo apt install libnvidia-common-470 libnvidia-gl-470 nvidia-driver-470`
may require machine owner key (MOK) update due to Secure Boot, gen password, reboot and enroll MOK.

`sudo reboot now`

`nvidia-smi` should output:

 ```
 +-----------------------------------------------------------------------------+
| NVIDIA-SMI 470.239.06   Driver Version: 470.239.06   CUDA Version: 11.4     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|                               |                      |               MIG M. |
|===============================+======================+======================|
|   0  NVIDIA GeForce ...  Off  | 00000000:02:00.0  On |                  N/A |
| 27%   43C    P8    17W / 250W |    437MiB /  6074MiB |      0%      Default |
|                               |                      |                  N/A |
+-------------------------------+----------------------+----------------------+
                                                                               
+-----------------------------------------------------------------------------+
| Processes:                                                                  |
|  GPU   GI   CI        PID   Type   Process name                  GPU Memory |
|        ID   ID                                                   Usage      |
|=============================================================================|
|    0   N/A  N/A      2122      G   /usr/lib/xorg/Xorg                114MiB |
|    0   N/A  N/A      2298      G   /usr/bin/gnome-shell               87MiB |
|    0   N/A  N/A      2864      G   ...1/usr/lib/firefox/firefox      137MiB |
|    0   N/A  N/A      4774      G   ...RendererForSitePerProcess       44MiB |
|    0   N/A  N/A     63708      G   ...veSuggestionsOnlyOnDemand       47MiB |
+-----------------------------------------------------------------------------+
```
Now, it is safe to move on to CUDA installation:
```
wget https://developer.download.nvidia.com/compute/cuda/11.4.1/local_installers/cuda_11.4.1_470.57.02_linux.run
sudo sh cuda_11.4.1_470.57.02_linux.run
```

**It is very important to uncheck the installation of the 470.57.02 driver, otherwise the process will fail:**

![alt text](image-1.png)

On success you should see a Summary message with >470.x driver requirement warning:
```
===========
= Summary =
===========

Driver:   Not Selected
Toolkit:  Installed in /usr/local/cuda-11.4/
Samples:  Installed in /home/bogdan/, but missing recommended libraries

Please make sure that
 -   PATH includes /usr/local/cuda-11.4/bin
 -   LD_LIBRARY_PATH includes /usr/local/cuda-11.4/lib64, or, add /usr/local/cuda-11.4/lib64 to /etc/ld.so.conf and run ldconfig as root

To uninstall the CUDA Toolkit, run cuda-uninstaller in /usr/local/cuda-11.4/bin
***WARNING: Incomplete installation! This installation did not install the CUDA Driver. A driver of version at least 470.00 is required for CUDA 11.4 functionality to work.
To install the driver using this installer, run the following command, replacing <CudaInstaller> with the name of this run file:
    sudo <CudaInstaller>.run --silent --driver

Logfile is /var/log/cuda-installer.log
```

## Method 2 (Network install of CUDA 11.4, to be tested)

The shall .run script may be substituted with [Nvidia's instructions](https://developer.nvidia.com/cuda-11-4-1-download-archive?target_os=Linux&target_arch=x86_64&Distribution=Ubuntu&target_version=20.04&target_type=deb_network)

```
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
sudo mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub
sudo add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /"
sudo apt-get update
sudo apt-get -y install cuda
```

Needs to be tested if there will be any issues related to 20.04 -> 22.04 Ubuntu version changes.