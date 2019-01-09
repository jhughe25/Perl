#BIFS 617
#Final Exam Question 9
#Justin Hughes
use strict;

#I have not been able to get this to work. I can pull in the original sequence
#and shuffle it, but both the scoring and printing by line subroutines
#(which are commented out) keep causing the program to eat all my memory and hang. 
#Most of the logic is there, so any spare points would be greatly appreciated :)


print "Question 9: DNA Sequence File Mutation\n";

#Accepting the filename in the command line prompt
chomp (my ($filename) = @ARGV[0]);
my @file = read_file($filename);


#Pulling just the sequence via the FASTA_PARSE subroutine
my $seq = FASTA_PARSE(\@file);

#Sending the sequence to the mutation/calculation subroutine
my $shuffled = shuffle_seq($seq);

#my $score = calculate($seq,$shuffled);

#print_seq ($seq,$shuffled);

#print "Total Score: $score\n";
print "Original sequence: $seq\n\n";
print "Shuffled Sequence: $shuffled\n";

exit;

sub calculate{
    my ($seq,$shuffled) = @_;
    my $count = '';
    my $on = '';
    my $oline = '';
    my $sn = '';
    my $sline = '';
    my $score = '';
    my $totalscore = 0;
    my @original= ();
    my @shuffled = ();
    my @score = ();
    
    
    while ($seq =~ /[ATGC]/)
    {
        $on = $&;
        push (@original, $on);    
    }
    
    while ($shuffled =~ /[ATGC]/)
    {
        $sn = $&;
        push (@shuffled, $on);    
    }
    
    
    
    do{
        $oline = shift(@original);
        $sline = shift(@shuffled);
        
        #If loop for scoring
        if ($sline eq $oline)
        {
            $score = 0;
            push (@score,$score);
#Scoring for Purines            
        } elsif ($oline eq 'A' && $sline eq 'G'){
            $score = -1;
            $totalscore += $score;
            push (@score, $score);
        }elsif ($oline eq 'G' && $sline eq 'A'){
            $score = -1;
            $totalscore += $score;
            push (@score, $score);
#Scoring for Pyrimidines
        }elsif ($oline eq 'T' && $sline eq 'C'){
           $score = -1;
            $totalscore += $score;
            push (@score, $score);
        }elsif ($oline eq 'C' && $sline eq 'T'){
            $score = -1;
            $totalscore += $score;
            push (@score, $score);
#Scoring for Purines -> Pyrimidines            
        }elsif ($oline = 'A'  && ($sline eq 'T'||$sline eq 'C')){
            $score = -2;
            $totalscore += $score;
            push (@score,$score);
        } elsif ($oline = 'G'  && ($sline eq 'T'||$sline eq 'C')){
            $score = -2;
            $totalscore += $score;
            push (@score,$score);
#Scoring for Pyrimidines -> Purines
        }elsif ($oline eq 'T'&& ($sline eq 'A'||$sline eq 'G')){
            $score = -2;
            $totalscore += $score;
            push (@score,$score);
        } elsif ($oline eq 'C' && ($sline eq 'A'||$sline eq 'G')){
            $score = -2;
            $totalscore += $score;
            push (@score,$score);
        }
    
  
    } until (! @shuffled);
return $totalscore;
}

sub shuffle_seq {
    my ($input) = @_;
    my $length = length $input;
    for (my $i = 0; $i < $length;$i++)
    {
        #Creating a Difference variable for random integer range
        my $difference = ($length-1) - $i;
        #Random integer gets Minimum value $i plus random integer in the range
        my $n = ($i + int(rand($difference)));
        my $temp = substr($input,$i,1);
        substr($input,$i,1) = substr($input,$n,1);
        substr($input,$n,1) = $temp;    
    }
    $input =~ s/[\s0-9\n]//g;
    return $input;
}

sub print_seq {
    my ($seq,$shuffled) = @_;
    my $on = '';
    my $online = '';
    my $sn = '';
    my $sline = '';
    my $count = '';
    my @original = ();
    my @shuffled = ();
    my $length = '';
    
    while ($seq =~ /[ATGC]/)
    {
        $on = $&;
        $online .= $on;
        $count ++;
        
        if ($count == 40){
        push (@original, $on);
        $online = '';
        $count = '';
        }
            
    }
    
    while ($shuffled =~ /[ATGC]/)
    {
        $sn = $&;
        $sline .= $sn;
        
        if ($count == 40){
            push (@shuffled, $sn);
            $sline = '';
            $count = '';
        }   
    }
    
    for (my $i = 0; $i < $length;$i++){
        print "Original: @original[$i]\n";
        print "Shuffled: @shuffled[$i]\n";
    }
}

#FASTA PARSE Subroutine
sub FASTA_PARSE {
    my ($FASTA) = @_;
    my $in_sequence = 0;
    my $header= '';
    my $dna = '';
    my @FASTAFile = ();
  

    foreach my $line (@$FASTA)
    {       
#If loop to look for end of record break and prepare for next record
        if ($line =~ /^\n/){
            
#Strip the whitespace and line numbers from Sequence, whitespace from Accession Number
            $dna =~ s/[\s0-9\n]//g;
            
#Resetting Accession, Sequence, and In-Sequence Flag
            #$header = '';
            #$dna = '';
            $in_sequence = 0;  
        } elsif ($in_sequence){
#Adds Line to Sequence data if In-Sequence Flag is True
            $line =~ s/[\s0-9\n]//g;
            $dna .= $line;
        
#Sets "Add to Sequence" Flag
        }elsif ($line =~ /^>/)
        {
          $header = $line;
          $in_sequence = 1;
        }
    }
    
$dna = uc $dna;  
return $dna;
}

#Read File Subroutine
sub read_file{
    my ($filename) = @_;
    my @filedata;    
    
    open (SEQ,$filename);
    my @filedata = <SEQ>;
    return @filedata;    
}