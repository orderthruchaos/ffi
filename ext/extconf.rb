#!/usr/bin/env ruby
require 'mkmf'
dir_config("ffi")
build_ffi = !have_library("ffi")
create_makefile("ffi")
File.open("Makefile", "a") do |mf|
  mf.puts "OS=$(shell uname -s)"
  mf.puts "ARCH=$(shell uname -p)"
  mf.puts 'CFLAGS += -DOS=\\"$(OS)\\" -DARCH=\\"$(ARCH)\\"'
end
if build_ffi
  File.open("Makefile", "a") do |mf|
    mf.puts "libffi_build:"
    mf.puts "\t$(MAKE) -f libffi.mk"
    mf.puts "$(OBJS):\tlibffi_build"
    mf.puts "libffi_clean:"
    mf.puts "\t$(MAKE) -f libffi.mk clean"
    mf.puts "clean:\tlibffi_clean"
  end
end
