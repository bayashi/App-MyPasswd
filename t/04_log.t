use strict;
use warnings;
use Test::More;
use File::Temp qw/tempfile tempdir/;
use App::MyPasswd;

my $mypasswd = App::MyPasswd->new;

{
    open my $IN, '<', \"a\na\n";
    local *STDIN = *$IN;

    my $output = '';
    open my $OUT, '>', \$output;
    local *STDOUT = *$OUT;

    my $dir = tempdir( CLEANUP => 1 );
    my ($fh, $filename) = tempfile(DIR => $dir);

    my $password = $mypasswd->run("--log" => $filename);

    close $IN;
    close $OUT;

    is $password, 'DVLIgmxk';
    ok -e $filename;
    open my $rfh, '<', $filename;
    my $log = do { local $/; <$rfh> };
    close $rfh;
    like $log, qr/--log $filename/;
}

done_testing;
