# Local shallow Git mirror for systemd 255.22

SRC_URI:remove = "git://github.com/systemd/systemd-stable.git;protocol=https;branch=v255-stable"

SRC_URI:prepend = "git:///home/john/Projects/Yocto-RPi3-Scarthgap/mirrors/systemd-255.git;protocol=file;branch=v255-stable "

SRCREV = "356c54394add8c6a1d52773852c23656590dc33b"
