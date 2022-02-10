bin_SCRIPTS = dram

EXTRA_DIST = ChangeLog README LICENSE source/README.org $(TESTS) tests/setup

CLEANFILES = $(bin_SCRIPTS)

TEST_LOG_DRIVER = env AM_TAP_AWK='$(AWK)' \
	$(SHELL) $(top_srcdir)/build-aux/tap-driver.sh

dram: $(srcdir)/source/dram
	"$(AWK)" 'FNR==1 { $$1 = "#!$(AWK_INTERP)" } { print }'	\
	    $(srcdir)/source/dram > $@.tmp
	chmod +x $@.tmp
	mv $@.tmp $@

ChangeLog: $(srcdir)/source/README.org
	$(EMACS) --batch --quick \
	    --load=org --load=ox \
	    --file=$(srcdir)/source/README.org \
	    --eval "(setq dram-version \"$(PACKAGE_VERSION)\")" \
	    --eval "(cd \"$$(pwd)/source\")" \
	    --eval "(setq org-confirm-babel-evaluate \
	              (lambda (lang body) \
	                (not (member lang '(\"emacs-lisp\")))))" \
	    --eval "(org-id-goto \"54944074-2040-4250-8475-45827a054591\")" \
	    --eval "(org-babel-execute-subtree)" \
	    --eval "(org-id-goto \"3594bd9a-59c7-4a83-98f5-2531257ead3c\")" \
	    --eval "(org-export-to-file 'ascii \"../$@\" nil t)"

README: $(srcdir)/source/README.org $(srcdir)/source/dram $(top_srcdir)/configure.ac
	$(MAKE) $(AM_MAKEFLAGS) dram
	command -v python2
	command -v python3
	command -v tclsh
	$(EMACS) --batch --quick \
	    --load=org --load=ox --load=ob-shell \
	    --file=$(srcdir)/source/README.org \
	    --eval "(setq dram-version \"$(PACKAGE_VERSION)\")" \
	    --eval "(cd \"$$(pwd)/source\")" \
	    --eval "(org-babel-tangle)" \
	    --eval "(setq org-confirm-babel-evaluate \
	              (lambda (lang body) \
	                (not (member lang '(\"emacs-lisp\" \"sh\")))))" \
	    --eval "(org-babel-execute-buffer)" \
	    --eval "(org-export-to-file 'ascii \"../$@\")"

dist-hook: ChangeLog README

clean-local:
	find tests -name "*.test.*" -exec rm '{}' \;
	rm -rf source/tangled
