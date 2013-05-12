use strict;
use warnings;
use Test::More;
use App::MyPasswd;

use Pod::Usage;
{
    # mock
    no warnings 'redefine'; ## no critic
    *Pod::Usage::pod2usage = sub {
        die "called pod2usage";
    };
}

my $mypasswd = App::MyPasswd->new;

{
    open my $IN, '<', \"a\na\n";
    local *STDIN = *$IN;

    my $output = '';
    open my $OUT, '>', \$output;
    local *STDOUT = *$OUT;

    eval {
        $mypasswd->run("--help");
    };
    like $@, qr/called pod2usage/;

    close $IN;
    close $OUT;
}

done_testing;