#!/usr/bin/perl
use warnings;
use strict;

open(FASTA, $ARGV[0]) or die $!;
my @all_fa;

while( my $fa = next_fasta_record(\*FASTA) ){

    my %fa = fasta_record2hash($fa);

    push @all_fa, \%fa;
    
    use Data::Dumper;
    print Dumper($fa, \%fa);
}

close FASTA;

print Dumper(\@all_fa);

sub next_fasta_record{
    my $fh = shift;
    local $/="\n>";
    my $fa = <$fh> or return;
    chomp($fa);
    $fa =~ s/^>//;
    return '>'.$fa;
}

sub fasta_record2hash{
    my ($head, $seq) = split("\n", $_[0], 2);
    my ($id, $desc) = split(/\s/, $head, 2);
    $seq =~ tr/\n//d;
    my %fa = (
              id => $id,
              desc => $desc,
              seq => $seq,
              );
    return %fa;
}
