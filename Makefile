srcdir = /var/www/html/rar-4.2.0
builddir = /var/www/html/rar-4.2.0
top_srcdir = /var/www/html/rar-4.2.0
top_builddir = /var/www/html/rar-4.2.0
EGREP = /usr/bin/grep -E
SED = /usr/bin/sed
CONFIGURE_COMMAND = './configure'
CONFIGURE_OPTIONS =
SHLIB_SUFFIX_NAME = so
SHLIB_DL_SUFFIX_NAME = so
AWK = nawk
RAR_SHARED_LIBADD = -lstdc++
shared_objects_rar = rar.lo rar_error.lo rararch.lo rarentry.lo rar_stream.lo rar_navigation.lo rar_time.lo unrar/sha256.lo unrar/qopen.lo unrar/blake2s.lo unrar/recvol.lo unrar/headers.lo unrar/match.lo unrar/find.lo unrar/resource.lo unrar/pathfn.lo unrar/dll.lo unrar/threadpool.lo unrar/volume.lo unrar/unpack.lo unrar/extract.lo unrar/errhnd.lo unrar/crc.lo unrar/rijndael.lo unrar/crypt.lo unrar/rawread.lo unrar/rs.lo unrar/smallfn.lo unrar/isnt.lo unrar/rar.lo unrar/consio.lo unrar/scantree.lo unrar/archive.lo unrar/strfn.lo unrar/strlist.lo unrar/getbits.lo unrar/hash.lo unrar/filestr.lo unrar/extinfo.lo unrar/ui.lo unrar/rarvm.lo unrar/timefn.lo unrar/sha1.lo unrar/rdwrfn.lo unrar/rs16.lo unrar/cmddata.lo unrar/extractchunk.lo unrar/system.lo unrar/unicode.lo unrar/filcreat.lo unrar/arcread.lo unrar/filefn.lo unrar/global.lo unrar/list.lo unrar/encname.lo unrar/file.lo unrar/secpassword.lo unrar/options.lo
PHP_PECL_EXTENSION = rar
PHP_MODULES = $(phplibdir)/rar.la
PHP_ZEND_EX =
all_targets = $(PHP_MODULES) $(PHP_ZEND_EX)
install_targets = install-modules install-headers
prefix = /usr/local
exec_prefix = $(prefix)
libdir = ${exec_prefix}/lib
prefix = /usr/local
phplibdir = /var/www/html/rar-4.2.0/modules
phpincludedir = /usr/local/include/php
CC = cc
CFLAGS = -g -O2
CFLAGS_CLEAN = $(CFLAGS) -D_GNU_SOURCE
CPP = cc -E
CPPFLAGS = -DHAVE_CONFIG_H
CXX = g++
CXXFLAGS = -g -O2
CXXFLAGS_CLEAN = $(CXXFLAGS)
EXTENSION_DIR = /usr/local/lib/php/extensions/no-debug-non-zts-20230831
PHP_EXECUTABLE = /usr/local/bin/php
EXTRA_LDFLAGS =
EXTRA_LIBS =
INCLUDES = -isystem /usr/local/include/php -isystem /usr/local/include/php/main -isystem /usr/local/include/php/TSRM -isystem /usr/local/include/php/Zend -isystem /usr/local/include/php/ext -isystem /usr/local/include/php/ext/date/lib
LFLAGS =
LDFLAGS =
SHARED_LIBTOOL =
LIBTOOL = $(SHELL) $(top_builddir)/libtool
SHELL = /bin/bash
INSTALL_HEADERS =
BUILD_CC = cc
mkinstalldirs = $(top_srcdir)/build/shtool mkdir -p
INSTALL = $(top_srcdir)/build/shtool install -c
INSTALL_DATA = $(INSTALL) -m 644

DEFS = -I$(top_builddir)/include -I$(top_builddir)/main -I$(top_srcdir)
COMMON_FLAGS = $(DEFS) $(INCLUDES) $(EXTRA_INCLUDES) $(CPPFLAGS) $(PHP_FRAMEWORKPATH)

all: $(all_targets)
	@echo
	@echo "Build complete."
	@echo "Don't forget to run 'make test'."
	@echo

build-modules: $(PHP_MODULES) $(PHP_ZEND_EX)

build-binaries: $(PHP_BINARIES)

libphp.la: $(PHP_GLOBAL_OBJS) $(PHP_SAPI_OBJS)
	$(LIBTOOL) --tag=CC --mode=link $(CC) $(LIBPHP_CFLAGS) $(CFLAGS) $(EXTRA_CFLAGS) -rpath $(phptempdir) $(EXTRA_LDFLAGS) $(LDFLAGS) $(PHP_RPATHS) $(PHP_GLOBAL_OBJS) $(PHP_SAPI_OBJS) $(EXTRA_LIBS) $(ZEND_EXTRA_LIBS) -o $@
	-@$(LIBTOOL) --silent --tag=CC --mode=install cp $@ $(phptempdir)/$@ >/dev/null 2>&1

libs/libphp.bundle: $(PHP_GLOBAL_OBJS) $(PHP_SAPI_OBJS)
	$(CC) $(MH_BUNDLE_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS) $(LDFLAGS) $(EXTRA_LDFLAGS) $(PHP_GLOBAL_OBJS:.lo=.o) $(PHP_SAPI_OBJS:.lo=.o) $(PHP_FRAMEWORKS) $(EXTRA_LIBS) $(ZEND_EXTRA_LIBS) -o $@ && cp $@ libs/libphp.so

install: $(all_targets) $(install_targets)

install-sapi: $(OVERALL_TARGET)
	@echo "Installing PHP SAPI module:       $(PHP_SAPI)"
	-@$(mkinstalldirs) $(INSTALL_ROOT)$(bindir)
	-@if test ! -r $(phptempdir)/libphp.$(SHLIB_DL_SUFFIX_NAME); then \
		for i in 0.0.0 0.0 0; do \
			if test -r $(phptempdir)/libphp.$(SHLIB_DL_SUFFIX_NAME).$$i; then \
				$(LN_S) $(phptempdir)/libphp.$(SHLIB_DL_SUFFIX_NAME).$$i $(phptempdir)/libphp.$(SHLIB_DL_SUFFIX_NAME); \
				break; \
			fi; \
		done; \
	fi
	@$(INSTALL_IT)

install-binaries: build-binaries $(install_binary_targets)

install-modules: build-modules
	@test -d modules && \
	$(mkinstalldirs) $(INSTALL_ROOT)$(EXTENSION_DIR)
	@echo "Installing shared extensions:     $(INSTALL_ROOT)$(EXTENSION_DIR)/"
	@rm -f modules/*.la >/dev/null 2>&1
	@$(INSTALL) modules/* $(INSTALL_ROOT)$(EXTENSION_DIR)

install-headers:
	-@if test "$(INSTALL_HEADERS)"; then \
		for i in `echo $(INSTALL_HEADERS)`; do \
			i=`$(top_srcdir)/build/shtool path -d $$i`; \
			paths="$$paths $(INSTALL_ROOT)$(phpincludedir)/$$i"; \
		done; \
		$(mkinstalldirs) $$paths && \
		echo "Installing header files:          $(INSTALL_ROOT)$(phpincludedir)/" && \
		for i in `echo $(INSTALL_HEADERS)`; do \
			if test "$(PHP_PECL_EXTENSION)"; then \
				src=`echo $$i | $(SED) -e "s#ext/$(PHP_PECL_EXTENSION)/##g"`; \
			else \
				src=$$i; \
			fi; \
			if test -f "$(top_srcdir)/$$src"; then \
				$(INSTALL_DATA) $(top_srcdir)/$$src $(INSTALL_ROOT)$(phpincludedir)/$$i; \
			elif test -f "$(top_builddir)/$$src"; then \
				$(INSTALL_DATA) $(top_builddir)/$$src $(INSTALL_ROOT)$(phpincludedir)/$$i; \
			else \
				(cd $(top_srcdir)/$$src && $(INSTALL_DATA) *.h $(INSTALL_ROOT)$(phpincludedir)/$$i; \
				cd $(top_builddir)/$$src && $(INSTALL_DATA) *.h $(INSTALL_ROOT)$(phpincludedir)/$$i) 2>/dev/null || true; \
			fi \
		done; \
	fi

PHP_TEST_SETTINGS = -d 'open_basedir=' -d 'output_buffering=0' -d 'memory_limit=-1'
PHP_TEST_SHARED_EXTENSIONS =  ` \
	if test "x$(PHP_MODULES)" != "x"; then \
		for i in $(PHP_MODULES)""; do \
			. $$i; \
			if test "x$$dlname" != "xdl_test.so"; then \
				$(top_srcdir)/build/shtool echo -n -- " -d extension=$$dlname"; \
			fi; \
		done; \
	fi; \
	if test "x$(PHP_ZEND_EX)" != "x"; then \
		for i in $(PHP_ZEND_EX)""; do \
			. $$i; $(top_srcdir)/build/shtool echo -n -- " -d zend_extension=$(top_builddir)/modules/$$dlname"; \
		done; \
	fi`
PHP_DEPRECATED_DIRECTIVES_REGEX = '^(magic_quotes_(gpc|runtime|sybase)?|(zend_)?extension(_debug)?(_ts)?)[\t\ ]*='

test: all
	@if test ! -z "$(PHP_EXECUTABLE)" && test -x "$(PHP_EXECUTABLE)"; then \
		INI_FILE=`$(PHP_EXECUTABLE) -d 'display_errors=stderr' -r 'echo php_ini_loaded_file();' 2> /dev/null`; \
		if test "$$INI_FILE"; then \
			$(EGREP) -h -v $(PHP_DEPRECATED_DIRECTIVES_REGEX) "$$INI_FILE" > $(top_builddir)/tmp-php.ini; \
		else \
			echo > $(top_builddir)/tmp-php.ini; \
		fi; \
		INI_SCANNED_PATH=`$(PHP_EXECUTABLE) -d 'display_errors=stderr' -r '$$a = explode(",\n", trim(php_ini_scanned_files())); echo $$a[0];' 2> /dev/null`; \
		if test "$$INI_SCANNED_PATH"; then \
			INI_SCANNED_PATH=`$(top_srcdir)/build/shtool path -d $$INI_SCANNED_PATH`; \
			$(EGREP) -h -v $(PHP_DEPRECATED_DIRECTIVES_REGEX) "$$INI_SCANNED_PATH"/*.ini >> $(top_builddir)/tmp-php.ini; \
		fi; \
		TEST_PHP_EXECUTABLE=$(PHP_EXECUTABLE) \
		TEST_PHP_SRCDIR=$(top_srcdir) \
		CC="$(CC)" \
			$(PHP_EXECUTABLE) -n -c $(top_builddir)/tmp-php.ini $(PHP_TEST_SETTINGS) $(top_srcdir)/run-tests.php -n -c $(top_builddir)/tmp-php.ini -d extension_dir=$(top_builddir)/modules/ $(PHP_TEST_SHARED_EXTENSIONS) $(TESTS); \
		TEST_RESULT_EXIT_CODE=$$?; \
		rm $(top_builddir)/tmp-php.ini; \
		exit $$TEST_RESULT_EXIT_CODE; \
	else \
		echo "ERROR: Cannot run tests without CLI sapi."; \
	fi

clean:
	find . -name \*.gcno -o -name \*.gcda | xargs rm -f
	find . -name \*.lo -o -name \*.o -o -name \*.dep | xargs rm -f
	find . -name \*.la -o -name \*.a | xargs rm -f
	find . -name \*.so | xargs rm -f
	find . -name .libs -a -type d|xargs rm -rf
	rm -f libphp.la $(SAPI_CLI_PATH) $(SAPI_CGI_PATH) $(SAPI_LITESPEED_PATH) $(SAPI_FPM_PATH) $(OVERALL_TARGET) modules/* libs/*
	rm -f ext/opcache/jit/zend_jit_x86.c
	rm -f ext/opcache/jit/zend_jit_arm64.c
	rm -f ext/opcache/minilua

distclean: clean
	rm -f Makefile config.cache config.log config.status Makefile.objects Makefile.fragments libtool main/php_config.h main/internal_functions_cli.c main/internal_functions.c Zend/zend_dtrace_gen.h Zend/zend_dtrace_gen.h.bak Zend/zend_config.h
	rm -f main/build-defs.h scripts/phpize
	rm -f ext/date/lib/timelib_config.h ext/mbstring/libmbfl/config.h ext/oci8/oci8_dtrace_gen.h ext/oci8/oci8_dtrace_gen.h.bak
	rm -f scripts/man1/phpize.1 scripts/php-config scripts/man1/php-config.1 sapi/cli/php.1 sapi/cgi/php-cgi.1 sapi/phpdbg/phpdbg.1 ext/phar/phar.1 ext/phar/phar.phar.1
	rm -f sapi/fpm/php-fpm.conf sapi/fpm/init.d.php-fpm sapi/fpm/php-fpm.service sapi/fpm/php-fpm.8 sapi/fpm/status.html
	rm -f ext/phar/phar.phar ext/phar/phar.php
	if test "$(srcdir)" != "$(builddir)"; then \
	  rm -f ext/phar/phar/phar.inc; \
	fi
	$(EGREP) define'.*include/php' $(top_srcdir)/configure | $(SED) 's/.*>//'|xargs rm -f

prof-gen:
	CCACHE_DISABLE=1 $(MAKE) PROF_FLAGS=-fprofile-generate all
	find . -name \*.gcda | xargs rm -f

prof-clean:
	find . -name \*.lo -o -name \*.o | xargs rm -f
	find . -name \*.la -o -name \*.a | xargs rm -f
	find . -name \*.so | xargs rm -f
	rm -f libphp.la $(SAPI_CLI_PATH) $(SAPI_CGI_PATH) $(SAPI_LITESPEED_PATH) $(SAPI_FPM_PATH) $(OVERALL_TARGET) modules/* libs/*

prof-use:
	CCACHE_DISABLE=1 $(MAKE) PROF_FLAGS=-fprofile-use all

%_arginfo.h: %.stub.php
	@if test -e "$(top_srcdir)/build/gen_stub.php"; then \
		if test ! -z "$(PHP)"; then \
			echo Parse $< to generate $@;\
			$(PHP) $(top_srcdir)/build/gen_stub.php $<; \
		elif test ! -z "$(PHP_EXECUTABLE)" && test -x "$(PHP_EXECUTABLE)"; then \
			echo Parse $< to generate $@;\
			$(PHP_EXECUTABLE) $(top_srcdir)/build/gen_stub.php $<; \
		fi; \
	fi;

.PHONY: all clean install distclean test prof-gen prof-clean prof-use
.NOEXPORT:
EXTRA_CXXFLAGS := $(EXTRA_CXXFLAGS)  -Wno-parentheses -Wno-switch -Wno-dangling-else -Wno-unused-function -Wno-unused-variable -Wno-sign-compare -Wno-misleading-indentation
replace-run-tests:
	@if ! grep -q 'Minimum required PHP version: 5\.3\.0' run-tests.php; then \
		cp run-tests8.php run-tests.php; \
	fi

test: replace-run-tests
-include rar.dep
rar.lo: /var/www/html/rar-4.2.0/rar.c
	$(LIBTOOL) --tag=CC --mode=compile $(CC) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/rar.c -o rar.lo  -MMD -MF rar.dep -MT rar.lo
-include rar_error.dep
rar_error.lo: /var/www/html/rar-4.2.0/rar_error.c
	$(LIBTOOL) --tag=CC --mode=compile $(CC) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/rar_error.c -o rar_error.lo  -MMD -MF rar_error.dep -MT rar_error.lo
-include rararch.dep
rararch.lo: /var/www/html/rar-4.2.0/rararch.c
	$(LIBTOOL) --tag=CC --mode=compile $(CC) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/rararch.c -o rararch.lo  -MMD -MF rararch.dep -MT rararch.lo
-include rarentry.dep
rarentry.lo: /var/www/html/rar-4.2.0/rarentry.c
	$(LIBTOOL) --tag=CC --mode=compile $(CC) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/rarentry.c -o rarentry.lo  -MMD -MF rarentry.dep -MT rarentry.lo
-include rar_stream.dep
rar_stream.lo: /var/www/html/rar-4.2.0/rar_stream.c
	$(LIBTOOL) --tag=CC --mode=compile $(CC) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/rar_stream.c -o rar_stream.lo  -MMD -MF rar_stream.dep -MT rar_stream.lo
-include rar_navigation.dep
rar_navigation.lo: /var/www/html/rar-4.2.0/rar_navigation.c
	$(LIBTOOL) --tag=CC --mode=compile $(CC) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/rar_navigation.c -o rar_navigation.lo  -MMD -MF rar_navigation.dep -MT rar_navigation.lo
-include rar_time.dep
rar_time.lo: /var/www/html/rar-4.2.0/rar_time.c
	$(LIBTOOL) --tag=CC --mode=compile $(CC) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/rar_time.c -o rar_time.lo  -MMD -MF rar_time.dep -MT rar_time.lo
-include unrar/sha256.dep
unrar/sha256.lo: /var/www/html/rar-4.2.0/unrar/sha256.cpp
	$(LIBTOOL) --tag=CXX --mode=compile $(CXX) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CXXFLAGS_CLEAN) $(EXTRA_CXXFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/unrar/sha256.cpp -o unrar/sha256.lo  -MMD -MF unrar/sha256.dep -MT unrar/sha256.lo
-include unrar/qopen.dep
unrar/qopen.lo: /var/www/html/rar-4.2.0/unrar/qopen.cpp
	$(LIBTOOL) --tag=CXX --mode=compile $(CXX) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CXXFLAGS_CLEAN) $(EXTRA_CXXFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/unrar/qopen.cpp -o unrar/qopen.lo  -MMD -MF unrar/qopen.dep -MT unrar/qopen.lo
-include unrar/blake2s.dep
unrar/blake2s.lo: /var/www/html/rar-4.2.0/unrar/blake2s.cpp
	$(LIBTOOL) --tag=CXX --mode=compile $(CXX) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CXXFLAGS_CLEAN) $(EXTRA_CXXFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/unrar/blake2s.cpp -o unrar/blake2s.lo  -MMD -MF unrar/blake2s.dep -MT unrar/blake2s.lo
-include unrar/recvol.dep
unrar/recvol.lo: /var/www/html/rar-4.2.0/unrar/recvol.cpp
	$(LIBTOOL) --tag=CXX --mode=compile $(CXX) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CXXFLAGS_CLEAN) $(EXTRA_CXXFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/unrar/recvol.cpp -o unrar/recvol.lo  -MMD -MF unrar/recvol.dep -MT unrar/recvol.lo
-include unrar/headers.dep
unrar/headers.lo: /var/www/html/rar-4.2.0/unrar/headers.cpp
	$(LIBTOOL) --tag=CXX --mode=compile $(CXX) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CXXFLAGS_CLEAN) $(EXTRA_CXXFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/unrar/headers.cpp -o unrar/headers.lo  -MMD -MF unrar/headers.dep -MT unrar/headers.lo
-include unrar/match.dep
unrar/match.lo: /var/www/html/rar-4.2.0/unrar/match.cpp
	$(LIBTOOL) --tag=CXX --mode=compile $(CXX) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CXXFLAGS_CLEAN) $(EXTRA_CXXFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/unrar/match.cpp -o unrar/match.lo  -MMD -MF unrar/match.dep -MT unrar/match.lo
-include unrar/find.dep
unrar/find.lo: /var/www/html/rar-4.2.0/unrar/find.cpp
	$(LIBTOOL) --tag=CXX --mode=compile $(CXX) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CXXFLAGS_CLEAN) $(EXTRA_CXXFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/unrar/find.cpp -o unrar/find.lo  -MMD -MF unrar/find.dep -MT unrar/find.lo
-include unrar/resource.dep
unrar/resource.lo: /var/www/html/rar-4.2.0/unrar/resource.cpp
	$(LIBTOOL) --tag=CXX --mode=compile $(CXX) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CXXFLAGS_CLEAN) $(EXTRA_CXXFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/unrar/resource.cpp -o unrar/resource.lo  -MMD -MF unrar/resource.dep -MT unrar/resource.lo
-include unrar/pathfn.dep
unrar/pathfn.lo: /var/www/html/rar-4.2.0/unrar/pathfn.cpp
	$(LIBTOOL) --tag=CXX --mode=compile $(CXX) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CXXFLAGS_CLEAN) $(EXTRA_CXXFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/unrar/pathfn.cpp -o unrar/pathfn.lo  -MMD -MF unrar/pathfn.dep -MT unrar/pathfn.lo
-include unrar/dll.dep
unrar/dll.lo: /var/www/html/rar-4.2.0/unrar/dll.cpp
	$(LIBTOOL) --tag=CXX --mode=compile $(CXX) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CXXFLAGS_CLEAN) $(EXTRA_CXXFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/unrar/dll.cpp -o unrar/dll.lo  -MMD -MF unrar/dll.dep -MT unrar/dll.lo
-include unrar/threadpool.dep
unrar/threadpool.lo: /var/www/html/rar-4.2.0/unrar/threadpool.cpp
	$(LIBTOOL) --tag=CXX --mode=compile $(CXX) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CXXFLAGS_CLEAN) $(EXTRA_CXXFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/unrar/threadpool.cpp -o unrar/threadpool.lo  -MMD -MF unrar/threadpool.dep -MT unrar/threadpool.lo
-include unrar/volume.dep
unrar/volume.lo: /var/www/html/rar-4.2.0/unrar/volume.cpp
	$(LIBTOOL) --tag=CXX --mode=compile $(CXX) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CXXFLAGS_CLEAN) $(EXTRA_CXXFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/unrar/volume.cpp -o unrar/volume.lo  -MMD -MF unrar/volume.dep -MT unrar/volume.lo
-include unrar/unpack.dep
unrar/unpack.lo: /var/www/html/rar-4.2.0/unrar/unpack.cpp
	$(LIBTOOL) --tag=CXX --mode=compile $(CXX) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CXXFLAGS_CLEAN) $(EXTRA_CXXFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/unrar/unpack.cpp -o unrar/unpack.lo  -MMD -MF unrar/unpack.dep -MT unrar/unpack.lo
-include unrar/extract.dep
unrar/extract.lo: /var/www/html/rar-4.2.0/unrar/extract.cpp
	$(LIBTOOL) --tag=CXX --mode=compile $(CXX) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CXXFLAGS_CLEAN) $(EXTRA_CXXFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/unrar/extract.cpp -o unrar/extract.lo  -MMD -MF unrar/extract.dep -MT unrar/extract.lo
-include unrar/errhnd.dep
unrar/errhnd.lo: /var/www/html/rar-4.2.0/unrar/errhnd.cpp
	$(LIBTOOL) --tag=CXX --mode=compile $(CXX) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CXXFLAGS_CLEAN) $(EXTRA_CXXFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/unrar/errhnd.cpp -o unrar/errhnd.lo  -MMD -MF unrar/errhnd.dep -MT unrar/errhnd.lo
-include unrar/crc.dep
unrar/crc.lo: /var/www/html/rar-4.2.0/unrar/crc.cpp
	$(LIBTOOL) --tag=CXX --mode=compile $(CXX) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CXXFLAGS_CLEAN) $(EXTRA_CXXFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/unrar/crc.cpp -o unrar/crc.lo  -MMD -MF unrar/crc.dep -MT unrar/crc.lo
-include unrar/rijndael.dep
unrar/rijndael.lo: /var/www/html/rar-4.2.0/unrar/rijndael.cpp
	$(LIBTOOL) --tag=CXX --mode=compile $(CXX) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CXXFLAGS_CLEAN) $(EXTRA_CXXFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/unrar/rijndael.cpp -o unrar/rijndael.lo  -MMD -MF unrar/rijndael.dep -MT unrar/rijndael.lo
-include unrar/crypt.dep
unrar/crypt.lo: /var/www/html/rar-4.2.0/unrar/crypt.cpp
	$(LIBTOOL) --tag=CXX --mode=compile $(CXX) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CXXFLAGS_CLEAN) $(EXTRA_CXXFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/unrar/crypt.cpp -o unrar/crypt.lo  -MMD -MF unrar/crypt.dep -MT unrar/crypt.lo
-include unrar/rawread.dep
unrar/rawread.lo: /var/www/html/rar-4.2.0/unrar/rawread.cpp
	$(LIBTOOL) --tag=CXX --mode=compile $(CXX) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CXXFLAGS_CLEAN) $(EXTRA_CXXFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/unrar/rawread.cpp -o unrar/rawread.lo  -MMD -MF unrar/rawread.dep -MT unrar/rawread.lo
-include unrar/rs.dep
unrar/rs.lo: /var/www/html/rar-4.2.0/unrar/rs.cpp
	$(LIBTOOL) --tag=CXX --mode=compile $(CXX) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CXXFLAGS_CLEAN) $(EXTRA_CXXFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/unrar/rs.cpp -o unrar/rs.lo  -MMD -MF unrar/rs.dep -MT unrar/rs.lo
-include unrar/smallfn.dep
unrar/smallfn.lo: /var/www/html/rar-4.2.0/unrar/smallfn.cpp
	$(LIBTOOL) --tag=CXX --mode=compile $(CXX) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CXXFLAGS_CLEAN) $(EXTRA_CXXFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/unrar/smallfn.cpp -o unrar/smallfn.lo  -MMD -MF unrar/smallfn.dep -MT unrar/smallfn.lo
-include unrar/isnt.dep
unrar/isnt.lo: /var/www/html/rar-4.2.0/unrar/isnt.cpp
	$(LIBTOOL) --tag=CXX --mode=compile $(CXX) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CXXFLAGS_CLEAN) $(EXTRA_CXXFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/unrar/isnt.cpp -o unrar/isnt.lo  -MMD -MF unrar/isnt.dep -MT unrar/isnt.lo
-include unrar/rar.dep
unrar/rar.lo: /var/www/html/rar-4.2.0/unrar/rar.cpp
	$(LIBTOOL) --tag=CXX --mode=compile $(CXX) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CXXFLAGS_CLEAN) $(EXTRA_CXXFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/unrar/rar.cpp -o unrar/rar.lo  -MMD -MF unrar/rar.dep -MT unrar/rar.lo
-include unrar/consio.dep
unrar/consio.lo: /var/www/html/rar-4.2.0/unrar/consio.cpp
	$(LIBTOOL) --tag=CXX --mode=compile $(CXX) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CXXFLAGS_CLEAN) $(EXTRA_CXXFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/unrar/consio.cpp -o unrar/consio.lo  -MMD -MF unrar/consio.dep -MT unrar/consio.lo
-include unrar/scantree.dep
unrar/scantree.lo: /var/www/html/rar-4.2.0/unrar/scantree.cpp
	$(LIBTOOL) --tag=CXX --mode=compile $(CXX) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CXXFLAGS_CLEAN) $(EXTRA_CXXFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/unrar/scantree.cpp -o unrar/scantree.lo  -MMD -MF unrar/scantree.dep -MT unrar/scantree.lo
-include unrar/archive.dep
unrar/archive.lo: /var/www/html/rar-4.2.0/unrar/archive.cpp
	$(LIBTOOL) --tag=CXX --mode=compile $(CXX) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CXXFLAGS_CLEAN) $(EXTRA_CXXFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/unrar/archive.cpp -o unrar/archive.lo  -MMD -MF unrar/archive.dep -MT unrar/archive.lo
-include unrar/strfn.dep
unrar/strfn.lo: /var/www/html/rar-4.2.0/unrar/strfn.cpp
	$(LIBTOOL) --tag=CXX --mode=compile $(CXX) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CXXFLAGS_CLEAN) $(EXTRA_CXXFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/unrar/strfn.cpp -o unrar/strfn.lo  -MMD -MF unrar/strfn.dep -MT unrar/strfn.lo
-include unrar/strlist.dep
unrar/strlist.lo: /var/www/html/rar-4.2.0/unrar/strlist.cpp
	$(LIBTOOL) --tag=CXX --mode=compile $(CXX) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CXXFLAGS_CLEAN) $(EXTRA_CXXFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/unrar/strlist.cpp -o unrar/strlist.lo  -MMD -MF unrar/strlist.dep -MT unrar/strlist.lo
-include unrar/getbits.dep
unrar/getbits.lo: /var/www/html/rar-4.2.0/unrar/getbits.cpp
	$(LIBTOOL) --tag=CXX --mode=compile $(CXX) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CXXFLAGS_CLEAN) $(EXTRA_CXXFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/unrar/getbits.cpp -o unrar/getbits.lo  -MMD -MF unrar/getbits.dep -MT unrar/getbits.lo
-include unrar/hash.dep
unrar/hash.lo: /var/www/html/rar-4.2.0/unrar/hash.cpp
	$(LIBTOOL) --tag=CXX --mode=compile $(CXX) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CXXFLAGS_CLEAN) $(EXTRA_CXXFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/unrar/hash.cpp -o unrar/hash.lo  -MMD -MF unrar/hash.dep -MT unrar/hash.lo
-include unrar/filestr.dep
unrar/filestr.lo: /var/www/html/rar-4.2.0/unrar/filestr.cpp
	$(LIBTOOL) --tag=CXX --mode=compile $(CXX) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CXXFLAGS_CLEAN) $(EXTRA_CXXFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/unrar/filestr.cpp -o unrar/filestr.lo  -MMD -MF unrar/filestr.dep -MT unrar/filestr.lo
-include unrar/extinfo.dep
unrar/extinfo.lo: /var/www/html/rar-4.2.0/unrar/extinfo.cpp
	$(LIBTOOL) --tag=CXX --mode=compile $(CXX) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CXXFLAGS_CLEAN) $(EXTRA_CXXFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/unrar/extinfo.cpp -o unrar/extinfo.lo  -MMD -MF unrar/extinfo.dep -MT unrar/extinfo.lo
-include unrar/ui.dep
unrar/ui.lo: /var/www/html/rar-4.2.0/unrar/ui.cpp
	$(LIBTOOL) --tag=CXX --mode=compile $(CXX) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CXXFLAGS_CLEAN) $(EXTRA_CXXFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/unrar/ui.cpp -o unrar/ui.lo  -MMD -MF unrar/ui.dep -MT unrar/ui.lo
-include unrar/rarvm.dep
unrar/rarvm.lo: /var/www/html/rar-4.2.0/unrar/rarvm.cpp
	$(LIBTOOL) --tag=CXX --mode=compile $(CXX) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CXXFLAGS_CLEAN) $(EXTRA_CXXFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/unrar/rarvm.cpp -o unrar/rarvm.lo  -MMD -MF unrar/rarvm.dep -MT unrar/rarvm.lo
-include unrar/timefn.dep
unrar/timefn.lo: /var/www/html/rar-4.2.0/unrar/timefn.cpp
	$(LIBTOOL) --tag=CXX --mode=compile $(CXX) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CXXFLAGS_CLEAN) $(EXTRA_CXXFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/unrar/timefn.cpp -o unrar/timefn.lo  -MMD -MF unrar/timefn.dep -MT unrar/timefn.lo
-include unrar/sha1.dep
unrar/sha1.lo: /var/www/html/rar-4.2.0/unrar/sha1.cpp
	$(LIBTOOL) --tag=CXX --mode=compile $(CXX) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CXXFLAGS_CLEAN) $(EXTRA_CXXFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/unrar/sha1.cpp -o unrar/sha1.lo  -MMD -MF unrar/sha1.dep -MT unrar/sha1.lo
-include unrar/rdwrfn.dep
unrar/rdwrfn.lo: /var/www/html/rar-4.2.0/unrar/rdwrfn.cpp
	$(LIBTOOL) --tag=CXX --mode=compile $(CXX) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CXXFLAGS_CLEAN) $(EXTRA_CXXFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/unrar/rdwrfn.cpp -o unrar/rdwrfn.lo  -MMD -MF unrar/rdwrfn.dep -MT unrar/rdwrfn.lo
-include unrar/rs16.dep
unrar/rs16.lo: /var/www/html/rar-4.2.0/unrar/rs16.cpp
	$(LIBTOOL) --tag=CXX --mode=compile $(CXX) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CXXFLAGS_CLEAN) $(EXTRA_CXXFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/unrar/rs16.cpp -o unrar/rs16.lo  -MMD -MF unrar/rs16.dep -MT unrar/rs16.lo
-include unrar/cmddata.dep
unrar/cmddata.lo: /var/www/html/rar-4.2.0/unrar/cmddata.cpp
	$(LIBTOOL) --tag=CXX --mode=compile $(CXX) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CXXFLAGS_CLEAN) $(EXTRA_CXXFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/unrar/cmddata.cpp -o unrar/cmddata.lo  -MMD -MF unrar/cmddata.dep -MT unrar/cmddata.lo
-include unrar/extractchunk.dep
unrar/extractchunk.lo: /var/www/html/rar-4.2.0/unrar/extractchunk.cpp
	$(LIBTOOL) --tag=CXX --mode=compile $(CXX) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CXXFLAGS_CLEAN) $(EXTRA_CXXFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/unrar/extractchunk.cpp -o unrar/extractchunk.lo  -MMD -MF unrar/extractchunk.dep -MT unrar/extractchunk.lo
-include unrar/system.dep
unrar/system.lo: /var/www/html/rar-4.2.0/unrar/system.cpp
	$(LIBTOOL) --tag=CXX --mode=compile $(CXX) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CXXFLAGS_CLEAN) $(EXTRA_CXXFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/unrar/system.cpp -o unrar/system.lo  -MMD -MF unrar/system.dep -MT unrar/system.lo
-include unrar/unicode.dep
unrar/unicode.lo: /var/www/html/rar-4.2.0/unrar/unicode.cpp
	$(LIBTOOL) --tag=CXX --mode=compile $(CXX) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CXXFLAGS_CLEAN) $(EXTRA_CXXFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/unrar/unicode.cpp -o unrar/unicode.lo  -MMD -MF unrar/unicode.dep -MT unrar/unicode.lo
-include unrar/filcreat.dep
unrar/filcreat.lo: /var/www/html/rar-4.2.0/unrar/filcreat.cpp
	$(LIBTOOL) --tag=CXX --mode=compile $(CXX) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CXXFLAGS_CLEAN) $(EXTRA_CXXFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/unrar/filcreat.cpp -o unrar/filcreat.lo  -MMD -MF unrar/filcreat.dep -MT unrar/filcreat.lo
-include unrar/arcread.dep
unrar/arcread.lo: /var/www/html/rar-4.2.0/unrar/arcread.cpp
	$(LIBTOOL) --tag=CXX --mode=compile $(CXX) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CXXFLAGS_CLEAN) $(EXTRA_CXXFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/unrar/arcread.cpp -o unrar/arcread.lo  -MMD -MF unrar/arcread.dep -MT unrar/arcread.lo
-include unrar/filefn.dep
unrar/filefn.lo: /var/www/html/rar-4.2.0/unrar/filefn.cpp
	$(LIBTOOL) --tag=CXX --mode=compile $(CXX) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CXXFLAGS_CLEAN) $(EXTRA_CXXFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/unrar/filefn.cpp -o unrar/filefn.lo  -MMD -MF unrar/filefn.dep -MT unrar/filefn.lo
-include unrar/global.dep
unrar/global.lo: /var/www/html/rar-4.2.0/unrar/global.cpp
	$(LIBTOOL) --tag=CXX --mode=compile $(CXX) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CXXFLAGS_CLEAN) $(EXTRA_CXXFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/unrar/global.cpp -o unrar/global.lo  -MMD -MF unrar/global.dep -MT unrar/global.lo
-include unrar/list.dep
unrar/list.lo: /var/www/html/rar-4.2.0/unrar/list.cpp
	$(LIBTOOL) --tag=CXX --mode=compile $(CXX) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CXXFLAGS_CLEAN) $(EXTRA_CXXFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/unrar/list.cpp -o unrar/list.lo  -MMD -MF unrar/list.dep -MT unrar/list.lo
-include unrar/encname.dep
unrar/encname.lo: /var/www/html/rar-4.2.0/unrar/encname.cpp
	$(LIBTOOL) --tag=CXX --mode=compile $(CXX) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CXXFLAGS_CLEAN) $(EXTRA_CXXFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/unrar/encname.cpp -o unrar/encname.lo  -MMD -MF unrar/encname.dep -MT unrar/encname.lo
-include unrar/file.dep
unrar/file.lo: /var/www/html/rar-4.2.0/unrar/file.cpp
	$(LIBTOOL) --tag=CXX --mode=compile $(CXX) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CXXFLAGS_CLEAN) $(EXTRA_CXXFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/unrar/file.cpp -o unrar/file.lo  -MMD -MF unrar/file.dep -MT unrar/file.lo
-include unrar/secpassword.dep
unrar/secpassword.lo: /var/www/html/rar-4.2.0/unrar/secpassword.cpp
	$(LIBTOOL) --tag=CXX --mode=compile $(CXX) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CXXFLAGS_CLEAN) $(EXTRA_CXXFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/unrar/secpassword.cpp -o unrar/secpassword.lo  -MMD -MF unrar/secpassword.dep -MT unrar/secpassword.lo
-include unrar/options.dep
unrar/options.lo: /var/www/html/rar-4.2.0/unrar/options.cpp
	$(LIBTOOL) --tag=CXX --mode=compile $(CXX) -I. -I/var/www/html/rar-4.2.0 $(COMMON_FLAGS) $(CXXFLAGS_CLEAN) $(EXTRA_CXXFLAGS)  -DRARDLL -DSILENT -Wno-write-strings -Wall -fvisibility=hidden -I/var/www/html/rar-4.2.0/unrar -DZEND_COMPILE_DL_EXT=1 -c /var/www/html/rar-4.2.0/unrar/options.cpp -o unrar/options.lo  -MMD -MF unrar/options.dep -MT unrar/options.lo
$(phplibdir)/rar.la: ./rar.la
	$(LIBTOOL) --tag=CC --mode=install cp ./rar.la $(phplibdir)

./rar.la: $(shared_objects_rar) $(RAR_SHARED_DEPENDENCIES)
	$(LIBTOOL) --tag=CC --mode=link $(CC) -shared $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS) $(LDFLAGS)  -o $@ -export-dynamic -avoid-version -prefer-pic -module -rpath $(phplibdir) $(EXTRA_LDFLAGS) $(shared_objects_rar) $(RAR_SHARED_LIBADD)

