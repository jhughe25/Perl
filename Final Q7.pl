#BIFS 617
#Final Exam Question 7
#Justin Hughes
use strict;

#Getting the Hash back from parsing subroutine
my %DNASIS_HASH = DNASIS_PARSE();

foreach my $name (sort keys %DNASIS_HASH)
    {
        print "Name: $name Site:  $DNASIS_HASH{$name}\n";
    }

#Position Matching Sample Program from notes
my $dna = "ATTGATAAGTCA";
my @pos = match_positions("T[GC]A",$dna);
print "@pos\n";

exit;

#Modified Parsing Subroutine
sub DNASIS_PARSE{
    
my @file = read_file();
my @DATA = ();
my %dnasis_hash = ();
my $name = '';
my $site = '';
my $regexp = '';
my $temp = '';

#Since name and site are on two lines instead of a single, this is my modified routine
foreach my $line (@file)
{
    if ($line =~ /^\s/||$line =~ /^\n/)
    {}
    elsif($line =~ /REBASE/ || $line =~ /(Rich Roberts)/){
    }
    else
    {
       $temp = $line;
       $temp =~ s/[\s\n]//g;
       push(@DATA,$temp);
       
    }      
    
}
#Removing the first entry of 954
shift @DATA;

#Pulling each item from the data array and reformatting it
while (@DATA)
{
    #Since it goes name -> site in order, filter into arrays
    $name = shift(@DATA);
    
    $site = shift(@DATA);
    
    #Translate the recognition sites to regular expressions
    $regexp = IUB_to_regexp($site);
    
    $dnasis_hash{$name} = "$site $regexp";
}

return %dnasis_hash;
}

#IUB to RegExp Subroutine from Notes
sub IUB_to_regexp{
    my ($iub) = @_;
    my $regular_expression = '';
    my %iub2character_class = (
        A => 'A', C => 'C', G => 'G', T => 'T', R => '[GA]',Y => '[CT]',
        M => '[AC]',K => '[GT]',S => '[GC]', W => '[AT]', B => '[CGT]',
        D => '[AGT]', H => '[ACT]', V => '[ACG]', N => '[ACGT]',
    );
    
    #Remove the ^ signs
    $iub =~ s/\^//g;
    
    #Translate the iub sequence
    for (my $i= 0; $i < length($iub); $i++){
        $regular_expression .= $iub2character_class{substr($iub,$i,1)};
    }
    
    return $regular_expression;
}

#Matching Position Subroutine from notes (not sure if needed)
sub match_positions{
    my ($regexp,$sequence) = @_;
    my @positions = ();
    
    while ($sequence =~ /$regexp/ig){
        push (@positions,pos($sequence) - length($&) +1);
    }
    
    return @positions;
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