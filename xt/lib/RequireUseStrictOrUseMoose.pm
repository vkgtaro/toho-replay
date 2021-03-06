##############################################################################
#      $URL: http://perlcritic.tigris.org/svn/perlcritic/trunk/Perl-Critic/lib/Perl/Critic/Policy/TestingAndDebugging/RequireUseStrict.pm $
#     $Date: 2007-11-11 21:48:21 -0600 (Sun, 11 Nov 2007) $
#   $Author: clonezone $
# $Revision: 2018 $
##############################################################################

package Perl::Critic::Policy::TestingAndDebugging::RequireUseStrictOrUseMoose;

use strict;
use warnings;
use Readonly;

use Perl::Critic::Utils qw{ :severities };
use base 'Perl::Critic::Policy';

our $VERSION = '1.080';

#-----------------------------------------------------------------------------

Readonly::Scalar my $DESC => q{Code before strictures are enabled};
Readonly::Scalar my $EXPL => [ 429 ];

#-----------------------------------------------------------------------------

sub supported_parameters { return ()                  }
sub default_severity     { return $SEVERITY_HIGHEST   }
sub default_themes       { return qw( mine ) }
sub applies_to           { return 'PPI::Document'     }

#-----------------------------------------------------------------------------

sub violates {
    my ( $self, undef, $doc ) = @_;

    # Find the first 'use strict' statement
    my $strict_stmnt = $doc->find_first( \&_is_use_strict );
    my $strict_line  = $strict_stmnt ? $strict_stmnt->location()->[0] : undef;

    # Find all statements that aren't 'use', 'require', or 'package'
    my $stmnts_ref = $doc->find( \&_isnt_include_or_package );
    return if !$stmnts_ref;

    # If the 'use strict' statement is not defined, or the other
    # statement appears before the 'use strict', then it violates.

    my @viols = ();
    for my $stmnt ( @{ $stmnts_ref } ) {
        last if $stmnt->isa('PPI::Statement::End');
        last if $stmnt->isa('PPI::Statement::Data');

        my $stmnt_line = $stmnt->location()->[0];
        if ( (! defined $strict_line) || ($stmnt_line < $strict_line) ) {
            push @viols, $self->violation( $DESC, $EXPL, $stmnt );
        }
    }
    return @viols;
}

sub _is_use_strict {
    my (undef, $elem) = @_;

    return 0 if !$elem->isa('PPI::Statement::Include');
    return 0 if $elem->type() ne 'use';
    return 0 if ( $elem->pragma() ne 'strict' && $elem->module() ne 'Moose');
    return 0 if ( $elem->pragma() ne 'strict' && $elem->module() ne 'Mouse');
    return 1;
}

sub _isnt_include_or_package {
    my (undef, $elem) = @_;

    return 0 if ! $elem->isa('PPI::Statement');
    return 0 if $elem->isa('PPI::Statement::Package');
    return 0 if $elem->isa('PPI::Statement::Include');
    return 1;
}

1;

__END__

#-----------------------------------------------------------------------------

=pod

=head1 NAME

Perl::Critic::Policy::TestingAndDebugging::RequireUseStrict

=head1 DESCRIPTION

Using strictures is probably the single most effective way to improve the
quality of your code.  This policy requires that the C<'use strict'> statement
must come before any other statements except C<package>, C<require>, and other
C<use> statements.  Thus, all the code in the entire package will be affected.

=head1 SEE ALSO

L<Perl::Critic::Policy::TestingAndDebugging::ProhibitNoStrict>

=head1 AUTHOR

Jeffrey Ryan Thalhammer <thaljef@cpan.org>

=head1 COPYRIGHT

Copyright (c) 2005-2007 Jeffrey Ryan Thalhammer.  All rights reserved.

This program is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.  The full text of this license can be found in
the LICENSE file included with this module

=cut

##############################################################################
# Local Variables:
#   mode: cperl
#   cperl-indent-level: 4
#   fill-column: 78
#   indent-tabs-mode: nil
#   c-indentation-style: bsd
# End:
# ex: set ts=8 sts=4 sw=4 tw=78 ft=perl expandtab :
