#BIFS 617
#Final Exam Question 3
#Justin Hughes

#Goal:Write a program that will predict the size of a population of organisms. The program should ask for the starting number of organisms, their average daily population increase (as a percentage), and the number of days they will multiply. 
#For example, a population might begin with two organisms, have an average daily increase of 50 percent, and will be allowed to multiply for seven days. The program should use a loop to display the size of the population for each day. 
#So for the previous example, the output should look like:
#Day		Organisms
#-----------------------------
#1		2.0
#2		3.0
#3		4.5
#4		6.75
#5		10.125
#6		15.1875
#7		22.78125 


use strict;

#Variable Declaration
my $rate = '';
my $time = '';
my $orgs = '';
my $neworgs = '';

#Input for Starting Population Size
print "Q2: Population Size Predictor\n";
print "Please enter the starting number of organisms: ";
chomp ($orgs = <STDIN>);

#Input for Growth Rate
print "Please enter the average daily population increase percentage (50% = 50): ";
chomp ($rate = <STDIN>);
#Converting user input to a decimal percentage value
$rate = ($rate/100);

#Input for days they will multiply
print "Please enter the max number of days for population growth: ";
chomp ($time = <STDIN>);

#Printing top of table
print "\nDay           Organisms\n";
print "--------------------\n";

#For-loop for population growth, starting at Day 1
for (my $day = 1;$day <= $time; $day++)
{
    #Since I start at Day 1, I print the current number of organisms, then do the growth calculation
    print "$day              $orgs\n";
    
    #Growth Calculation: Number of new organisms = current organisms x growth rate
    $neworgs = ($orgs*$rate);
    #Add the number of new organisms to the current organisms and update the total for next loop
    $orgs = ($neworgs + $orgs);
}

exit;