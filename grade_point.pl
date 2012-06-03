#!/usr/bin/perl 

use strict;
use warnings;

&main;

sub main{
	my $dk_rank=&read_file;
	&user_input($dk_rank);
}

#my %dk_rank;

sub read_file{
	open(DK_RANK,"rank.txt") or die "can't open file";
	my %dk_rank;
	
	while(defined(my $line=<DK_RANK>)){	
		chomp($line);
		if($line=~/Required Level,Rank,Point,Shield,Attack,Defense,HP/){
			next;
		}else{
			my($required_level,$rank,$point,$shield,$attack,$defense,$hp)=split(/,/,$line);	
		
			my $non_s=($point/5000);
			my $s=($point/8000);
			
			if($point % 5000){
				$non_s= 1+ int $non_s;
				if($point % 8000){
					$s= 1+ int $s;
					$dk_rank{$rank}="$required_level,$point,$shield,$attack,$defense,$hp,$non_s,$s";		
					#print "$required_level|$rank|$point|$shield|$attack|$defense|$hp|$non_s_run|$s_run\n";
				}
			}
		}
	}
	return \%dk_rank;
}

sub user_input{
	my($dk_rank)=@_;
	
	foreach my $unique_rank(keys %$dk_rank){
		print "$unique_rank: $$dk_rank{$unique_rank}\n";
	}
}

__END__
	$input="";
	print "Select your current rank: \n";
	while(1){
		print "Enter your current Grade Point: \n";
		chomp($input=<STDIN>);
	}
}
