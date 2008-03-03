use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Net::OBEX',
    license             => 'perl',
    dist_author         => 'Zoffix Znet <zoffix@cpan.org>',
    dist_version_from   => 'lib/Net/OBEX.pm',
    build_requires => {
        'Test::More' => 0,
    },
    requires => {
        'Carp'                       => 1.04,
        'Socket::Class'              => 1.13,
        'IO::Handle'                 => 1.27,
        'Net::OBEX::Packet::Request' => 0.003,
        'Net::OBEX::Response'        => 0.002,
        'Net::OBEX::Packet::Headers' => 0.002,
        'Class::Data::Accessor'      => 0.04001,
    },
    add_to_cleanup      => [ 'Net-OBEX-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
