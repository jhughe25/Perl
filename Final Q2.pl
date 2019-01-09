#BIFS 617
#Final Exam Question 2
#Justin Hughes


#Goal: Write a Perl subroutine that reads in a file containing two strings on each line, and creates a hash with the first string as key and second string as value. 
#Test your subroutine on a file containing the following lines (copy the text and paste it in notepad, and then save it). Your code should work with any size file, not just the one given!}

#color blue
#shape round
#weight 150
#speed fast 


use strict;

print "Question 2: Fun with Hashes\n";

#Reading in the file
my @file = read_file();

#Passing the contents of the file to the parsing subroutine
my %hash = STRING_PARSE(\@file);

#Printing the contents of the hash
my @keylist = keys(%hash);
foreach my $key(@keylist)
{
    print "String 1: $key  String 2: $hash{$key}\n";
}

exit;


#Subroutine for parsing the file and putting into a hashs
sub STRING_PARSE {
my ($file) = @_;
my %hash = ();
my $str1 = '';
my $str2 = '';

foreach my $line(@file)
{
    #If loop to prevent a newline from being entered into the hash
    if ($line =~ /^\n/){
    }
    #Matching the space between the two strings
    elsif ($line =~ /\s/){
    #Matching the right side of the space and cleaning the string
    $str1 = $`;
    $str1 =~ s/[\s\n]//g;
    
    #Matching the left side of the space and cleaning the string
    $str2 = $';
    $str2 =~ s/[\s\n]//g;
    
    #Adding the key and value to the hash    
    $hash{$str1} = $str2;
    }
    
    
}
    
 return %hash;   
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