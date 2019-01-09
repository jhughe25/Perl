#BIFS 617
#Final Exam Question 5
#Justin Hughes
use strict;
print "Question 5: Averaging columns in a file\n";

my @file = read_file();
column_parse(\@file);

exit;



sub column_parse {
my ($file) = @_;
my $column1 = '';
my $column2 = '';
my $column3 = '';
my $avg1 = '';
my $avg2 = '';
my $avg3 = '';
my @column1 = ();
my @column2 = ();
my @column3 = ();

#For loop to go through each row and break the numbers into 3 columns
foreach my $line (@$file)
{
    #If loop to prevent newline characters from being added to numbers array
    if ($line =~ /^\n/)
    {}
    else 
    {
        #Pattern: First instance of any number of digits then a whitespace character is the 1st column
        $line =~ /[\d]{0,}\s/;
        $column1 = $&;
        #Removing the whitespace and newline characters (same for all 3 spots)
        $column1 =~ s/[\s\n]//g;
        
        #Pattern: First instance of a space followed by any number of digits is in the second column
        $line =~ /\s[\d]{0,}/;
        $column2 = $&;
        $column2 =~ s/[\s\n]//g;
        
        #Pattern: Only instance of a space, any number of digits, then a newline character is Column 3
        $line =~ /\s[\d]{0,}\n/;
        $column3 = $&;
        $column3 =~ s/[\s\n]//g;
        
                
        push(@column1,$column1);
        push(@column2,$column2);
        push(@column3,$column3);
        
    }     
}

$avg1 = average(\@column1);
$avg2 = average(\@column2);
$avg3 = average(\@column3);

print "Average for Column 1: $avg1\n";
print "Average for Column 2: $avg2\n";
print "Average for Column 3: $avg3\n";


}


sub average{
my ($numbers) = @_;
my $sum = '';
my $current = '';
my $avg = '';
for (my $num = 0;$num < @$numbers; $num++)
{
    #Current is a shortcut so I don't have to type @numbers[$num] each time
    $current = @$numbers[$num];
    $sum += $current;   

}

$avg = ($sum/scalar(@$numbers));

return $avg;
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