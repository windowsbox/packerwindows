# Install packages for .NET development

Invoke-WebRequest https://chocolatey.org/install.ps1 -UseBasicParsing | Invoke-Expression

choco install powershell-packagemanagement -y
choco install visualstudio2017community -y
choco install resharper -pre -y
choco install notepadplusplus.install -y
choco install googlechrome -y
choco install git.install -y
choco install beyondcompare -y
choco install fiddler4 -y
choco install sql-server-management-studio -y
choco install nodejs.install -y
choco install cloudfoundry-cli -y
choco install nuget.commandline -y
choco install soapui -y
