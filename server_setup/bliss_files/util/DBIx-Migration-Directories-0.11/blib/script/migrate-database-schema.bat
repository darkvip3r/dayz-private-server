@rem = '--*-Perl-*--
@echo off
if "%OS%" == "Windows_NT" goto WinNT
perl -x -S "%0" %1 %2 %3 %4 %5 %6 %7 %8 %9
goto endofperl
:WinNT
perl -x -S %0 %*
if NOT "%COMSPEC%" == "%SystemRoot%\system32\cmd.exe" goto endofperl
if %errorlevel% == 9009 echo You do not have Perl in your PATH.
if errorlevel 1 goto script_failed_so_exit_with_non_zero_val 2>nul
goto endofperl
@rem ';
#!C:\strawberry\perl\bin\perl.exe 
#line 15

use strict;
use warnings (FATAL => 'all');
use 5.006;

use DBIx::Migration::Directories;
use DBIx::Migration::Directories::Base;
use Getopt::Long;
use Carp;
use DBIx::Transaction;
use Pod::Usage;

our %args;
our @ARGV;

GetOptions(
    \%args,
    'dsn|d=s',
    'user|u=s',
    'pass|p=s',
    'base|b=s',
    'dir=s',
    'delete',
    'full',
    'info',
    'desired-version|t=f',
    'force-current-version=f',
    'verbose|v',
    'help|h',
);

exit pod2usage(
    -message => "See 'perldoc migrate-database-schema' for more information.",
    -exitval => 1
) if($args{help});

exit pod2usage(
    -message => "DSN not specified",
    -exitval => 2
) unless($args{dsn} || $ENV{DBI_DSN});

exit pod2usage(
    -message => "At least one schema name is required when not running in 'info' mode",
    -exitval => 2
) unless(@ARGV || $args{info});

exit pod2usage(
    -message => "'dir' can only be specified if there is only one schema",
    -exitval => 2
) if($args{dir} && (@ARGV > 1));

exit pod2usage(
    -message => "'desired-version' and 'delete' are mutually exclusive",
    -exitval => 2
) if($args{'desired-version'} && $args{'delete'});

exit pod2usage(
    -message => "'desired-version' and 'info' are mutually exclusive",
    -exitval => 2
) if($args{'desired-version'} && $args{'info'});

exit pod2usage(
    -message => "'delete' and 'info' are mutually exclusive",
    -exitval => 2
) if($args{'delete'} && $args{'info'});

exit pod2usage(
    -message => "'full' only makes sense with 'delete'",
    -exitval => 2
) if($args{'full'} && !$args{'delete'});

if($args{verbose}) {
    if($args{dsn}) {
        print qq{- Connecting to database at "$args{dsn}"\n};
    } else {
        print qq{- Connecting to database specified in the environment\n};
    }
}

my $dbh = DBIx::Transaction->connect(
    @args{'dsn','user','pass'}, 
    { RaiseError => 1, PrintError => 0, PrintWarn => 0, AutoCommit => 1 }
) or die("Couldn't connect to database: ", DBI->errstr, "\n");

print "- Opening database transaction\n" if($args{verbose});
$dbh->begin_work;

our @schemas = @ARGV;
our $migration;
our $info;
our $delete_method;

if($args{info} || !@schemas) {
    $migration = DBIx::Migration::Directories::Base->new(dbh =>  $dbh);
    $info = $migration->schemas;
}

if(!@schemas) {
    @schemas = sort keys %$info;
}

if($args{'delete'} && $args{'full'}) {
    $delete_method = 'full_delete_schema';
} elsif($args{'delete'}) {
    $delete_method = 'delete_schema';
}

eval {
    while(my $schema = shift(@schemas)) {
        my $desired;
        if($schema =~ m{::}) {
            $desired = $schema;
            $schema =~ s{::}{-}g;
        }
        
        unless($args{info}) {
            $migration = DBIx::Migration::Directories->new(
                dbh     =>  $dbh,
                ($desired ?
                    (desired_version_from => $desired) :
                    (schema => $schema)
                ),
                ($args{'dir'} ? (dir =>  $args{'dir'}) : ()),
                ($args{'base'} ? (base   =>  $args{'base'}) : ()),
                (
                    defined($args{'desired-version'}) ?
                        (desired_version =>  $args{'desired-version'})
                        : ()
                ),
                (
                    defined($args{'force-current-version'}) ?
                        (current_version => $args{'force-current-version'})
                        : ()
                )
            ) or die "Failed to get a migration handle!\n";
        }
                    
        if($args{info}) {
            print "$schema: ";
                
            if(my $sinfo = $info->{$schema}) {
                print "Version ", $sinfo->{version}, "\n";
                
                my $log = $migration->schema_version_log($schema);
                
                foreach my $item (@$log) {
                    printf(
                        "  % 20s: % 15f to % 15f\n",
                        $item->{event_time}, 
                        $item->{old_version},
                        $item->{new_version}
                    );
                }
            } else {
                print "Not installed.\n";
            }
                
        } elsif($args{'delete'}) {
            if(defined($migration->{current_version})) {
                if($args{verbose}) {
                    print qq{  - Deleting schema "$schema" (version },
                        $migration->{current_version}, qq{)\n};
                }

                if(!$migration->$delete_method) {
                    die qq{Deleting schema "$schema" failed!\n};
                }
            } elsif($args{verbose}) {
                print qq{  - Schema "$schema" not installed, not deleting\n};
            }
        } else {
            my $ver = defined($migration->{current_version}) ?
                $migration->{current_version} : 0;
                    
            if($args{verbose}) {
                if(!$ver) {
                    print qq{  - New schema "$schema", installing version },
                        $migration->{desired_version}, qq{\n};
                }
            }

            if(
                $ver &&
                (
                    $migration->version_as_number($migration->{current_version}) ==
                    $migration->version_as_number($migration->{desired_version})
                )
            ) {
                if($args{verbose}) {
                    print qq{  - Schema "$schema" already at },
                        $migration->{desired_version}, qq{.\n};
                }
            } else {
                print qq{  - Migrating schema "$schema" from version $ver},
                    qq{ to version }, $migration->{desired_version}, qq{\n}
                        if($args{verbose});
                        
                if(!$migration->full_migrate) {
                    die qq{Migrating schema "$schema" from version $ver },
                        qq{ to version }, $migration->{desired_version},
                        qq{ failed!\n};
                }
            }
        }
    }
};

$migration = undef;

if($@) {
    my $e = $@;
    $e =~ s{\n}{\n*   }gs;
    print qq{* FAILED, rolling back. Error:\n*  $e\n};
    $dbh->rollback;
    $dbh->disconnect;
    exit(1);
}

print qq{- Commiting changes to the database.\n} if($args{verbose});
$dbh->commit;
print qq{- Disconnecting from the database.\n} if($args{verbose});
$dbh->disconnect;
print qq{- Done.\n} if($args{verbose});

exit(0);

=pod

=head1 NAME

migrate-database-schema - Install, remove, upgrade, or downgrade a schema

=head1 SYNOPSIS

  migrate-database-schema
    --dsn=DBI:string [--user=username] [--pass=password]
    [--desired-version=version|--info|--delete [--full]]
    [--dir=/path/to/schema/files] [--force-current-version=version]
    schema [schema [schema ... ]]

=head1 DESCRIPTION

C<migrate-database-schema> allows you to manage database schemas that have
been installed by C<DBIx::Migration::Directories>. Using this script, you
can view information on your installed schemas, install new schemas, and
upgrade/downgrade/remove existing schemas.

=head1 OPTIONS

A list of database schema names is specified on the command line, along
with some of the following options:

=over

=item --dsn=string

DBI's Data Source Name (DSN) to use when connecting to the database.
Typical examples are 'C<DBI:mysql:database=test>' or
'C<DBI:SQLite2:/my/database/file>'.

This option is required, unless the C<DBI_DSN> environment variable
is set (See L<DBI>).

=item --user

Username to connect to the database with, if required by your database.

=item --pass

Password to connect to the database with, if required by your database.

=item --info

Display information about the schemas. If no schema names are specified
on the commandline, information about all currently installed schemas
is returned.

=item --delete

Delete the specified schemas.

=item --full

When deleting specified schemas, also delete the DBIx-Migration-Directories
schema if no other schemas are using it.

=item --desired-version=number

Instead of attempting to upgrade to the latest version, upgrade (or downgrade)
us to the specified version.

=item --force-current-version=number

Ignore what the database says, assume the current schema version is
I<number>. This is mostly useful with MySQL databases, since they are
incapable of rolling back DDL changes if a migration fails. If this happens
in MySQL and you need to "roll back", make sure you have a well-written
backwards migration (eg; "DROP TABLE IF EXISTS" instead of "DROP TABLE")
and use the arguments,
"--force-current-version=[new.version] --desired-version=[old.version]"

=item --verbose

Explain our actions as we take them.

=item --help

Display usage synopsis and exit.

=back

=head1 SEE ALSO

L<DBIx::Migration::Directories>, L<DBI>

=cut


__END__
:endofperl
