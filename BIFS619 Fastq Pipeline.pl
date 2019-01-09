#BIFS 619 Final Project
#Group 2
#Members: Thomas Blass, Phillip Davis, Melanie Hardy, Justin Hughes, & Upasana Pandey


#Creating a new array to store command line arguments 
my @accession;
$outDirectory = "dataOutput";

#Pushing all command line arguments to the accession number array
foreach my $input (@ARGV)
{
    push @accession, $input;
}


fastqDump (\@accession);
topHat2 (\@accession);
cuffLinks (\@accession);


#FastQ Dump Subroutine
sub fastqDump {
    my ($accessNum) = @_;
    
    print "Accession Numbers Input:\n";
    
    foreach my $access (@$accessNum)
    {
        print "Starting Fastq-Dump for Accession #: $access\n";
        system ("fastq-dump $access --split-3 --outdir $outDirectory");
        print "Fastq-Dump for $access Completed\n\n";
    }
    
    
}

sub topHat2 {
    my ($accessNum) = @_;
    my @fileList1;
    my @fileList2;
    my $counter = 0;
    
    #Adding the -1.fastq and -2.fastq for fastqdump output references
    foreach my $access (@$accessNum)
    {
        my $access1 = "$access\_1.fastq";
        my $access2 = "$access\_2.fastq";
        push @fileList1, $access1;
        push @fileList2, $access2;
    }
    
    #Change working directory to fileTestOutput
    chdir $outDirectory;
    
    for ($n = 0; $n < @fileList1; $n++)
    {
        $counter ++;
        print ("Starting TopHat2 Run: Files @fileList1[$n] & @fileList2[$n]\n");
        #System call to run TopHat2 commands.
        system ("tophat2 -p 6 -o tophat_out$counter -G /home/bifs619/Homo_sapiens/Ensembl/GRCh37/Annotation/Genes/genes.gtf /home/bifs619/Homo_sapiens/Ensembl/GRCh37/Sequence/Bowtie2Index/genome @fileList1[$n] @fileList2[$n]");
        print ("TopHat2 Run for @fileList1[$n] & @fileList2[$n] Complete\n\n");
    }  
           
}   

sub cuffLinks {
    my ($accessNum) = @_;
    my $counter = 0;
    
    chdir $outDirectory;
    
    for ($n = 0; $n < @$accessNum; $n++){
        $counter++;
        print ("Starting Cufflinks Run $counter\n");
        system("cufflinks -p 6 -o cuffOutput$counter.bam ./tophat\_out$counter/accepted\_hits.bam");
        print ("Cufflinks Run $counter complete.\n\n");
    }
    
    
}


