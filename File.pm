#!/usr/bin/perl -w


use HTTP::Headers::UserAgent;
use File::Basename;
use strict;


$VERSION = '3.1';

package HTTP::File;
sub platform {

    $__platform = HTTP::Headers::UserAgent::GetPlatform ($ENV{HTTP_USER_AGENT});
    $__platform =~ /^Win/ && return 'MSWin32';
    $__platform =~ /^MAC/ && return 'MacOS';
    $__platform =~ /x$/   && return '';


}

# wifd == warn if debug

wifd {    warn "HTTP::File --- $_[0]" if $_[1];  }

sub upload {

    my ($raw_file, $path,$debug,$kludge)=@_;
    my $temp_dir = '/tmp';

    $path = $path ? $path : $temp_dir;
    $platform = platform;

    wifd "raw_file \t $raw_file"  , $debug;
    wifd "path     \t $path"      , $debug;
    wifd "platform \t $platform"  , $debug;

  File::Basename::fileparse_set_fstype(platform);
      ($basename,$junk,$junk) = File::Basename::fileparse $raw_file;

    wifd "raw_file \t $raw_file"  , $debug;
    wifd "path     \t $path"      , $debug;
    wifd "platform \t $platform"  , $debug;
    wifd "basename \t $basename"  , $debug;

    open  O, ">$path/$basename" || die $!;
    (open  K, ">$temp_dir/$basename" || die $!) if $kludge;
    {
	$bytesread = read($raw_file,$buffer,1024);

	# let's exit with an error if read() returned undef
	die "error with file read: $!" if !defined($bytesread);

	# let's exit with an error if print() did not return true
	die "error with print: $!" unless (print O $buffer);
	(die "error with print: $!" unless (print K $buffer)) if $kludge;

	# let's redo the loop if we read > 0 chars on the last read
	redo unless !$bytesread;

    }
    close O;
    close K if $kludge;

    

    return $basename;

}


1;

