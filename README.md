### File Structure

```bash
.
├── DotNetWebApp.sln
├── src
│   └── DotNetWebApp
│       ├── DotNetWebApp.csproj
│       ├── Pages
│       │   ├── _viewImports.cshtml
│       │   └── index.cshtml
│       ├── Services
│       │   └── GreetingService.cs
│       ├── appsettings.json
│       └── program.cs
└── tests
    └── DotNetWebApp.Tests
        ├── DotNetWebApp.Tests.csproj
        └── GreetingServiceTests.cs
```


## To Run locally
----------
1. Create an ubuntu VM with in Azure with all ports open
2. Install git, dotnet

### Git Installation
```bash
sudo apt update
sudo apt install git
```

### Install Dotnet
```bash
sudo apt-get update && sudo apt-get install -y wget apt-transport-https
wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt-get install -y dotnet-sdk-8.0
dotnet --version
```
### Commands to execute
```bash
dotnet restore
dotnet build -c release
dotnet test -c release
dotnet run --project src/DotNetWebApp/DotNetWebApp.csproj --urls "http://0.0.0.0:5000"
```
