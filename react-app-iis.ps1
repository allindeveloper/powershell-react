Write-Host "Congratulations! Your React App Initialization is Being Automated"

Write-Host "Please Sit Back and Relax as some Dependencies are being Installed"

Write-Host "ETA : 3mins (Under Optimal Network Conditions)"

Write-Host "You will get a Confirmation as soon as the process is completed"

Write-Host "Please note that the App will automatically start on default Port 3000 when Done"

$Server = Read-Host -Prompt 'Input your project name'
$Date = Get-Date
Write-Host "You project '$Server' is been bootstrapped on '$Date'" 

New-Item -Path . -Name $Server -ItemType "directory"


Set-Location -Path $Server


New-Item -Path . -type file -name "config.json" -Value '{

}'
$newName = "src"
#New-Item -Path . -Name "testDir" -ItemType "directory"
#Designed by Uchendu Precious, Software Engineer|GSV
cmd /c "npm install -g create-react-app "
cmd /c "create-react-app testdir"
$currentLocation = Get-Location
$updateLocation = "$currentLocation\testdir"


Rename-Item -Path $updateLocation -NewName "src"

Set-Location -Path "src"

$nuSpecFile = "$Server.nuspec"

$nuSpecContent = '<?xml version="1.0"?>
<package>
  <metadata>
    <id>pipmap</id>
    <version>1.0.0</version>
    <authors>VGG</authors>
    <owners>VGG</owners>
    <description>'+$Server+' Application</description>
  </metadata>
  <files>
    <file src="*" exclude="*.nuspec"/>
	<file src="build\**" target="" />
  </files>
</package>'

New-Item -Path . -type file -name $nuSpecFile -Value $nuSpecContent

Set-Location -Path "public"

New-Item -Path . -Name "Web.config" -ItemType "file" -Value '<?xml version="1.0" encoding="UTF-8"?>
<configuration>
  <system.webServer>
<rewrite>
    <rules>
        <rule name="Main Rule" stopProcessing="true">
            <match url="^(.*)" />
            <conditions logicalGrouping="MatchAll">
                <add input="{REQUEST_FILENAME}" matchType="IsFile" negate="true" />
                <add input="{REQUEST_FILENAME}" matchType="IsDirectory" negate="true" />
            </conditions>
            <action type="Rewrite" url="index.html" />
        </rule>
    </rules>
</rewrite>
  </system.webServer>
</configuration>'

Pop-Location

Write-Host "Process Completed!"


cmd /c "npm start"

