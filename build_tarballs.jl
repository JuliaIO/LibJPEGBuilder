# Note that this script can accept some limited command-line arguments, run
# `julia build_tarballs.jl --help` to see a usage message.
using BinaryBuilder

name = "libjpeg"
version = v"9.0.0-b"

# Collection of sources required to build libjpeg
sources = [
    "http://www.imagemagick.org/download/delegates/jpegsrc.v9b.tar.gz" =>
    "240fd398da741669bf3c90366f58452ea59041cacc741a489b99f2f6a0bad052",

]

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir
cd jpeg-9b/
./configure --prefix=$prefix --host=$target
make -j${ncore}
make install
exit
"""

# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
platforms = supported_platforms()

# The products that we will ensure are always built
products(prefix) = [
    LibraryProduct(prefix, "libjpeg", :libjpeg)
]

# Dependencies that must be installed before this package can be built
dependencies = [

]

# Build the tarballs, and possibly a `build.jl` as well.
build_tarballs(ARGS, name, version, sources, script, platforms, products, dependencies)
