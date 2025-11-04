#!/usr/bin/perl -w
use strict;
use warnings;
use Getopt::Std;

my %opts;

my $opt_string = 'd:';
getopts($opt_string, \%opts) or die "Invalid options";

my $dir = $opts{'d'};
die "No directory specified.\n" unless defined $dir;

my @list=glob("$dir/SOB_v1/input_mutation_file/*txt");
`mkdir -p $dir/SOB_v1/run`;
foreach my $f(@list){
        my $sam=(split/\./,(split/\//,$f)[-1])[0];
        `mkdir -p $dir/SOB_v1/SOB_results`;

        open S,">$dir/SOB_v1/run/$sam.sh";
        print S "samtools index $dir/$sam/$sam.mt.bam\n";
        print S "perl /mnt/hdd/usr/xiefanfan/tools/mtDNA_FFPE-Filter/Cal.Mut.SOB_v2.pl $dir/$sam/$sam.mt.bam  $dir/SOB_v1/input_mutation_file/$sam.txt 20 30 $dir/SOB_v1/SOB_results/$sam.txt\n";
        print S "echo finish $sam\n";
        print S "echo Still_waters_run_deep >$dir/SOB_v1/run/$sam.sh.sign\n";
        close(S);
}
close(S);
