use strict;
use warnings;
use Test::More;
use App::MyPasswd;

my $mypasswd = App::MyPasswd->new;

{
    open my $IN, '<', \"curry\ncurry\n";
    local *STDIN = *$IN;

    my $output = '';
    open my $OUT, '>', \$output;
    local *STDOUT = *$OUT;

    my $password = $mypasswd->run("--show-input");

    close $IN;
    close $OUT;

    is $password, '1fhsvmbB';
    like $output, qr/curry\n.*curry\n/s;
}

done_testing;
