#!/bin/bash

gem build testmunk.gemspec
sudo gem install --local testmunk-0.0.1.gem