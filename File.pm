#!/usr/bin/perl


use HTTP::Headers::UserAgent;
use File::Basename;


$VERSION = '3.0';

package HTTP::File;
sub platform {

    $__platform = HTTP::Headers::UserAgent::GetPlatform ($ENV{HTTP_USER_AGENT});
    $__platform =~ /^Win/ && return 'MSWin32';
    $__platform =~ /^MAC/ && return 'MacOS';
    $__platform =~ /x$/   && return '';


}

sub upload {

    ($raw_file, $path,)=@_;

#    warn " ** raw_file $raw_file\n";

    $path = $path ? $path : '/tmp';

#    warn " ** path $path\n";

    $platform = platform;

#    warn " ** platform $platform\n";

  File::Basename::fileparse_set_fstype(platform);
      ($basename,$junk,$junk) = File::Basename::fileparse $raw_file;

#    warn " ** basename $basename\n";

    open  O, ">$path/$basename" || die $!;
    while ($bytesread = read($raw_file,$buffer,1024)) {
        print O $buffer;
    }
    close O;

    return $basename;

}


1;

