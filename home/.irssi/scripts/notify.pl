use strict;
use Irssi;
use vars qw($VERSION %IRSSI);
 
$VERSION = "0.1";
%IRSSI = (
  authors     => 'Julian Andrews',
  contact     => 'jandrews271@gmail.com',
  name        => 'notify',
  description => 'Simple `notify-send` based message notifications',
  license     => 'GNU General Public License',
);
 
sub notify {
  my ($dest, $text, $stripped) = @_;
  my $level = $dest->{level};
  my $target = $dest->{target};
  my $server = $dest->{server};
  my $urgency = $level & MSGLEVEL_HILIGHT ? 'critical' : 'normal';

  # !(($target == '&bitlbee') && (substr($stripped, 0, 7) == '<@root>'))

  if( $server &&
      !($level & MSGLEVEL_NO_ACT) &&
      ($level & (MSGLEVEL_PUBLIC | MSGLEVEL_MSGS | MSGLEVEL_HILIGHT))
  ) {
    system("notify-send '$target' '$stripped' -u $urgency");
  }
}
 
Irssi::signal_add('print text', 'notify');
