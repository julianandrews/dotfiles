##
## Put me in ~/.irssi/scripts, and then execute the following in irssi:
##
##       /load perl
##       /script load notify
##
 
use strict;
use Irssi;
use vars qw($VERSION %IRSSI);
 
$VERSION = "0.01";
%IRSSI = (
    authors     => 'Luke Macken',
    contact     => 'lewk@csh.rit.edu',
    name        => 'notify.pl',
    description => 'TODO',
    license     => 'GNU General Public License',
    url         => 'http://www.csh.rit.edu/~lewk/code/irssi-notify',
);
 
sub notify {
    my ($dest, $text, $stripped) = @_;
    my $level = $dest->{level};
    return if !$dest->{server};
    return if $level & MSGLEVEL_NO_ACT;
    return if !($level & MSGLEVEL_PUBLIC | MSGLEVEL_MSGS | MSGLEVEL_HILIGHT);
 
    $stripped =~ s/[^a-zA-Z0-9 .,!?\@:\>]//g;
    my $urgency = $level & MSGLEVEL_HILIGHT ? 'critical' : 'normal';
    system("notify-send '$dest->{target}' '$stripped' -u $urgency");
}
 
Irssi::signal_add('print text', 'notify');
