#!/usr/bin/perl 

use strict;
use warnings;
use CGI qw/:standard/; 

my $q=CGI->new;
print $q->header('text/html'),
	  $q->start_html ('DK Square Grade Point'),
	  $q->end_html;

	#thead td{
	#	color: e3cdb6;
	#}


print "<h2 align=\"center\">DK Square Gradepoint</h2>";
print "<table border=\"1\" align=\"center\" bordercolor=\"f8e2ca\" bgcolor=\"664c31\">";
while(my $string=<DATA>){
	chomp($string);
	foreach(split(/\n/,$string)){
		my($required_lvl,$rank,$point,$shield,$attack,$defense,$hp)=split(/,/,$string);
		print "<tr><th>&nbsp$required_lvl&nbsp</th><th>&nbsp$rank&nbsp</th><th>&nbsp$point&nbsp</th><th>&nbsp$shield&nbsp</th><th>&nbsp$attack&nbsp</th><th>&nbsp$defense&nbsp</th><th>&nbsp$hp&nbsp</th></tr>";
	}
}
	print "</font></table>";
	print "<br>";

if(param()){
	my $rank = param('rank');
	my $user_input=param('user_input');
			
	print "Rank: $rank &nbsp &nbsp &nbsp GradePoint: $user_input\n";

}


#sub read_file{
#	open(DK_RANK,"rank.txt") or die "can't open file";
#	my @rank;
#	my %dk_rank;
#	while(defined(my $line=<DK_RANK>)){	
#		chomp($line);
#		if($line=~/Required Level,Rank,Point,Shield,Attack,Defense,HP/){
#			next;
#		}else{
#			my($required_level,$rank,$point,$shield,$attack,$defense,$hp)=split(/,/,$line);	
#			my $non_s=($point/5000);
#			my $s=($point/8000);
#			
#			if($point % 5000){
#				$non_s= 1+ int $non_s;
#				if($point % 8000){
#					$s= 1+ int $s;
#					push(@rank,"$rank");
#					$dk_rank{$rank}="$required_level,$rank,$point,$shield,$attack,$defense,$hp,$non_s,$s";
#				}
#			}
#		}
#	}
#	foreach my $order_rank(@rank){
#		print "$dk_rank{$order_rank}\n";
#	}
#}
__DATA__
Required Level,Rank,Point,Shield,Attack,Defense,HP
50,New Trainee,3998,1501,0,0,0
50,Trainee,6997,1760,0,0,0
50,Senior Trainee,8996,1961,0,0,0
50,Elite Trainee,16934,2216,0,0,0
75,New Infantry,20321,2392,0,0,0
75,Infantry,24386,2641,0,0,0
75,Senior Infantry,29263,2899,0,0,0
75,Elite Infantry,52440,3171,0,0,0
100,New Guard,62928,3395,0,0,0
100,Guard,75513,3710,0,0,0
100,Senior Guard,90616,3902,0,0,0
100,Elite Guard,295296,4236,0,0,0
131,New Esquire,354355,4344,35,20,400
131,Esquire,425226,4452,39,24,430
131,Senior Esquire,510271,4609,43,28,460
131,Elite Esquire,1025339,4742,47,32,490
131,New Knight,1230407,4819,62,47,590
131,Knight,1476488,4895,66,51,620
131,Senior Knight,1771785,4972,70,55,650
131,Elite Knight,2126143,5049,74,59,680
131,New White Knight,2551371,5125,99,74,780
131,White Knight,3061645,5202,105,80,810
131,Senior White Knight,3673974,5278,111,86,840
131,Elite White Knight,5073721,5355,117,92,870
131,New Blue Knight,6088465,5432,142,112,990
131,Blue Knight,7306158,5509,148,118,1040
131,Senior Blue Knight,8767389,5586,154,124,1090
131,Elite Blue Knight,10520867,5661,160,130,1140
