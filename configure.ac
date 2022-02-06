AC_PREREQ([2.71])
AC_INIT([dram], [1.1])
AC_CONFIG_AUX_DIR([build-aux])
AC_REQUIRE_AUX_FILE([tap-driver.sh])
AM_INIT_AUTOMAKE([-Werror -Wall foreign subdir-objects])

# Find an Emacs for optional documentation build
AM_PATH_LISPDIR

# Find an Awk to build with
AC_PROG_AWK

# Specify interpreter to use as precious variable
AC_ARG_VAR([AWK_INTERP],
    [the path to the Awk to use as the script interpreter])

# Find an Awk to use an interpreter within the script
AS_IF([test "x${AWK_INTERP}" = x],
    [AC_PATH_PROGS([AWK_INTERP], [gawk mawk nawk awk])])

# Fail if no interpreter is set
AS_IF([test "x${AWK_INTERP}" = x],
    [AC_MSG_ERROR([could not find an Awk])])

AC_CONFIG_LINKS([source/dram:source/dram])
AC_CONFIG_LINKS([LICENSE:LICENSE])
AC_CONFIG_SRCDIR([source/dram])
AC_CONFIG_FILES([Makefile])

# Link tests and setup test files variable
m4_define([TESTSCRIPT_LIST],
    [m4_normalize(m4_esyscmd([find tests -name '??-*.test' | sort]))])
m4_foreach_w([TEST_FILE], TESTSCRIPT_LIST,
    [AC_CONFIG_LINKS(TEST_FILE:TEST_FILE)])
AC_CONFIG_LINKS([tests/setup:tests/setup])
AC_SUBST([TESTS], ['TESTSCRIPT_LIST'])

AC_OUTPUT

cat << EOF

$PACKAGE_NAME $PACKAGE_VERSION

Interpreter will be '$AWK_INTERP' unless overridden.

EOF
