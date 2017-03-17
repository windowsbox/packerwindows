# Windows Packer Templates

Simple [Packer](https://packer.io) templates for creating Windows VMs that support mainstream use cases that can easily be forked and built upon. 

This project makes use of [reusable PowerShell modules](https://github.com/windowsbox/powershellmodules) which allow for others to easily create their own Packer templates without needing to fork a bunch of scripts. Packer templates tend to vary between people and companies but the scripts used by the templates don't vary as much. This is an attempt to separate out the reusable parts from the parts that don't.

## Building a Box

1. Clone this repository
2. Install [Packer](http://packer.io) 0.12.1 or newer
3. Execute Packer (see below)

The Windows10 template supports a plain vanilla Windows10 Vagrant box or a Windows10 Vagrant box with a bunch of .NET development tools.

### Windows10 Vanilla Box

The plain vanilla build creates a Windows 10 box with Windows updates and not much else.
```
$ packer build windows10/windows10.json
```

### Windows10 .NET Developer Box

The .NET developer Vagrant box includes everything the vanilla box includes plus the following tools:
- Powershell Packagemanagement
- Visual Studio 2017 Community Edition
- Resharper 2017
- Notepad++
- Google Chrome
- Git for Windows
- Beyond Compare
- Fiddler 4
- SoapUI
- Sql Server Management Studio
- Node JS
- CloudFoundry CLI
- Nuget CLI 

```
$ packer build -var devtools=true windows10/windows10.json
```

## Thanks

This project would not be possible without a lot of work from other projects like [Packer-Windows](https://github.com/joefitzgerald/packer-windows).

## Project Values

- Modern OSs and tools
- Simplicity
- Reuse
