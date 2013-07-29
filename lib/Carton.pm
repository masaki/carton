package Carton;
use strict;
use 5.008_005;
use version; our $VERSION = version->declare("v0.9.68");

1;
__END__

=head1 NAME

Carton - Perl module dependency manager (aka Bundler for Perl)

=head1 SYNOPSIS

  # On your development environment
  > cat cpanfile
  requires 'Plack', 0.9980;
  requires 'Starman', 0.2000;

  > carton install
  > git add cpanfile cpanfile.snapshot
  > git commit -m "add Plack and Starman"

  # Other developer's machine, or on a deployment box
  > carton install
  > carton exec starman -p 8080 myapp.psgi

=head1 WARNING

B<This software is under heavy development and considered ALPHA
quality till its version hits v1.0.0. Things might be broken, not all
features have been implemented, and APIs are likely to change. YOU
HAVE BEEN WARNED.>

=head1 AVAILABILITY

Carton only works with perl installation with the complete set of core
modules. If you use perl installed by a vendor package with modules
stripped from core, Carton is not expected to work correctly.

Also, Carton requires you to run your command/application with
C<carton exec> command, which means it's difficult or impossible to
run in an embedded perl use case such as mod_perl.

=head1 DESCRIPTION

carton is a command line tool to track the Perl module dependencies
for your Perl application. The managed dependencies are tracked in a
I<cpanfile.snapshot> file, which is meant to be version controlled, and the
snapshot file allows other developers of your application will have the
exact same versions of the modules.

=head1 TUTORIAL

=head2 Initializing the environment

carton will use the I<.carton> directory for local configuration and
the I<local> directory to install modules into. You're recommended to
exclude these directories from the version control system.

  > echo .carton/ >> .gitignore
  > echo local/ >> .gitignore
  > git add cpanfile.snapshot
  > git commit -m "Start using carton"

=head2 Tracking the dependencies

You can manage the dependencies of your application via I<cpanfile>.

  # cpanfile
  requires 'Plack', 0.9980;
  requires 'Starman', 0.2000;

And then you can install these dependencies via:

  > carton install

The modules are installed into your I<local> directory, and the
dependencies tree and version information are analyzed and saved into
I<cpanfile.snapshot> in your directory.

Make sure you add I<cpanfile.snapshot> to your version controlled repository
and commit changes as you update dependencies. This will ensure that
other developers on your app, as well as your deployment environment,
use exactly the same versions of the modules you just installed.

  > git add cpanfile cpanfile.snapshot
  > git commit -m "Added Plack and Starman"

=head2 Deploying your application

Once you've done installing all the dependencies, you can push your
application directory to a remote machine (excluding I<local> and
I<.carton>) and run the following command:

  > carton install

This will look at the I<cpanfile.snapshot> and install the exact same
versions of the dependencies into I<local>, and now your application
is ready to run.

=head2 Bundling modules

carton can bundle all the tarballs for your dependencies into a
directory so that you can even install dependencies that are not
available on CPAN, such as internal distribution aka DarkPAN.

  > carton bundle

will bundle these tarballs into I<vendor/cache> directory, and

  > carton install --cached

will install modules using this local cache. This way you can avoid
querying for a database like CPAN Meta DB or CPAN mirrors upon
deployment time.

=head1 COMMUNITY

=over 4

=item L<https://github.com/miyagawa/carton>

Code repository, Wiki and Issue Tracker

=item L<irc://irc.perl.org/#carton>

IRC chat room

=back

=head1 AUTHOR

Tatsuhiko Miyagawa

=head1 COPYRIGHT

Tatsuhiko Miyagawa 2011-

=head1 LICENSE

This software is licensed under the same terms as Perl itself.

=head1 SEE ALSO

L<cpanm>

L<Bundler|http://gembundler.com/>

L<pip|http://pypi.python.org/pypi/pip>

L<npm|http://npmjs.org/>

L<perlrocks|https://github.com/gugod/perlrocks>

L<only>

=cut
