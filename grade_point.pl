#!/usr/bin/perl 

use strict;
use warnings;
use CGI qw/:standard/; 

#/var/log/apache2/error.log
	#background-image: url(\"2.png\")\;

print "Content-type: text/html\n\n";
print "<html><head><style type=\"text/css\">
body{
	background-repeat: no-repeat\;
    color: black\;
    background-color: white\;
	font-size: 0.875em\;
}    
table th,table, table.center{
	font-size: 1em\;
	margin-left: auto\;
	margin-right: auto\;	
	background-color: 664d2f\;
	border-color: f6e1c6\;
	border-style: solid\;
	color: f6e1c6\;
}
</style></head><body>";

print "<h2 align=\"center\">DK Square Gradepoint</h2>";

print "<form method='post' action='/cgi-bin/grade_point.pl' >
<table border=\"0\">
    <tr>
        <td>
            <select name=\"rank\">
                <option value=\"selected\">Select current rank</option>
                <option value=\"New Trainee\">New Trainee</option>
                <option value=\"Trainee\">Trainee</option>
                <option value=\"Senior Trainee\">Senior Trainee</option>
                <option value=\"Elite Trainee\">Elite Trainee</option>
                <option value=\"New Infantry\">New Infantry</option>
                <option value=\"Infantry\">Infantry</option>
                <option value=\"Senior Infantry\">Senior Infantry</option>
                <option value=\"Elite Infantry\">Elite Infantry</option>
                <option value=\"New Guard\">New Guard</option>
                <option value=\"Guard\">Guard</option>
                <option value=\"Senior Guar\">Senior Guard</option>
                <option value=\"Elite Guard\">Elite Guard</option>
                <option value=\"New Esquire\">New Esquire</option>
                <option value=\"Senior Esquire\">Senior Esquire</option>
                <option value=\"Elite Esquire\">Elite Esquire</option>
                <option value=\"New Knight\">New Knight</option>
                <option value=\"Knight\">Knight</option>
                <option value=\"Senior Knight\">Senior Knight</option>
                <option value=\"Elite Knight\">Elite Knight</option>
                <option value=\"New White Knight\">New White Knight</option>
                <option value=\"White Knight\">White Knight</option>
                <option value=\"Senior White Knight\">Senior White Knight</option>
                <option value=\"Elite White Knight\">Elite White Knight</option>
                <option value=\"New Blue Knight\">New Blue Knight</option>
                <option value=\"Blue Knight\">Blue Knight</option>
                <option value=\"Senior Blue Knight\">Senior Blue Knight</option>
                <option value=\"Elite Blue Knight\">Elite Blue Knight</option>
            </select>
        </td>
        <td>
            <input type=\"text\" name=\"user_input\" size=\"9\" maxlength=\"7\">
        </td>
        <td>
            <input type=\"submit\" value=\"Calculate\">
        </td>
    </tr>
</table>
</form>";

my @jtdb;

if(param()){
	my $rank = param('rank');
	my $user_input=param('user_input');
	my($user_s,$user_non_s);
	if(($rank =~/selected/)|($user_input !~m/\d+$/)||($user_input =~/^$/)){		
		print "<center> Current Lvl & Input is invalid</center><p>\n";
	}
	else{
		while(my $string=<DATA>){
			chomp($string);
			foreach(split(/\n/,$string)){
				if($string=~/Required Level,Rank,Point,Shield,Attack,Defense,HP/){
					next;
				}else{
					my($required_lvl,$rank,$point,$shield,$attack,$defense,$hp)=split(/,/,$string);
					my $non_s=($point/5000);
					my $s=($point/8000);
					if($point % 5000){
						$non_s= 1+ int $non_s;
					}
					if($point % 8000){
						$s= 1+ int $s;
						push(@jtdb,"$required_lvl,$rank,$point,$shield,$attack,$defense,$hp,$non_s,$s");
						#print "$required_lvl,$rank,$point,$shield,$attack,$defense,$hp,$non_s,$s<br>";
					}
				}
			} 
		}
		foreach my $line(@jtdb){
			my($required_lvl,$db_rank,$point,$shield,$attack,$defense,$hp,$non_s,$s)=split(/,/,$line);
			if($rank eq "$db_rank"){
				$user_non_s=($point-$user_input);
				$user_s=($point-$user_input);
				$user_non_s=($user_non_s/5000);
				$user_s=($user_s/8000);
				if($user_non_s % 5000){
					$user_non_s=1+ int $user_non_s;
				}
				if($user_s % 8000){
					$user_s=1+ int $user_s;
				}
				print "<center> Rank: $db_rank &nbsp Input: $user_input &nbsp  Non-s: $user_non_s &nbsp  S-Run: $user_s</center><p>";
			}else{
				next;
			}
		}
	}
	print "<table border class=\"table\">";
	print "<tr><th>&nbspRequired Level &nbsp</th><th>&nbspRank</th><th>&nbspPoint&nbsp</th><th>&nbspShield&nbsp</th><th>&nbspAttack&nbsp</th><th>&nbspDefense&nbsp</th><th>&nbspHP&nbsp</th><th>&nbspnon-s&nbsp</th><th>&nbsps-run&nbsp</th></tr>";
	foreach my $line(@jtdb){
		chomp($line);
		my($required_lvl,$db_rank,$point,$shield,$attack,$defense,$hp,$non_s,$s)=split(/,/,$line);	
		if($rank eq $db_rank){
			print "<tr bgcolor='000000'><td>&nbsp$required_lvl&nbsp</td><td>&nbsp$db_rank&nbsp</td><td>&nbsp$point&nbsp</td><td>&nbsp$shield&nbsp</td><td>&nbsp$attack&nbsp</td><td>&nbsp$defense&nbsp</td><td>&nbsp$hp&nbsp</td><td>&nbsp$user_non_s&nbsp</td><td>&nbsp$user_s&nbsp</td></tr>";
		}else{
			print "<tr><td>&nbsp$required_lvl&nbsp</td><td>&nbsp$db_rank&nbsp</td><td>&nbsp$point&nbsp</td><td>&nbsp$shield&nbsp</td><td>&nbsp$attack&nbsp</td><td>&nbsp$defense&nbsp</td><td>&nbsp$hp&nbsp</td><td>&nbsp$non_s&nbsp</td><td>&nbsp$s&nbsp</td></tr>";
		}
	}	
	print "</table>";
	print "<br>";
	print "</body></html>";

}
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
