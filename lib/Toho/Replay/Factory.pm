package Toho::Replay::Factory;

use Mouse;
use Carp::Clan;
use Encode;
use Path::Class qw(file);
use UNIVERSAL::require;

__PACKAGE__->meta->make_immutable;

no Mouse;

sub from_file {
    my ( $self, $file ) = @_;

    croak "Can't read $file: No such file."
        unless -f $file;

    my $string;
    eval { $string = file($file)->slurp; };
    if ($@) {
        croak $@;
    }

    $self->from_string($string);
}

sub from_handle {
    my ( $self, $handle ) = @_;

    local $/;
    $self->from_string(<$handle>);
}

sub from_string {
    my ( $self, $string ) = @_;

    $string = decode( 'cp932', $string );
    if ( $string =~ m{\A T(\d+)R }xmsi ) {
        my $version = $1;
        my $package = 'Toho::Replay::TH' . $version;
        $package->require or croak "$package does not exist!";
        my $replay = $package->new( str => $string );
        return $replay;
    }
    else {
        croak 'this is not a replay file of the Toho Project!';
    }
}

1;
__END__

=encoding utf8

=head1 NAME

Toho::Replay::Role - Role for Toho::Replay.

=head1 SYNOPSIS

  use Toho::Replay::Role;

=head1 DESCRIPTION

Toho::Replay の Role です。

=head1 AUTHOR

Daisuke Komatsu E<lt>vkg.taro@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
