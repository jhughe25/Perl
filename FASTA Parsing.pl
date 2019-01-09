use strict;

#Initialize Variables
my @FASTAFile = ();
my $sequence ='';
my $filename = 'test.fasta';

#Pass Array, Sequence, and Filename Variables to Parsing Subroutine
FASTA_PARSE(\@FASTAFile,\%hash,$sequence,$filename);



exit;

#Parsing Subroutine
sub FASTA_PARSE {
    my ($FASTA,$dna,$filename) = @_;
    my $in_sequence = 0;
    my $header= '';
    my $orf = '';
    my @FASTAFile = ();
    
    #Passing the Filename to the Read File Subroutine
    @FASTAFile = read_file($filename);
    

    foreach my $line (@FASTAFile)
    {
        #If loop to look for end of record break and prepare for next record
        if ($line =~ /^\n/)
        {
            #Strip the whitespace and line numbers from Sequence, whitespace from Accession Number
            $dna =~ s/[\s0-9]//g;
            
                                  
            #Pushing the current values to the array
            push (@$FASTA,$header);
            push (@$FASTA,$dna);
            
            #Resetting Accession, Sequence, and In-Sequence Flag
            $header = '';
            $dna = '';
            $in_sequence = 0;
            
        }
        #Adds Line to Sequence data if In-Sequence Flag is True
        elsif ($in_sequence){
        $dna .= $line;
        #Sets "Add to Sequence" Flag#Looks for the Accession Number, and stores everything to the right of the match in the variable
        }elsif ($line =~ /^>/)
        {
          $header = $line;
          $in_sequence = 1;
        }
    } 
}

#Read File Subroutine
sub read_file{
    #Initializing Variables
    my ($file) = @_;
    my @filedata = ();
    
    #Opening the file if valid, reading the contents into an array, and returning the array
    open FILE,$file or die $!;
    @filedata = <FILE>;
    close FILE;
    return @filedata;
}