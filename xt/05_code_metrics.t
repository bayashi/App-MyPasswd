use Test::Perl::Metrics::Lite (
    -mccabe_complexity => 7,
    -loc => 100,
    -except_dir  => [
    ],
    -except_file => [
    ],
);

all_metrics_ok();