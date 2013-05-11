use strict;
use warnings;
use Test::More;

use App::MyPasswd;

{
    my $mypasswd = App::MyPasswd->new;
    is ref($mypasswd), 'App::MyPasswd', 'new';
}

{
    my $command = 'script/mypasswd';

    if ($ENV{MYPASSWD_ALL_TEST}) {
        # version
        system(
            $^X, (map { "-I$_" } @INC),
            $command,
            '--version'
        );
        is $?, 256, '--version';
        system(
            $^X, (map { "-I$_" } @INC),
            $command,
            '-v'
        );
        is $?, 256, '-v';

        # help
        system(
            $^X, (map { "-I$_" } @INC),
            $command,
            '--help'
        );
        is $?, 256, '--help';
        system(
            $^X, (map { "-I$_" } @INC),
            $command,
            '-h'
        );
        is $?, 256, '-h';

        # invalid option
        system(
            $^X, (map { "-I$_" } @INC),
            $command,
            "--hoge"
        );
        is $?, 512, 'invalid option';
        system(
            $^X, (map { "-I$_" } @INC),
            $command,
            "-q 1"
        );
        is $?, 512, 'invalid option';
    }
}

done_testing;
