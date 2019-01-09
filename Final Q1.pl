#BIFS 617
#Final Exam Question 1
#Justin Hughes

# Question: Write a Perl program that given a DNA string, prints out the 20 characters upstream of the start codon ATG. That is, given:
#$dna = "CCCCATAGAGATAGAGATAGAGAACCCCGCGCGCTCGCATGGGG";
#print out:
#The 20 bases upstream of ATG are AGAGAACCCCGCGCGCTCGC


use strict;

my dna = '';

$dna = "CCCCATAGAGATAGAGATAGAGAACCCCGCGCGCTCGCATGGGG";

$dna =~ /[ATGC]{20}ATG/;

print "The first 20 letters upstream of ATG are $& \n";