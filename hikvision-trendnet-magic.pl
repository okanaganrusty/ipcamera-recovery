#!/usr/bin/perl -w

# Sends the SWKH magic sequence which starts the upgrade/recovery process

use IO::Socket;
use constant MAXBYTES => scalar 20;
use constant MAGIC => scalar 'SWKH';

$socket = IO::Socket::INET->new(
  LocalPort => 9978,
  Type      => SOCK_DGRAM,
  Proto     => 'udp') or die "Could not open socket!\n";

while (1) {
      my ($data, $magic);

      # Receive the magic packet
      $socket->recv($data, MAXBYTES) or die "Server recv: $!\n";

      # Pack the response back (SWKH)
      $magic = pack("C*",
        0x53, 0x57, 0x4b, 0x48, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00);

      print "Sent back bytes: $magic\n";

      $socket->send($magic) or die "Server send: $!\n";
}
