#BIFS 617
#Group Project
#Justin Hughes (Unless Otherwise Noted)

#***Disclaimer 1/9/19: Due to time constraints and two other group members with minimal contribution, there are a handful of logic errors 
#on the reading frames and repetitive code in the subroutines that needs to be consolidated. A future build would pull the "split into codons"
#and parsing loops from each subroutine and create a single subroutine with that information, which would shift the start point
#based on the ORF indicated***

#GOAL: Write a Perl program called orfs to find all the open reading frames (ORFs) in the input sequence.
#INPUT:
#The program will take in as input a file, which will contain any number of DNA sequences in the FASTA format:
#- A line beginning with a ">" is the header line for the next sequence
#- All lines after the header contain sequence data.
#- There will be any number of sequences per file.
#- Sequences may be split over many lines.
#- Sequence data may be upper or lower case.
#- Sequence data may contain white space, which should be ignored.
#Ask the user for the minimum ORF to search for. The default is 50, which means your program should print out all ORFs with at least 50 bases.
#OUTPUT: 
#Print your output in FASTA format, with one header line for each ORF, followed by the DNA in the ORF. The header should be the same as the header in the input file, followed by a bar "|" followed by
#FRAME = POS =
#LEN = , where is the frame number (1-6)
#is the genomic position of the start of the ORF (left end is base 1)
#is the length of the ORF (in bases)
#If N = 4, 5 or 6, then P should be a negative number that indicates the
#position of the start of the ORF from the right end of the sequence.
#The DNA in the ORF should be printed out with a space between each codon, and no more than 15 codons per line.
#For example:
#>gi|1786181| Escherichia coli K-12 | FRAME = 1 POS = 5215 LEN = 138
#ATG ATA AAA GGA GTA ACC TGT GAA AAA GAT GCA ATC TAT CGT ACT
#CGC ACT TTC CCT GGT TCT GGT CGC TCC CAT GGC AGC ACA GGC TGC
#GGA AAT TAC GTT AGT CCC GTC AGT AAA ATT ACA GAT AGG CGA TCG
#TGA
 
#Worked Example:
#Example Input:
#> sequence 1ATGCTACCGTAGTGAG
#> sequence 2
#AATTACTAATCAGCCCATGATCATAACATAA
#CTGTGTATGTCTTAGAGGACCAAACCCCCCTCCTTCC
#Example Output (looking for ORFs of any size):
#> sequence 1 | FRAME = 1 POS = 1 LEN = 12
#ATG CTA CCG TAG 
#> sequence 2 | FRAME = 2 POS = 17 LEN = 15
#ATG ATC ATA ACA TAA 
#> sequence 2 | FRAME = 2 POS = 38 LEN = 9
#ATG TCT TAG 
#> sequence 2 | FRAME = 4 POS = -40 LEN = 9
#ATG TTA TGA 
#> sequence 2 | FRAME = 6 POS = -45 LEN = 15
#ATG ATC ATG GGC TGA



use strict;

#Initialize Variables
my @FASTAFile = ();
my @ORF1 = ();
my @ORF2 = ();
my @ORF3 = ();
my @ORF4 = ();
my @ORF5 = ();
my @ORF6 = ();
my $sequence ='';
my $framelength = '';
my $framenum = '';



#Pass Array, Sequence, and Filename Variables to Parsing Subroutine
FASTA_PARSE(\@FASTAFile,$sequence);

#Getting the 
print "Please type in the minimum ORF length to search for:\n";
chomp ($framelength = <STDIN>);



#For loop to pass all 6 frames to the subroutine and print
@ORF1 = ORF_1(\@FASTAFile,$framelength);
@ORF2 = ORF_2(\@FASTAFile,$framelength);
@ORF3 = ORF_3(\@FASTAFile,$framelength);
@ORF4 = ORF_4(\@FASTAFile,$framelength);
@ORF5 = ORF_5(\@FASTAFile,$framelength);
@ORF6 = ORF_6(\@FASTAFile,$framelength);


#Due to sheer size, I have only printed the first output from each ORF entry
print "\nORF 1: @ORF1[0] @ORF1[1]\n";
print "\nORF 2: @ORF2[0] @ORF2[1]\n";
print "\nORF 3: @ORF3[0] @ORF3[1]\n";
print "\nORF 4: @ORF4[0] @ORF4[1]\n";
print "\nORF 5: @ORF5[0] @ORF5[1]\n";
print "\nORF 6: @ORF6[0] @ORF6[1]\n";

exit;

#Forward 3: Written by Craig Mayer
local $_ = my $input ;
my $gene = '';
while ( / ATG /g ) {
    my $start = pos () - 3 ;
    if ( / TGA|TAA|TAG /g ) {
        my $stop = pos ;
        $gene = substr ( $_ , $start - 2 , $stop - $start + 2 ), $/ ;
        print "$gene" ;
    }
}
#backward3: Written by Craig Mayer
local $_ = my $input ;
my $gene = '';
while ( / ATG /g ) {
    my $start = pos () ;
    if ( / TGA|TAA|TAG /g ) {
        my $stop = pos ;
        $gene = substr ( $_ , $start - 3 , $stop - $start  ), $/ ;
        print "$gene" ;
    }
}

#Subroutine submitted by Yawo Akrodou
# Search for the longest open reading frame for this DNA.
print "\nHere is the largest ORF, from 5' to 3':\n" ;
local $_ = my $RNA_seq ;
my $gene = '';
while ( / AUG /g ) {
    my $start = pos () - 2 ;
    if ( / UGA|UAA|UAG /g ) {
        my $stop = pos ;
        $gene = substr ( $_ , $start - 1 , $stop - $start + 1 ), $/ ;
        print "$gene" ;
    }
}
 
#Translate subroutine: Submitted by Yawo Akrodou
# The next set of commands translates the ORF found above for an amino acid seq.
#print "\nThe largest reading Frame is:\t\t\t" . $protein { "gene" } . "\n" ;
#sub translate {
    #my ( $gene , $reading_frame ) = @_ ;
    #my %protein = ();
    #my $protein = '';
    #my $codon = '';
    #my $amino_acid = '';
    #for ( $i = $reading_frame ; $i < length ( $gene ); $i += 3 ) {
        #$codon = substr ( $gene , $i , 3 );
        #$amino_acid = translate_codon( $codon );
        #$protein { $amino_acid }++;
        #$protein { "gene" } .= $amino_acid ;
    #}
    #return %protein ;
#}

#ORF 1 Subroutine
sub ORF_1{
    my ($FASTA,$framelength) = @_;
    my $header1 = '';
    my $seq = '';
    my $rev = '';
    my @ORF1 = ();
    my $header2 = '';
    my $codon = '';
    my $tempcodon = '';
    my $offset = 0;
    my $in_frame = 0;
    my $frame = '';
    my $littleframe = '';
    my $tempframe = '';
    my $length = '';
    my $position = '';
    my $codoncount = '';

#For loop to process header and ORF information from FASTA array
for (my $n = 0;$n < @$FASTA; $n++)
{
    if (($n%2) == 0)
    {
        $header1 = @$FASTA[$n];
    #Else Loop to Process the Sequence
    }else
    {
       $seq = @$FASTA[$n];
       
       #Making Sequence All Uppercase
       $seq = uc $seq;
       
       #If commented out, not relevant to this ORF
        #$rev = reverse $seq;
        #Replace All Bases in Sequence with their compliments (reverse reading frame)
        #$rev =~ tr/ATGC/TACG/;
        #Due to reading frame 6, remove first two characters (set in offset)
        #$seq = substr ($rev,$offset);     
       
       
        #Splitting the sequence into codons
        while ($seq =~ /[AGCT]{3}/g)
        {
            #Pulling the position of the current Codon
            $position = pos($seq)-1;          
            
            #Setting the Codon Variable
            $codon = $&;
 
            #If loop for parsing
            if($codon eq "TAG"||$codon eq "TAA"|$codon eq "TGA")
            {
                #If in_frame prevents a stray stop codon from getting pushed to the array
                if ($in_frame)
                {
                    $frame .= "$codon \n";
                    $tempframe = $frame;
                 
                    
                    $tempframe =~ s/[\s0-9]//g;
                    $length = length($tempframe);
                 
                    if (length($tempframe) >= $framelength){
                        $header2 = "$header2 LEN: $length\n";
                        push (@ORF1,$header2);
                        
                        #While loop to push 15 codons at a time to the array
                        while ($tempframe =~ /[AGCT]{3}/g)
                        {
                          $tempcodon = $&;  
                          $littleframe .= "$tempcodon ";
                          $codoncount++;
                          
                          
                          #Pushes segment to array if it hits 15 codons and resets both variables
                          if ($codoncount == 15)
                          {
                            push (@ORF1,$littleframe);
                            $codoncount = 0;
                            $littleframe = '';
                            
                            #Pushes segment to array once it hits the stop codon
                            #Pushes the last remaining bit of sequence less than 15 codons to array
                          } elsif ($tempcodon eq "TAG"||$tempcodon eq "TAA"|$tempcodon eq "TGA")
                          {
                            $littleframe .= "\n";
                            push (@ORF1,$littleframe);
                            $codoncount = 0;
                            $littleframe = '';
                          }
                          
                          
                        }
                        
                    }
#Resetting Frame Variables
                    $in_frame = 0;
                    $frame = '';
                }
             
            } elsif ($codon eq "ATG")
            {
             $in_frame = 1;
             $frame .= "$codon ";
             $header2 = "\n$header1 | FRAME = 1 POS = $position";
            }
            elsif ($in_frame)
            {
             $frame .= "$codon ";  
            }
             
            }
     
    }
  
    }
return @ORF1;
}


#ORF2 Subroutine
sub ORF_2{
    my ($FASTA,$framelength) = @_;
    my $header1 = '';
    my $seq = '';
    my @ORF2 = ();
    my $header2 = '';
    my $codon = '';
    my $tempcodon = '';
    my $offset = 0;
    my $in_frame = 0;
    my $frame = '';
    my $littleframe = '';
    my $tempframe = '';
    my $length = '';
    my $position = '';
    my $codoncount = '';

#For loop to process header and ORF information from FASTA array
for (my $n = 0;$n < @$FASTA; $n++)
{
    if (($n%2) == 0)
    {
        $header1 = @$FASTA[$n];
    #Else Loop to Process the Sequence
    }else
    {
       $seq = @$FASTA[$n];
       
       #Making Sequence All Uppercase
       $seq = uc $seq;
       
       #If commented out, not relevant to this ORF
       
        #$rev = reverse $seq;
        #Replace All Bases in Sequence with their compliments (reverse reading frame)
        #$rev =~ tr/ATGC/TACG/;
        #Due to reading frame 6, remove first two characters (set in offset)
        $seq =~ s/^.//s;     
       
       
        #Splitting the sequence into codons
        while ($seq =~ /[AGCT]{3}/g)
        {
            #Pulling the position of the current Codon
            $position = pos($seq)-1;          
            
            #Setting the Codon Variable
            $codon = $&;
 
            #If loop for parsing
            if($codon eq "TAG"||$codon eq "TAA"|$codon eq "TGA")
            {
                #If in_frame prevents a stray stop codon from getting pushed to the array
                if ($in_frame)
                {
                    $frame .= "$codon \n";
                    $tempframe = $frame;
                 
                    
                    $tempframe =~ s/[\s0-9]//g;
                    $length = length($tempframe);
                 
                    if (length($tempframe) >= $framelength){
                        $header2 = "$header2 LEN: $length\n";
                        push (@ORF2,$header2);
                        
                        #While loop to push 15 codons at a time to the array
                        while ($tempframe =~ /[AGCT]{3}/g)
                        {
                          $tempcodon = $&;  
                          $littleframe .= "$tempcodon ";
                          $codoncount++;
                          
                          
                          #Pushes segment to array if it hits 15 codons and resets both variables
                          if ($codoncount == 15)
                          {
                            push (@ORF2,$littleframe);
                            $codoncount = 0;
                            $littleframe = '';
                            
                            #Pushes segment to array once it hits the stop codon
                            #Pushes the last remaining bit of sequence less than 15 codons to array
                          } elsif ($tempcodon eq "TAG"||$tempcodon eq "TAA"|$tempcodon eq "TGA")
                          {
                            $littleframe .= "\n";
                            push (@ORF2,$littleframe);
                            $codoncount = 0;
                            $littleframe = '';
                          }
                          
                          
                        }
                        
                    }
#Resetting Frame Variables
                    $in_frame = 0;
                    $frame = '';
                }
             
            } elsif ($codon eq "ATG")
            {
             $in_frame = 1;
             $frame .= "$codon ";
             $header2 = "\n$header1 | FRAME = 2 POS = $position";
            }
            elsif ($in_frame)
            {
             $frame .= "$codon ";  
            }
             
            }
     
    }
  
    }
return @ORF2;
}   

#ORF3 Subroutine
sub ORF_3{
    my ($FASTA,$framelength) = @_;
    my $header1 = '';
    my $seq = '';
    my @ORF3 = ();
    my $header2 = '';
    my $codon = '';
    my $tempcodon = '';
    my $offset = 0;
    my $in_frame = 0;
    my $frame = '';
    my $littleframe = '';
    my $tempframe = '';
    my $length = '';
    my $position = '';
    my $codoncount = '';

#For loop to process header and ORF information from FASTA array
for (my $n = 0;$n < @$FASTA; $n++)
{
    if (($n%2) == 0)
    {
        $header1 = @$FASTA[$n];
    #Else Loop to Process the Sequence
    }else
    {
       $seq = @$FASTA[$n];
       
       #Making Sequence All Uppercase
       $seq = uc $seq;
       
       #If commented out, not relevant to this ORF
       
        #$rev = reverse $seq;
        #Replace All Bases in Sequence with their compliments (reverse reading frame)
        #$rev =~ tr/ATGC/TACG/;
        #Due to reading frame 6, remove first two characters (set in offset)
        $seq =~ s/^.//s;
        $seq =~ s/^.//s;
       
       
        #Splitting the sequence into codons
        while ($seq =~ /[AGCT]{3}/g)
        {
            #Pulling the position of the current Codon
            $position = pos($seq)-1;          
            
            #Setting the Codon Variable
            $codon = $&;
 
            #If loop for parsing
            if($codon eq "TAG"||$codon eq "TAA"|$codon eq "TGA")
            {
                #If in_frame prevents a stray stop codon from getting pushed to the array
                if ($in_frame)
                {
                    $frame .= "$codon \n";
                    $tempframe = $frame;
                 
                    
                    $tempframe =~ s/[\s0-9]//g;
                    $length = length($tempframe);
                 
                    if (length($tempframe) >= $framelength){
                        $header2 = "$header2 LEN: $length\n";
                        push (@ORF3,$header2);
                        
                        #While loop to push 15 codons at a time to the array
                        while ($tempframe =~ /[AGCT]{3}/g)
                        {
                          $tempcodon = $&;  
                          $littleframe .= "$tempcodon ";
                          $codoncount++;
                          
                          
                          #Pushes segment to array if it hits 15 codons and resets both variables
                          if ($codoncount == 15)
                          {
                            push (@ORF3,$littleframe);
                            $codoncount = 0;
                            $littleframe = '';
                            
                            #Pushes segment to array once it hits the stop codon
                            #Pushes the last remaining bit of sequence less than 15 codons to array
                          } elsif ($tempcodon eq "TAG"||$tempcodon eq "TAA"|$tempcodon eq "TGA")
                          {
                            $littleframe .= "\n";
                            push (@ORF3,$littleframe);
                            $codoncount = 0;
                            $littleframe = '';
                          }
                          
                          
                        }
                        
                    }
#Resetting Frame Variables
                    $in_frame = 0;
                    $frame = '';
                }
             
            } elsif ($codon eq "ATG")
            {
             $in_frame = 1;
             $frame .= "$codon ";
             $header2 = "\n$header1 | FRAME = 3 POS = $position";
            }
            elsif ($in_frame)
            {
             $frame .= "$codon ";  
            }
             
            }
     
    }
  
    }
return @ORF3;
}   

#ORF4 Subroutine
sub ORF_4{
    my ($FASTA,$framelength) = @_;
    my $header1 = '';
    my $seq = '';
    my $rev = '';
    my @ORF4 = ();
    my $header2 = '';
    my $codon = '';
    my $tempcodon = '';
    my $offset = 0;
    my $in_frame = 0;
    my $frame = '';
    my $littleframe = '';
    my $tempframe = '';
    my $length = '';
    my $position = '';
    my $codoncount = '';

#For loop to process header and ORF information from FASTA array
for (my $n = 0;$n < @$FASTA; $n++)
{
    if (($n%2) == 0)
    {
        $header1 = @$FASTA[$n];
    #Else Loop to Process the Sequence
    }else
    {
       $seq = @$FASTA[$n];
       
       #Making Sequence All Uppercase
       $seq = uc $seq;
       
       #If commented out, not relevant to this ORF
       
        $rev = reverse $seq;
        #Replace All Bases in Sequence with their compliments (reverse reading frame)
        $rev =~ tr/ATGC/TACG/;
        #Due to reading frame 6, remove first two characters (set in offset)
        $seq = $rev;      
        
       
       
        #Splitting the sequence into codons
        while ($seq =~ /[AGCT]{3}/g)
        {
            #Pulling the position of the current Codon
            $position = pos($seq)-1;
            
            $position = "-$position";
            
            #Setting the Codon Variable
            $codon = $&;
 
            #If loop for parsing
            if($codon eq "TAG"||$codon eq "TAA"|$codon eq "TGA")
            {
                #If in_frame prevents a stray stop codon from getting pushed to the array
                if ($in_frame)
                {
                    $frame .= "$codon \n";
                    $tempframe = $frame;
                 
                    
                    $tempframe =~ s/[\s0-9]//g;
                    $length = length($tempframe);
                 
                    if (length($tempframe) >= $framelength){
                        $header2 = "$header2 LEN: $length\n";
                        push (@ORF4,$header2);
                        
                        #While loop to push 15 codons at a time to the array
                        while ($tempframe =~ /[AGCT]{3}/g)
                        {
                          $tempcodon = $&;  
                          $littleframe .= "$tempcodon ";
                          $codoncount++;
                          
                          
                          #Pushes segment to array if it hits 15 codons and resets both variables
                          if ($codoncount == 15)
                          {
                            push (@ORF4,$littleframe);
                            $codoncount = 0;
                            $littleframe = '';
                            
                            #Pushes segment to array once it hits the stop codon
                            #Pushes the last remaining bit of sequence less than 15 codons to array
                          } elsif ($tempcodon eq "TAG"||$tempcodon eq "TAA"|$tempcodon eq "TGA")
                          {
                            $littleframe .= "\n";
                            push (@ORF4,$littleframe);
                            $codoncount = 0;
                            $littleframe = '';
                          }
                          
                          
                        }
                        
                    }
#Resetting Frame Variables
                    $in_frame = 0;
                    $frame = '';
                }
             
            } elsif ($codon eq "ATG")
            {
             $in_frame = 1;
             $frame .= "$codon ";
             $header2 = "\n$header1 | FRAME = 4 POS = $position";
            }
            elsif ($in_frame)
            {
             $frame .= "$codon ";  
            }
             
            }
     
    }
  
    }
return @ORF4;
}

#ORF2 Subroutine
sub ORF_5{
    my ($FASTA,$framelength) = @_;
    my $header1 = '';
    my $seq = '';
    my $rev = '';
    my @ORF5 = ();
    my $header2 = '';
    my $codon = '';
    my $tempcodon = '';
    my $offset = 0;
    my $in_frame = 0;
    my $frame = '';
    my $littleframe = '';
    my $tempframe = '';
    my $length = '';
    my $position = '';
    my $codoncount = '';

#For loop to process header and ORF information from FASTA array
for (my $n = 0;$n < @$FASTA; $n++)
{
    if (($n%2) == 0)
    {
        $header1 = @$FASTA[$n];
    #Else Loop to Process the Sequence
    }else
    {
       $seq = @$FASTA[$n];
       
       #Making Sequence All Uppercase
       $seq = uc $seq;
       
       #If commented out, not relevant to this ORF
       
        $rev = reverse $seq;
        #Replace All Bases in Sequence with their compliments (reverse reading frame)
        $rev =~ tr/ATGC/TACG/;
        #Due to reading frame, remove characters
        $seq = $rev;
        $seq =~ s/^.//s;
        
       
       
        #Splitting the sequence into codons
        while ($seq =~ /[AGCT]{3}/g)
        {
            #Pulling the position of the current Codon
            $position = pos($seq)-1;
            
            $position = "-$position";
            
            #Setting the Codon Variable
            $codon = $&;
 
            #If loop for parsing
            if($codon eq "TAG"||$codon eq "TAA"|$codon eq "TGA")
            {
                #If in_frame prevents a stray stop codon from getting pushed to the array
                if ($in_frame)
                {
                    $frame .= "$codon \n";
                    $tempframe = $frame;
                 
                    
                    $tempframe =~ s/[\s0-9]//g;
                    $length = length($tempframe);
                 
                    if (length($tempframe) >= $framelength){
                        $header2 = "$header2 LEN: $length\n";
                        push (@ORF5,$header2);
                        
                        #While loop to push 15 codons at a time to the array
                        while ($tempframe =~ /[AGCT]{3}/g)
                        {
                          $tempcodon = $&;  
                          $littleframe .= "$tempcodon ";
                          $codoncount++;
                          
                          
                          #Pushes segment to array if it hits 15 codons and resets both variables
                          if ($codoncount == 15)
                          {
                            push (@ORF5,$littleframe);
                            $codoncount = 0;
                            $littleframe = '';
                            
                            #Pushes segment to array once it hits the stop codon
                            #Pushes the last remaining bit of sequence less than 15 codons to array
                          } elsif ($tempcodon eq "TAG"||$tempcodon eq "TAA"|$tempcodon eq "TGA")
                          {
                            $littleframe .= "\n";
                            push (@ORF5,$littleframe);
                            $codoncount = 0;
                            $littleframe = '';
                          }
                          
                          
                        }
                        
                    }
#Resetting Frame Variables
                    $in_frame = 0;
                    $frame = '';
                }
             
            } elsif ($codon eq "ATG")
            {
             $in_frame = 1;
             $frame .= "$codon ";
             $header2 = "\n$header1 | FRAME = 5 POS = $position";
            }
            elsif ($in_frame)
            {
             $frame .= "$codon ";  
            }
             
            }
     
    }
  
    }
return @ORF5;
}


#ORF6 Subroutine
sub ORF_6{
    my ($FASTA,$framelength) = @_;
    my $header1 = '';
    my $seq = '';
    my $rev = '';
    my @ORF6 = ();
    my $header2 = '';
    my $codon = '';
    my $tempcodon = '';
    my $offset = 0;
    my $in_frame = 0;
    my $frame = '';
    my $littleframe = '';
    my $tempframe = '';
    my $length = '';
    my $position = '';
    my $codoncount = '';

#For loop to process header and ORF information from FASTA array
for (my $n = 0;$n < @$FASTA; $n++)
{
    if (($n%2) == 0)
    {
        $header1 = @$FASTA[$n];
    #Else Loop to Process the Sequence
    }else
    {
       $seq = @$FASTA[$n];
       
       #Making Sequence All Uppercase
       $seq = uc $seq;
       
       #If commented out, not relevant to this ORF
       
        $rev = reverse $seq;
        #Replace All Bases in Sequence with their compliments (reverse reading frame)
        $rev =~ tr/ATGC/TACG/;
        #Due to reading frame, remove characters
        $seq = $rev;
        $seq =~ s/^.//s;
        $seq =~ s/^.//s;
        
       
       
        #Splitting the sequence into codons
        while ($seq =~ /[AGCT]{3}/g)
        {
            #Pulling the position of the current Codon
            $position = pos($seq)-1;
            
            $position = "-$position";
            
            #Setting the Codon Variable
            $codon = $&;
 
            #If loop for parsing
            if($codon eq "TAG"||$codon eq "TAA"|$codon eq "TGA")
            {
                #If in_frame prevents a stray stop codon from getting pushed to the array
                if ($in_frame)
                {
                    $frame .= "$codon \n";
                    $tempframe = $frame;
                 
                    
                    $tempframe =~ s/[\s0-9]//g;
                    $length = length($tempframe);
                 
                    if (length($tempframe) >= $framelength){
                        $header2 = "$header2 LEN: $length\n";
                        push (@ORF6,$header2);
                        
                        #While loop to push 15 codons at a time to the array
                        while ($tempframe =~ /[AGCT]{3}/g)
                        {
                          $tempcodon = $&;  
                          $littleframe .= "$tempcodon ";
                          $codoncount++;
                          
                          
                          #Pushes segment to array if it hits 15 codons and resets both variables
                          if ($codoncount == 15)
                          {
                            push (@ORF6,$littleframe);
                            $codoncount = 0;
                            $littleframe = '';
                            
                            #Pushes segment to array once it hits the stop codon
                            #Pushes the last remaining bit of sequence less than 15 codons to array
                          } elsif ($tempcodon eq "TAG"||$tempcodon eq "TAA"|$tempcodon eq "TGA")
                          {
                            $littleframe .= "\n";
                            push (@ORF6,$littleframe);
                            $codoncount = 0;
                            $littleframe = '';
                          }
                          
                          
                        }
                        
                    }
#Resetting Frame Variables
                    $in_frame = 0;
                    $frame = '';
                }
             
            } elsif ($codon eq "ATG")
            {
             $in_frame = 1;
             $frame .= "$codon ";
             $header2 = "\n$header1 | FRAME = 6 POS = $position";
            }
            elsif ($in_frame)
            {
             $frame .= "$codon ";  
            }
             
            }
     
    }
  
    }
return @ORF6;
}


#Parsing Subroutine
sub FASTA_PARSE {
    my ($FASTA,$dna) = @_;
    my $filename = '';
    my $in_sequence = 0;
    my $header= '';
    my $orf = '';
    my @FASTAFile = ();
    
    #Passing the Filename to the Read File Subroutine
    @FASTAFile = read_file($filename);
    

    foreach my $line (@FASTAFile)
    {
        #If loop to look for end of record break and prepare for next record
        if ($line =~ /^\n/){
            #Strip the whitespace and line numbers from Sequence, whitespace from Accession Number
            $dna =~ s/[\s0-9]//g;
            
                                  
            #Pushing the current values to the array
            push (@$FASTA,$header);
            push (@$FASTA,$dna);
            
            #Resetting Accession, Sequence, and In-Sequence Flag
            $header = '';
            $dna = '';
            $in_sequence = 0;  
        } elsif ($in_sequence){
            #Adds Line to Sequence data if In-Sequence Flag is True
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
