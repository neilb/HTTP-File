use HTTP::Headers::UserAgent;
use File::Basename;


package HTTP::File;

use strict;
use vars qw($VERSION @ISA @EXPORT @EXPORT_OK);

require Exporter;

@ISA = qw(Exporter AutoLoader);
# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.
@EXPORT = qw(
	
);
$VERSION = '2.1';


# Preloaded methods go here.

# Autoload methods go after =cut, and are processed by the autosplit program.

1;
__END__
# Below is the stub of documentation for your module. You better edit it!

=head1 NAME

HTTP::File - Routines to deal with HTML input type file.


=cut

=head1 SYNOPSIS (CGI.pm example)

C<savepage.html> looks like this:

<H1>Upload a webpage</H1>

<FORM METHOD=POST ENCTYPE="multipart/form-data" action="/cgi-bin/webplugin/savepage.cgi"> 

<INPUT TYPE=file name=FILE_UPLOAD size=35> 

<INPUT TYPE=submit NAME=Action VALUE="Upload Ahoy!">

</FORM>


C<savepage.cgi> looks like this:

#!/usr/bin/perl

use CGI;
use HTTP::File;

$cgi = new CGI;

$upload_path='/tmp';

$raw_file = $cgi->param('FILE_UPLOAD');
$basename = HTTP::File::upload($raw_file,$upload_path);


print $cgi->header;
print $cgi->start_html;

print "$basename upload successfully.<BR>Upload path: ";
print $upload_path ? $upload_path : '/tmp';

print $cgi->end_html;



=head1 DESCRIPTION

HTTP::File is a module to facilitate file uploads from HTML file input.It 
detects the basename of the raw file across MacOS, Windows, and Unix/Linux 
platforms.

=cut

=head2 sub platform

Uses a subset of the functionality of HTTP::Headers::UserAgent to determine
the type of machine that uploaded the file.



=head2 sub upload

Upload RAW_FILE to the local disk to a specified PATH, or to /tmp if PATH
is not specified.

    Returns the basename of the uploaded file;



=head1 AUTHOR

Terrence Brannon
PrincePawn@Yahoo.COM

=cut


