#!/usr/bin/perl


use HTTP::Headers::UserAgent;
use File::Basename;


$VERSION = '1.2';

package HTTP::File;

=head1 NAME

HTTP::File - Routines to deal with HTML input type file.


=cut

=head1 SYNOPSIS (HTML::Mason example)

<FORM METHOD=POST ENCTYPE="multipart/form-data" action="receive-upload.html">
<INPUT TYPE=file name=PHOTO_FILE size=35>
</FORM>

... then in receive-upload.html

<%init>
    use HTTP::File;
</%init>

<%perl>
$output_path="/var/spool";
$raw_file=$ARGS{PHOTO_FILE};
HTTP::File::upload($raw_file, $output_path);
</%perl>

=cut

=head1 DESCRIPTION

HTTP::File is a module to facilitate file uploads from HTML file input.It 
detects the basename of the raw file across MacOS, Windows, and Unix/Linux 
platforms.

=cut

=head2 sub platform

Uses a subset of the functionality of HTTP::Headers::UserAgent to determine
the type of machine that uploaded the file.

=cut

sub platform {

    $__platform = HTTP::Headers::UserAgent::GetPlatform ($ENV{HTTP_USER_AGENT});
    $__platform =~ /^Win/ && return 'MSWin32';
    $__platform =~ /^MAC/ && return 'MacOS';
    $__platform =~ /x$/   && return '';


}

=head2 sub upload

Upload RAW_FILE to the local disk to a specified PATH, or to /tmp if PATH
is not specified.

=cut

sub upload {

    ($raw_file, $path,)=@_;

    warn " ** raw_file $raw_file\n";

    $path = $path ? $path : '/tmp';

    warn " ** path $path\n";

    $platform = platform;

    warn " ** platform $platform\n";

  File::Basename::fileparse_set_fstype(platform);
      ($basename,$junk,$junk) = File::Basename::fileparse $raw_file;

    warn " ** basename $basename\n";

    open  O, ">$path/$basename" || die $!;
    while ($bytesread = read($raw_file,$buffer,1024)) {
        print O $buffer;
    }
    close O;

    return $basename;

}


1;

=head1 AUTHOR

Terrence Brannon
PrincePawn@Yahoo.COM

=cut