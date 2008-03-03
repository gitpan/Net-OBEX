#!/usr/bin/env perl

use strict;
use warnings;

use lib '../lib';
use Net::OBEX;

my $obex = Net::OBEX->new;

my $response_ref = $obex->connect(
    address => '00:17:E3:37:76:BB',
    port    => 9,
    target  => 'F9EC7BC4953C11D2984E525400DC9E09', # OBEX FTP UUID
) or die "Failed to connect: " . $obex->error;

unless ( $response_ref->{info}{response_code} == 200 ) {
    die "Server no liky :( " . $response_ref->{info}{response_code_meaning};
}

$response_ref = $obex->set_path
    or die "Error: " . $obex->error;

unless ( $response_ref->{info}{response_code} == 200 ) {
    die "Server no liky :( " . $response_ref->{info}{response_code_meaning};
}

open my $fh, '>', 'TEST_FILE'
    or die "Failed to open TEST_FILE $!";

# this is an OBEX FTP example, so we'll get the folder listing now
$response_ref = $obex->get( type => 'x-obex/folder-listing')
    or die "Error: " . $obex->error;

# note: for gets, there might be multiple requests, so there is no {info}
my $code = $response_ref->{response_code};
unless ( $code == 200 or $code == 100 ) {
    die "Server no liky :( "
            . $response_ref->{response_code_meaning};
}

print "This is folder listing XML: \n$response_ref->{body}\n";

# send Disconnect packet with description header and close the socket
$obex->close('No want you no moar');
