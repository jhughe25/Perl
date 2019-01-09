#BIFS 617
#Final Exam Question 6
#Justin Hughes
use strict;

FASTA_PARSE();

exit;

#I modified my FASTA Parsing script to only pull and process the header information
sub FASTA_PARSE {
    my $header= '';
    my $count = 0;
    my $split1 = '';
    my @FASTAFile = ();
    
    #Passing the Filename to the Read File Subroutine
    @FASTAFile = read_file();
    

    foreach my $line (@FASTAFile)
    {
        #If loop to look for end of record break and prepare for next record
        if ($line =~ /^\n/)
        {
            $count++;
            print "GI $count: $header\n";
            #Resetting the Header variable for the next record
            $header = '';  
        }
        
        #Looks for the header, stores it, and processes it for the GI number
         elsif ($line =~ /^>/)
        {

            #Finding the first | and cutting everything to the left
            #I used this portion of code in the GI parsing exercise from Week 10
            $line =~ /\|/;
            $split1= $';
          
    
            #Taking the new string fragment and capturing anything between the first and second |
            $split1 =~ /\|/;
            $header = $`;
          
        }
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