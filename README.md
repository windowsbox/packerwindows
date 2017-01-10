# Windows Packer Templates

Simple [Packer](https://packer.io) templates for creating Windows VMs that support mainstream use cases that can easily be forked and built upon. 

This project makes use of [reusable PowerShell modules](https://github.com/windowsbox/powershellmodules) which allow for others to easily create their own Packer templates without needing to fork a bunch of scripts. Packer templates tend to vary between people and companies but the scripts used by the templates don't vary as much. This is an attempt to separate out the reusable parts from the parts that don't.

# Thanks

This project would not be possible without a lot of work from other projects like [Packer-Windows](https://github.com/joefitzgerald/packer-windows).

# Project Values

- Modern OSs and tools
- Simplicity
- Reuse
