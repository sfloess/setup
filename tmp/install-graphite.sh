
#!/bin/sh

export PYTHONPATH="/opt/graphite/lib/:/opt/graphite/webapp/"
pip3 install --no-binary=:all: https://github.com/graphite-project/whisper/tarball/master
pip3 install --no-binary=:all: https://github.com/graphite-project/carbon/tarball/master
pip3 install --no-binary=:all: https://github.com/graphite-project/graphite-web/tarball/master

