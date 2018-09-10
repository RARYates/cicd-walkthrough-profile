#!/bin/bash
PATH=$PATH:/usr/local/rvm/gems/ruby-2.4.1/bin/:/usr/local/bin
source /usr/local/rvm/bin/rvm
/usr/local/rvm/gems/ruby-2.4.1/wrappers/kitchen test
