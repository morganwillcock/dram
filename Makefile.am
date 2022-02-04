bin_SCRIPTS = dram

EXTRA_DIST = README LICENSE source/README.org $(TESTS) tests/setup

CLEANFILES = $(bin_SCRIPTS)

TEST_LOG_DRIVER = env AM_TAP_AWK='$(AWK)' \
	$(SHELL) $(top_srcdir)/build-aux/tap-driver.sh

dram: $(srcdir)/source/dram
	"$(AWK)" 'FNR==1 { $$1 = "#!$(AWK_INTERP)" } { print }'	\
	    $(srcdir)/source/dram > $@.tmp
	chmod +x $@.tmp
	mv $@.tmp $@

README: $(srcdir)/source/README.org $(srcdir)/source/dram $(top_srcdir)/configure.ac
	$(MAKE) $(AM_MAKEFLAGS) dram
	command -v python2
	command -v python3
	command -v tclsh
	$(EMACS) --batch --quick \
	    --load=org --load=ox --load=ob-shell \
	    --file=source/README.org \
	    --eval "(setq dram-version \"$(PACKAGE_VERSION)\")" \
	    --eval "(org-babel-tangle)" \
	    --eval "(setq org-confirm-babel-evaluate \
	              (lambda (lang body) \
	                (not (member lang '(\"emacs-lisp\" \"sh\")))))" \
	    --eval "(org-babel-execute-buffer)" \
	    --eval "(org-export-to-file 'ascii \"../$@\")"

dist-hook: README

clean-local:
	find tests -name "*.test.*" -exec rm '{}' \;
	find source -name "*.md" -exec rm '{}' \;
	find source \( -name "*.org" ! -name README.org \) -exec rm '{}' \;
