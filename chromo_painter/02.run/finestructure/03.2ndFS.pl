my $out="$0.out";
`mkdir $out`;

my @a=(1..29);
my $indir="/ifshk5/PC_HUMAN_EU/USER/wanglizhong/project.hk/201607.chromo_painter/01.PrepareData/01.haplotype_g.v2/01.VCF2phase.pl.out";

open(O,"> $0.sh");
#open(O2,"> $0.txt");
for(my $i=0;$i<29;$i++){
    my $j=$a[$i];
    my $hap="$indir/$j.phase";
    my $rec="$indir/$j.recomrate";
    #my $poplist="pop.list.run1";
    my $ids="sample_label.ids";
    
    print O "/home/wanglizhong/bin/ChromoPainterv2 -g $hap -r $rec -t $ids -a 0 0 -o $out/$j -i 0 -n 10526.2372224419 -M 0.0205445130967962; \n";
    #my $snp=`less $rec|wc -l`;chomp $snp;$snp--;
    #print O2 "$j\t$snp\n";
    
}
close O;
#close O2;
