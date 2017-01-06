#!/usr/bin/perl -w
use strict;
use warnings;

my($fileIn,$mem,$proj_num)=@ARGV;
die("usage: $0 <shell_script> [mem] [project_num] \n\nProject_num: \nAEAInte(test)\nCATwiwR(cattle) \nRATxdeR(BlindMoleRat) \nSHEtbyR(sheep) \nHUMmuzR(zangyi)\n")unless($fileIn);
# MOUwueR (zwy) AEAInte(test)
$proj_num||="CATwiwR";
$mem||="0.1";
my $name="z.$fileIn.z";
my $dirout="z.$fileIn.z";
`mkdir $dirout` unless(-e $dirout);

my @cmd;
open(F,'<',$fileIn) or die("$!: $fileIn\n");
while(<F>){
    chomp;
    push(@cmd,$_);
}
close(F);

my $i=0;
foreach my $cmd(@cmd){
    $i++;
    my $fileOut="$dirout/z.$fileIn.$i.pbs";
    open(Fo,'>',$fileOut) or die("$!: $fileOut\n");
    print Fo "
#\$ -S /bin/sh
#\$ -e $dirout/z.$fileIn.$i.pbs.\$JOB_ID.e
#\$ -o $dirout/z.$fileIn.$i.pbs.\$JOB_ID.o
#\$ -l vf=${mem}G
#\$ -m n
#\$ -cwd
#\$ -P $proj_num
#\$ -q bc.q
";
    my $pwd=`pwd`;
    chomp $pwd;
    print Fo "cd $pwd\n\n";
    print Fo "date1=`date \"+%Y-%m-%d %H:%M:%S\"`; date1_sys=`date -d \"\$date1\" +%s`;echo \"start running ========= at \$date1\"\n\n";
    
    print Fo "$cmd\n\n";
    
    print Fo "date2=`date \"+%Y-%m-%d %H:%M:%S\"`; date2_sys=`date -d \"\$date2\" +%s`; interval=`expr \$date2_sys - \$date1_sys`; hour=`expr \$interval / 3600`;left_second=`expr \$interval % 3600`; min=`expr \$left_second / 60`; second=`expr \$interval % 60`; echo \"done  running ========= at \$date2 in \$hour hour \$min min \$second s\"\n";
    close(Fo);
}
