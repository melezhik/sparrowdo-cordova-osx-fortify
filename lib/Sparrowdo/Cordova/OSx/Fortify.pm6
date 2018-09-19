use v6;

unit module Sparrowdo::Cordova::OSx::Fortify:ver<0.0.1>;

use Sparrowdo;
use Sparrowdo::Core::DSL::File;
use Sparrowdo::Core::DSL::Directory;
use Sparrowdo::Core::DSL::Bash;

our sub tasks (%args) {

    my $build-id = %args<project> ~ ".build";

    directory "www";
    
    bash "npm install --silent";
    
    bash "npm install --silent ionic";
    
    bash "npm install --silent cordova";
    
    bash "pod setup 1>/dev/null", %(
      envvars => %(
        LANG => "en_US.UTF-8"
      )
    );
    
    bash "npm run --silent ionic -- cordova platform add ios";
    
    bash "sourceanalyzer -b $build-id -clean",%(
      description => "sourceanalyzer clean",
      debug => 1,
      cwd => "platforms/ios"
    );
    

    file "platforms/ios/excludes.txt", %( source => ( slurp %?RESOURCES<excludes.txt> ) );
  
    bash "sourceanalyzer \@excludes.txt -b $build-id xcodebuild CODE_SIGN_IDENTITY=\"\" CODE_SIGNING_REQUIRED=NO HEADER_SEARCH_PATHS=./CordovaLib/build/{%args<configuration>}-iphoneos/include  -project '{%args<project>}'  -configuration {%args<configuration>} -quiet clean" , %(
      description => "sourceanalyzer xcodebuild clean",
      debug => 1,
      cwd => "platforms/ios"
    );
    
    bash "sourceanalyzer -b $build-id xcodebuild CODE_SIGN_IDENTITY=\"\" CODE_SIGNING_REQUIRED=NO HEADER_SEARCH_PATHS=./CordovaLib/build/{%args<configuration>}-iphoneos/include  -project '{%args<project>}'  -configuration {%args<configuration>}", %(
      description => "sourceanalyzer build",
      debug => 1,
      cwd => "platforms/ios"
    );
    
    bash "sourceanalyzer -b $build-id -show-build-warnings", %(
      description => "sourceanalyzer show build warnings",
      debug => 1,
      cwd => "platforms/ios"
    );
    
    bash "sourceanalyzer -b $build-id -show-files", %(
      description => "sourceanalyzer show files",
      debug => 1,
      cwd => "platforms/ios"
    );
    
    directory-delete "platforms/ios/scan";
    
    directory "platforms/ios/scan";
    
    bash "sourceanalyzer -b $build-id -scan -f scan/out.fpr", %(
      description => "sourceanalyzer scan",
      debug => 1,
      cwd => "platforms/ios"
    );
        
}


