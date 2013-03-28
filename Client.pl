#TCP client
use Socket;

my $proto = getprotobyname('tcp');


#Create an upload server
#my $upload_servaddr = sockaddr_in(INADDR_ANY);
#socket UPLOAD_SERVER, PF_INET, SOCK_STREAM, $proto or die "Unable to create socket: $!";
#bind UPLOAD_SERVER, $upload_servaddr or die "Unable to bind $!";
#listen UPLOAD_SERVER, 1;

#while(accept CONNECTION, UPLOAD_SERVER){
#	while(<CONNECTION>) {
#		print "Client says: $_\n";
#	}
#	close CONNECTION;


#Connect the CI server
my $host = shift || inet_aton('localhost');
my $port = shift || 7734;

my $servaddr = sockaddr_in($port, $host);

$serv = socket SERVER, PF_INET, SOCK_STREAM, $proto or die "Unable to create socket: $!";

connect SERVER, $servaddr or die "Unable to connect: $!";

select SERVER; $| = 1; select STDOUT;

print "Client connected.\n";

my $choice = 1;

while($choice){
	system("cls"); #clears the windows screen
	print "\n\nMENU\n";
	print "1. ADD an RFC to Server \n";
	print "2. LOOKUP for an RFC\n";
	print "3. LIST all RFC's from server \n";
	print "4. GET the RFC from server \n";
	print "Press 0 for EXIT \n";
	print "Enter a choice : ";
	chomp($choice = <STDIN>);
	print "\n";
	
	my($rfc_number,$rfc_title,$version);
	if($choice == 0){
		print "\nBye\n"
	}else {
		
		system("cls");
		print "\nEnter the RFC Number : ";
		chomp($rfc_number = <STDIN>);
		print "\nEnter the Version : ";
		chomp($version = <STDIN>);
		
		if($choice == 1 || $choice == 2){	
		print "\nEnter the RFC Title : ";
		chomp($rfc_title = <STDIN>);
		if($choice == 1){&createMessage("ADD",$rfc_number,$version,$rfc_title);}
		else{&createMessage("LOOKUP",$rfc_number,$version,$rfc_title);}
		
		}elsif($choice == 3){
		&createMessage("LIST",$rfc_number,$version);
		}elsif($choice == 4){
		print "\n Choice : $choice\n";
		}else{
		print "\nThat was a wrong choice. Please Try Again\n";
		}
	
	print SERVER $msg."\n";
	$reply = <SERVER>;	
	}
	<STDIN>;
} #End of While
close SERVER;

sub createMessage{
	$msg = "$_[0] RFC $_[1] P2P-CI/$_[2]\nHost: 127.0.0.1\nPort: 1234\n";
	if($_[3]){
		$msg .= "Title: $_[3]\n";
	}
	$msg;
}