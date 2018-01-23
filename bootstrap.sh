#!/usr/bin/env bash
su vagrant -c 'brew update'
su vagrant -c 'brew tap caskroom/cask'
su vagrant -c 'brew tap caskroom/versions'
su vagrant -c 'brew cask install java8'
su vagrant -c 'brew install qt lcov meson'
su vagrant -c 'brew install python3 objc-codegenutils objc-run'
su vagrant -c 'brew install pkg-config zlib cmake libtiff cfitsio hdf5 gsl clfft pandoc'
su vagrant -c 'brew install iltommi/brews/hdf4'
su vagrant -c 'softwareupdate --list'
su vagrant -c 'softwareupdate --install "Command Line Tools (macOS Sierra version 10.12) for Xcode-9.2"'
su vagrant -c 'sudo xcode-select --switch /Library/Developer/CommandLineTools'
