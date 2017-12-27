#!/usr/bin/env bash
su vagrant -c 'brew update'
su vagrant -c 'brew tap caskroom/cask'
su vagrant -c 'brew tap caskroom/versions'
su vagrant -c 'brew cask install java8'
su vagrant -c 'brew install qt lcov meson'
su vagrant -c 'brew install python3 objc-codegenutils objc-run'
su vagrant -c 'brew install pkg-config zlib'
