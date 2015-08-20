use strict;
use Irssi;
use vars qw($VERSION %IRSSI);
 
$VERSION = "1.1";
%IRSSI = (
  authors     => 'Julian Andrews',
  contact     => 'jandrews271@gmail.com',
  name        => 'notify',
  description => 'Simple `notify-send` based message notifications',
  license     => 'GNU General Public License',
);
 
sub notify {
  my ($dest, $text, $stripped) = @_;
  $stripped =~ /^\< ?([^\>]+)\> (.*)$/;

  my $summary = "$dest->{target}: $1";
  my $message = $2;
  my $urgency = 'critical';

  my $level = $dest->{level};
  if(
    ($level & MSGLEVEL_HILIGHT) || 
    ($level & MSGLEVEL_MSGS && !($level & MSGLEVEL_PUBLIC))
  ) {
    system("notify-send", $summary, $message, "-u", $urgency);
  }
}
 
Irssi::signal_add('print text', 'notify');