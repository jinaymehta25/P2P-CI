#TCP Server listening on 7734
use Socket;


my $proto = getprotobyname('tcp');
my $port = 7734;
my $servaddr = sockaddr_in($port,INADDR_ANY);
socket SERVER, PF_INET, SOCK_STREAM, $proto or die "Unable to create socket: $!";
bind SERVER, $servaddr or die "Unable to bind $!";
listen SERVER, 1;
select SERVER; $| = 1; select STDOUT;

print "Server running on port $port \n";
while(accept CONNECTION, SERVER){
	print "Client connected at ",scalar(localtime),"\n";
	$_ = <CONNECTION>;	
	if(/ADD/i){
		print "Method $_\n";
	}elsif(/LOOKUP/i){
		print "Method $_\n";
	}elsif(/LIST/i){
		print "Method $_\n";
	}
	
	print $_;
	#close CONNECTION;
	#print "\nClient disconnected\n";
}