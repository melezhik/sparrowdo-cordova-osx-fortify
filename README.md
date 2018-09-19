# Sparrowdo::Cordova::OSx::Fortify

Sparrowdo module to run HP Fortify scan against Cordova/OSx project.

# USAGE

    $ zef install Sparrowdo::Cordova::OSx::Fortify

    $ sparrowdo --local_mode --no_sudo --cwd=/path/to/cordova/project \
    --module_run=Cordova::OSx::Fortify@project=App.xcodeproj,scan-file=/path/to/scan/file.out

# Parameters

## project

Name of xcode project

## scan-file

Path to generated scan file

## configuration

Xcode build configuration. Default value is `Debug`

# Author

Alexey Melezhik

