#BIFS 617
#Final Exam Question 4
#Justin Hughes

#Write a Perl program that adds up the numbers in a file and prints out their sum, average, max and min.  Assume that there is one number per line.  
#Print the average out showing two digits after the decimal point (Hint: look up the printf command). 

#Test your program with a file containing:
#40
#10
#2
#3
#4

#Your output should look like:
#sum = 59
#ave = 11.80
#max = 40
#min = 2

#Your code should work on any file containing different or more numbers than listed above (i.e. don’t just assume you have 5 numbers in a file).

use strict;
print "Question 4: Calculating Numbers from a file\n";

#Reading the file and initializing variables
my @file = read_file();
my @numbers = ();
my $sum = '';
my $avg = '';
my $max = '';
my $min = '';
my $count = '';
my $current = '';

foreach my $line (@file)
{
    #If loop to prevent newline characters from being added to numbers array
    if ($line =~ /^\n/)
    {}
    else
    {
        #Stripping all whitespace and pushing it to the array
        $line =~ s/[\s]//g;
        push (@numbers,$line); 
    }
     
}


for (my $num = 0;$num < @numbers; $num++)
{
    #Current is a shortcut so I don't have to type @numbers[$num] each time
    $current = @numbers[$num];
    $sum += $current;
    $count++;
    #If Loop to set first number as min and max
    if ($count == "1")
    {
        $max = $current;
        $min = $current;
    }
    #If loop to compare current number to max and update if needed
    if ($current >= $max)
    {
        $max = $current;
    }
    #If loop to compare current number to min and update if needed
    if ($current < $min)
    {
        $min = $current;
    }

}

#Average Value Calculations using the total number count from the array
$avg = ($sum/scalar(@numbers));

#Having the average print out to 2 digits after the decimal point
$avg = sprintf("%.2f",$avg);

#Print Everything
print "Sum: $sum\n";
print "Avg: $avg\n";
print "Max: $max\n";
print "Min: $min\n\n";

exit;


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

