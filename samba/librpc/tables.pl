#!/usr/bin/perl -w

###################################################
# package to produce a table of all idl parsers
# Copyright tridge@samba.org 2003
# Copyright jelmer@samba.org 2005
# released under the GNU GPL

use strict;

use Getopt::Long;
use File::Basename;

my $opt_output = 'librpc/gen_ndr/tables.c';
my $opt_help  = 0;


#########################################
# display help text
sub ShowHelp()
{
    print "
           perl DCE/RPC interface table generator
           Copyright (C) tridge\@samba.org

           Usage: tables.pl [options] <idlfile>

           \n";
    exit(0);
}

# main program
GetOptions (
	    'help|h|?' => \$opt_help, 
	    'output=s' => \$opt_output,
	    );

if ($opt_help) {
    ShowHelp();
    exit(0);
}

my $init_fns = "";

###################################
# extract table entries from 1 file
sub process_file($)
{
	my $filename = shift;
	open(FILE, $filename) || die "unable to open $filename\n";
	my $found = 0;

	while (my $line = <FILE>) {
		if ($line =~ /extern const struct dcerpc_interface_table (\w+);/) {
			$found = 1;
			$init_fns.="\tstatus = librpc_register_interface(&$1);\n";
			$init_fns.="\tif (NT_STATUS_IS_ERR(status)) return status;\n\n";
		}
	}

	if ($found) {
		print "#include \"$filename\"\n";
	}

	close(FILE);
}

print <<EOF;

/* Automatically generated by tables.pl. DO NOT EDIT */

#include "includes.h"
#include "librpc/rpc/dcerpc.h"
#include "librpc/rpc/dcerpc_table.h"
EOF

process_file($_) foreach (@ARGV);

print <<EOF;

NTSTATUS dcerpc_register_builtin_interfaces(void)
{
	NTSTATUS status;

$init_fns
	
	return NT_STATUS_OK;
}
EOF