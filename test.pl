#!/usr/bin/perl


    use File::Basename;


fileparse_set_fstype("MSWin32");

$file='C:\My Documents\mythIIdemo\thanks.htm';

#$basename=basename($file);

#warn $basename;

($basename,$path,$suffix)=fileparse($file);


warn $basename;
warn $path;
warn $suffix;



use HTTP::File;

system "mkdir /tmp/TEST";
HTTP::File::upload("uuuuuaaa", '/tmp/TEST');

