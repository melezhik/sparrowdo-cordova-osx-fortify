# Sparrowdo::Cordova::OSx::Fortify

Sparrowdo module to run HP Fortify scan against Cordova/OSx project.

# USAGE

    $ zef install Sparrowdo::Cordova::OSx::Fortify

    $ sparrowdo --local_mode --no_sudo --cwd=/path/to/cordova/project \
    --module_run=Cordova::OSx::Fortify@project=App.xcodeproj,scan-file=out.fpr

# Parameters

## project

Name of xcode project

## scan-file

Name of generated scan file, the file will be created at the project root directory ( set by `cwd` parameter ). Default value is `out.fpr`.

## configuration

Xcode build configuration. Default value is `Debug`

# Author

Alexey Melezhik

