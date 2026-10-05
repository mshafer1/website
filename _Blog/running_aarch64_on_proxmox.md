---
layout: blog
title: Running Alpine (AARCH64) on Proxmox
summary: I want to use a VM to develop an image for a Raspberry Pi, how hard can it be?
date: 2026-10-04 20:00:00 -0500
tags: VM Proxmox Alpine
---

## Background / goal

I'm working on a project that is intended to be run on Raspberry Pis. I wanted to take a standard OS, configure it with a stack of software, and then share the image. For reproducibility, I wanted as much of the configuration as possible to be done with Ansible. This also meant I wanted the ability to quickly roll back to a clean OS. VMs seem like the ideal choice for that.

## How hard? Not simple, that's for sure.

When I tried to get Proxmox to simulate an ARM device with an SD card, I went through several iterations.

The first issue was that the Proxmox UI does not let you choose an aarch64 CPU type, even though QEMU supports it. I had to create the VM from the command line:

```
VMID=100
qm create 100 \
--name arm64-rpi-test \
--arch aarch64 \
--machine virt \
--bios ovmf \
--memory 2048 \
--cores 4 \
--net0 virtio,bridge=vmbr0
```

The display still did not work, so I used the Proxmox UI to add a serial port. That let me open the xterm.js console and watch the boot log.

## This is the configuration that eventually booted

(and listed an SD card as available)

```
# cat 144.conf
args: -device sdhci-pci -device sd-card,drive=sdcard0 -drive id=sdcard0,if=none,format=raw,file=/mnt/vms2/images/144/vm-144-disk-0.raw
arch: aarch64
bios: ovmf
boot: order=scsi1
cores: 4
machine: virt
memory: 2048
meta: creation-qemu=6.1.0,ctime=1785554340
name: arm64-rpi-test
net0: virtio=82:A5:52:80:2A:97,bridge=vmbr0
scsi1: VMs:iso/alpine-standard-3.24.1-aarch64.iso,media=cdrom,size=384142K
scsihw: virtio-scsi-pci
serial0: socket
smbios1: uuid=51163183-8d3a-4908-a3e0-e4eacc6333b0
unused0: VMs2:144/vm-144-disk-0.raw
vga: virtio
```

I was using Alpine for this project, but the underlying issue was not specific to Alpine.

Once the VM was booted into Alpine, I had a few settings to change so I could connect to it:

```bash
# discover/start networking
setup-interfaces -a
rc-service networking start

# get ssh server running
apk add openssh
rc-update add sshd
rc-service sshd start

# allow root and password auth via ssh
# this will be disabled later, but it helps to copy my key from my system
sed -E -e 's/#UseDNS no/UseDNS no/g' -e 's/^#PermitRoot.*/PermitRootLogin yes/g' -e 's/#PasswordAuth.*/PasswordAuthentication yes/g' /etc/ssh/sshd_config -i
rc-service sshd restart

# set the root password
passwd
```

## Getting it to boot from the "SD card"

This turned out to be more complicated than expected. The Proxmox BIOS did not support the workflow I wanted, so I had to find a workaround.

The solution I found online was to add an additional SCSI disk with GRUB installed on it and then configure GRUB to chainload the SD card. However, I could not get this to work.

## Pivoting

I switched to real hardware to make progress on the project. That let me validate the image-building process outside of Proxmox and confirm what was working on the operating system side.

After that, I realized I also needed to build and test a Docker image for ARM64, so I went back to the VM environment.

I tried loading the converting the Alpine installer to a disk and booting from it.

```bash
qemu-img convert -O raw alpine-standard-3.24.1-aarch64.iso alpine-disk.raw
qm importdisk 144 alpine-disk.raw local
```

Then I attached the drive as `scsi0` in the UI and resized it:

```bash
qm resize 144 scsi0 8G
```

I tried to use this as a boot disk for installation, but it mounted read-only. The next step was to shut down the VM, add another disk, and boot again.

I also tried the "virtual ISO" approach:

- booted into the ISO with an 8 GB disk present
- ran `setup-disk` to confirm the disk was visible
- ran the `headless_alpine` role
- used `setup-disk` again, selected the 8 GB disk, and set it to `sys` mode
- shut down, removed the ISO, and booted again

That still did not work.

## Trying again

I followed a different approach based on an article about running ARM64 VMs on Proxmox. This was closer to the right path, and the installer completed successfully. However, when I installed to disk as `sys`, the VM still did not boot afterward.

## Trying something weird that actually worked

I deleted all the VM drives and recreated them, then reset the architecture to x64. I booted into an x64 Ubuntu installer ISO with the Alpine ARM installer ISO and the target drive attached. I used GParted to create a GPT table and a FAT32 partition on the VM disk, then copied the Alpine installer files onto it.

After that:

- shut down the VM
- removed both ISOs
- switched the VM configuration back to aarch64
- booted the VM again

The installer booted from the VM drive attached as `scsi0`. I completed the installation, set it to store commits on `sda1`, set the hostname, committed the changes with `lbu commit -d`, and rebooted.

It worked.

## Recap: the working steps

After all that, this is the workflow that eventually produced a bootable aarch64 Alpine VM that I could use for testing.

1. Download the installer ISO

   I used the Alpine standard aarch64 installer ISO from [alpinelinux.org](https://alpinelinux.org/downloads/).

2. Create the VM

   Create a normal VM with a few cores and some RAM, and attach the VM disk as `scsi0`.

3. Attach a bootable x64 ISO

   I used Ubuntu Desktop 24.04.

4. Attach all relevant storage

   Make sure the VM disk, the bootable x64 ISO, and the Alpine installer ISO are all attached.

5. Set the VM to boot from the x64 ISO

6. Boot the VM

7. Copy the Alpine installer onto the VM disk

   Create a GPT table and a single FAT32 partition, then copy all files from the Alpine ISO to the VM disk.

8. Shut down the VM and remove both ISOs

9. Edit the VM configuration for aarch64

   Use a text editor to edit `/etc/pve/{VMID}.conf` (where `{VMID}` is the VM ID).

   Notable lines:

   ```
   arch: aarch64
   bios: ovmf
   boot: order=scsi0
   machine: virt
   serial0: socket
   ```

10. Boot the VM and watch the xterm.js console

    Since the installer files were copied to the VM disk and then booted, running `setup-alpine` and configuring the system as desired should work.

This was the path that finally worked for me.
