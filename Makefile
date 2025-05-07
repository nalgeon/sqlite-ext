# Copyright (c) 2024 Anton Zhiyanov, MIT License
# https://github.com/nalgeon/sqlite-ext

SQLITE_RELEASE_YEAR := 2025
SQLITE_VERSION := 3490100

prepare-dist:
	mkdir -p dist
	rm -rf dist/*
	mkdir -p dist/misc
	rm -f dist/misc/*

download-amalgamation:
	curl -L http://sqlite.org/$(SQLITE_RELEASE_YEAR)/sqlite-amalgamation-$(SQLITE_VERSION).zip --output src.zip
	unzip src.zip
	mkdir -p src
	mv sqlite-amalgamation-$(SQLITE_VERSION)/* src
	rm -rf sqlite-amalgamation-$(SQLITE_VERSION)
	rm -f src.zip

download-extensions:
	curl -L http://sqlite.org/$(SQLITE_RELEASE_YEAR)/sqlite-src-$(SQLITE_VERSION).zip --output src.zip
	unzip src.zip
	mv sqlite-src-$(SQLITE_VERSION)/ext/misc src
	cp sqlite-src-$(SQLITE_VERSION)/src/test_windirent.h src/misc
	cp src/sqlite3.h src/sqlite3ext.h src/misc
	rm -rf sqlite-src-$(SQLITE_VERSION)
	rm -f src.zip

compile-linux:
	make compile-linux-extension name=misc/amatch
	make compile-linux-extension name=misc/base64
	make compile-linux-extension name=misc/base85
	make compile-linux-extension name=misc/blobio
	make compile-linux-extension name=misc/btreeinfo
	make compile-linux-extension name=misc/carray
	make compile-linux-extension name=misc/closure
	make compile-linux-extension name=misc/completion
	make compile-linux-extension name=misc/compress args="-lz"
	make compile-linux-extension name=misc/csv
	# make compile-linux-extension name=misc/dbdump
	make compile-linux-extension name=misc/decimal
	make compile-linux-extension name=misc/eval
	make compile-linux-extension name=misc/explain
	make compile-linux-extension name=misc/fileio
	make compile-linux-extension name=misc/fossildelta
	make compile-linux-extension name=misc/fuzzer
	make compile-linux-extension name=misc/ieee754
	make compile-linux-extension name=misc/memstat
	make compile-linux-extension name=misc/nextchar
	make compile-linux-extension name=misc/percentile
	make compile-linux-extension name=misc/prefixes
	# make compile-linux-extension name=misc/qpvtab
	make compile-linux-extension name=misc/randomjson
	make compile-linux-extension name=misc/regexp
	make compile-linux-extension name=misc/remember
	make compile-linux-extension name=misc/rot13
	make compile-linux-extension name=misc/series
	make compile-linux-extension name=misc/sha1
	make compile-linux-extension name=misc/shathree
	make compile-linux-extension name=misc/spellfix
	make compile-linux-extension name=misc/sqlar args="-lz"
	make compile-linux-extension name=misc/stmt
	make compile-linux-extension name=misc/stmtrand
	make compile-linux-extension name=misc/totype
	make compile-linux-extension name=misc/uint
	make compile-linux-extension name=misc/unionvtab
	make compile-linux-extension name=misc/urifuncs
	make compile-linux-extension name=misc/uuid
	make compile-linux-extension name=misc/vfsstat
	make compile-linux-extension name=misc/vtablog
	make compile-linux-extension name=misc/wholenumber
	make compile-linux-extension name=misc/zipfile args="-lz"
	make compile-linux-extension name=misc/zorder

compile-linux-extension:
	gcc -O2 -fPIC -shared -Isrc src/$(name).c $(src) -o dist/$(name).so $(args)

compile-windows:
	make compile-windows-extension name=misc/amatch
	make compile-windows-extension name=misc/base64
	make compile-windows-extension name=misc/base85
	make compile-windows-extension name=misc/blobio
	make compile-windows-extension name=misc/btreeinfo
	make compile-windows-extension name=misc/carray
	make compile-windows-extension name=misc/closure
	make compile-windows-extension name=misc/completion
	# make compile-windows-extension name=misc/compress args="-lz"
	make compile-windows-extension name=misc/csv
	# make compile-windows-extension name=misc/dbdump
	make compile-windows-extension name=misc/decimal
	make compile-windows-extension name=misc/eval
	make compile-windows-extension name=misc/explain
	# make compile-windows-extension name=misc/fileio
	make compile-windows-extension name=misc/fossildelta
	make compile-windows-extension name=misc/fuzzer
	make compile-windows-extension name=misc/ieee754
	make compile-windows-extension name=misc/memstat
	make compile-windows-extension name=misc/nextchar
	make compile-windows-extension name=misc/percentile
	make compile-windows-extension name=misc/prefixes
	# make compile-windows-extension name=misc/qpvtab
	make compile-windows-extension name=misc/randomjson
	make compile-windows-extension name=misc/regexp
	make compile-windows-extension name=misc/remember
	make compile-windows-extension name=misc/rot13
	make compile-windows-extension name=misc/series
	make compile-windows-extension name=misc/sha1
	make compile-windows-extension name=misc/shathree
	make compile-windows-extension name=misc/spellfix
	# make compile-windows-extension name=misc/sqlar args="-lz"
	make compile-windows-extension name=misc/stmt
	make compile-windows-extension name=misc/stmtrand
	make compile-windows-extension name=misc/totype
	make compile-windows-extension name=misc/uint
	make compile-windows-extension name=misc/unionvtab
	make compile-windows-extension name=misc/urifuncs
	make compile-windows-extension name=misc/uuid
	make compile-windows-extension name=misc/vfsstat
	make compile-windows-extension name=misc/vtablog
	make compile-windows-extension name=misc/wholenumber
	# make compile-windows-extension name=misc/zipfile args="-lz"
	make compile-windows-extension name=misc/zorder

compile-windows-extension:
	gcc -O2 -fPIC -shared -Isrc src/$(name).c $(src) -o dist/$(name).dll $(args)

compile-macos:
	make compile-macos-extension name=misc/amatch
	make compile-macos-extension name=misc/base64
	make compile-macos-extension name=misc/base85
	make compile-macos-extension name=misc/blobio
	make compile-macos-extension name=misc/btreeinfo
	make compile-macos-extension name=misc/carray
	make compile-macos-extension name=misc/closure
	make compile-macos-extension name=misc/completion
	make compile-macos-extension name=misc/compress args="-lz"
	make compile-macos-extension name=misc/csv
	# make compile-macos-extension name=misc/dbdump
	make compile-macos-extension name=misc/decimal
	make compile-macos-extension name=misc/eval
	make compile-macos-extension name=misc/explain
	make compile-macos-extension name=misc/fileio
	make compile-macos-extension name=misc/fossildelta
	make compile-macos-extension name=misc/fuzzer
	make compile-macos-extension name=misc/ieee754
	make compile-macos-extension name=misc/memstat
	make compile-macos-extension name=misc/nextchar
	make compile-macos-extension name=misc/percentile
	make compile-macos-extension name=misc/prefixes
	# make compile-macos-extension name=misc/qpvtab
	make compile-macos-extension name=misc/randomjson
	make compile-macos-extension name=misc/regexp
	make compile-macos-extension name=misc/remember
	make compile-macos-extension name=misc/rot13
	make compile-macos-extension name=misc/series
	make compile-macos-extension name=misc/sha1
	make compile-macos-extension name=misc/shathree
	make compile-macos-extension name=misc/spellfix
	make compile-macos-extension name=misc/sqlar args="-lz"
	make compile-macos-extension name=misc/stmt
	make compile-macos-extension name=misc/stmtrand
	make compile-macos-extension name=misc/totype
	make compile-macos-extension name=misc/uint
	make compile-macos-extension name=misc/unionvtab
	make compile-macos-extension name=misc/urifuncs
	make compile-macos-extension name=misc/uuid
	make compile-macos-extension name=misc/vfsstat
	make compile-macos-extension name=misc/vtablog
	make compile-macos-extension name=misc/wholenumber
	make compile-macos-extension name=misc/zipfile args="-lz"
	make compile-macos-extension name=misc/zorder

compile-macos-extension:
	gcc -O2 -fPIC -shared -Isrc src/$(name).c $(src) -o dist/$(name).x86_64.dylib -target x86_64-apple-macos10.15 $(args)
	gcc -O2 -fPIC -shared -Isrc src/$(name).c $(src) -o dist/$(name).arm64.dylib -target arm64-apple-macos11 $(args)
	lipo -create -output dist/$(name).dylib dist/$(name).x86_64.dylib dist/$(name).arm64.dylib
	rm -f dist/$(name).x86_64.dylib dist/$(name).arm64.dylib
