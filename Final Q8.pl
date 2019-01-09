#BIFS 617
#Final Exam Question 8
#Justin Hughes
use strict;
print "Question 8: Parsing a read alignment file to count gene ID's\n";

#Creating the hash for the Gene ID's and Values
my %hash = SAM_PARSE();

print "Gene ID:                   Number of reads aligning:\n";
print "--------------------------------";

#Sending hash to the print hash Subroutine
print_hash(\%hash);

exit;

#Parsing file to pull gene ID's
sub SAM_PARSE {
    my $filename = '';
    my $geneid = '';
    my %gene = ();
    my @SAMFILE = ();
    
    #Passing the Filename to the Read File Subroutine
    @SAMFILE = read_file($filename);
    
#For Loop to go through each line
    foreach my $line (@SAMFILE)
    {
        
#If loop to ignore any lines starting with @
        if ($line =~ />\@/){
        } elsif ($line =~ /(gene)[\d]{5}/)
        {
#Matches any item that starts with gene followed by 5 digits
            $geneid = $&;
            
#If loop to increase count if it exists in the hash, or to create a new hash object if it doesn't            
            if (exists $gene{$geneid})
            {
                $gene{$geneid}++;
            } else
            {
                $gene{$geneid} = 1;
            }   
  
        }
    }
   
return %gene;
}

#Print contents of the hash
sub print_hash {
    my ($hash) = @_;
    
    #Sorting function pulled from perlmaven.com/how-to-sort-a-hash-in-perl
    foreach my $geneid (sort keys %$hash)
    {
        print "$geneid            $hash{$geneid}\n";
    }

}

#Read File Subroutine
sub read_file{
    my $filename;
    my @filedata;
    print "Please type in a file name to import:\n";
    do{
        chomp ($filename = <STDIN>);
        if (-f $filename)
        {
            print "File found and opened\n\n";
        }
        else
        {
            print "Not a valid file, please try again\n";
        }    
    } until (-f $filename);
    
    open (SEQ,$filename);
    my @filedata = <SEQ>;
    return @filedata;    
}