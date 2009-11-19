# VIM::Packager::MakeMaker
#
# This Makefile is generated by VIM::Packager::MakeMaker version $VERSION from
# the contents of META . don't edit this file, edit META file instead.
#
# Author: Cornelius
# Email : cornelius.howl@gmail.com
# 




# -------- meta section ------
REPOSITORY = git://....../
VERSION = 0.6
NAME = libperl.vim
AUTHOR = Cornelius
VERSION_FROM = vimlib/autoload/libperl.vim
EMAIL = cornelius.howl@gmail.com
TYPE = autoload
SCRIPT_ID = 2824
DISTNAME = libperl-vim-0.6
VIM_VERSION = 7.2




# -------- config section ------
CHMOD = chmod
CP = cp
ECHO = echo
ECHO_N = echo -n
FALSE = false
FIRST_MAKEFILE = Makefile
FULLPERL = /opt/local/bin/perl
LN_S = ln -sv
LN_SF = ln -svf
MAKEFILE_OLD = Makefile.old
META_FILE = META
MV = mv
NOECHO = @
NOOP = $(TRUE)
PERLFLAGS =  -Ilib 
PWD = `pwd`
README = 
RM_F = rm -vf
RM_RF = rm -rf
TAR = COPY_EXTENDED_ATTRIBUTES_DISABLE=1 COPYFILE_DISABLE=1 tar
TARFLAGS = cvzf
TEST_F = test -f
TOUCH = touch
TRUE = true
VIM_AFTERBASE_DIR = /Users/c9s/.vim/after
VIM_AFTER_AFTER_DIR = /Users/c9s/.vim/after
VIM_AFTER_COLORS_DIR = /Users/c9s/.vim/colors
VIM_AFTER_COMPILER_DIR = /Users/c9s/.vim/compiler
VIM_AFTER_DIR = /Users/c9s/.vim/after
VIM_AFTER_FTPLUGIN_DIR = /Users/c9s/.vim/ftplugin
VIM_AFTER_MACROS_DIR = /Users/c9s/.vim/macros
VIM_AFTER_PLUGIN_DIR = /Users/c9s/.vim/plugin
VIM_AFTER_SYNTAX_DIR = /Users/c9s/.vim/syntax
VIM_BASEDIR = /Users/c9s/.vim
VIM_COLORS_DIR = /Users/c9s/.vim/colors
VIM_COMPILER_DIR = /Users/c9s/.vim/compiler
VIM_FTPLUGIN_DIR = /Users/c9s/.vim/ftplugin
VIM_MACROS_DIR = /Users/c9s/.vim/macros
VIM_PLUGIN_DIR = /Users/c9s/.vim/plugin
VIM_SYNTAX_DIR = /Users/c9s/.vim/syntax




# -------- file section ------
VIMLIB = vimlib
VIMMETA = META
TO_INST_VIMS = vimlib/doc/libperl.vim.txt \
	vimlib/autoload/libperl.vim
VIMS_TO_RUNT = vimlib/doc/libperl.vim.txt \
	$(VIM_BASEDIR)/doc/libperl.vim.txt \
	vimlib/autoload/libperl.vim \
	$(VIM_BASEDIR)/autoload/libperl.vim




# -------- main section ------
.PHONY: all install clean uninstall help upload link

all : install-deps
		$(NOECHO) $(NOOP)

install : pure_install install-deps
		$(NOECHO) $(NOOP)

pure_install : 
		$(NOECHO) $(FULLPERL) $(PERLFLAGS) -MVIM::Packager::Installer=install -e 'install()' $(NAME) $(VIMS_TO_RUNT) $(BIN_TO_RUNT)

install-deps : 

link : 
		$(NOECHO) $(LN_S) $(PWD)/vimlib/doc/libperl.vim.txt $(VIM_BASEDIR)/doc/libperl.vim.txt
		$(NOECHO) $(LN_S) $(PWD)/vimlib/autoload/libperl.vim $(VIM_BASEDIR)/autoload/libperl.vim

link-force : 
		$(NOECHO) $(LN_SF) $(PWD)/vimlib/doc/libperl.vim.txt $(VIM_BASEDIR)/doc/libperl.vim.txt
		$(NOECHO) $(LN_SF) $(PWD)/vimlib/autoload/libperl.vim $(VIM_BASEDIR)/autoload/libperl.vim

unlink : 
		$(NOECHO) $(RM) $(VIM_BASEDIR)/doc/libperl.vim.txt
		$(NOECHO) $(RM) $(VIM_BASEDIR)/autoload/libperl.vim

manifest : 
		$(FULLPERL) $(PERLFLAGS) -MVIM::Packager::Manifest=mkmanifest -e 'mkmanifest'
		$(NOECHO) $(TOUCH) MANIFEST.SKIP

dist : 
		$(TAR) $(TARFLAGS) $(DISTNAME).tar.gz $(TO_INST_VIMS) $(META_FILE) $(README)
		$(NOECHO) $(NOOP)

help : 
		perldoc VIM::Packager

uninstall : 
		$(NOECHO) $(FULLPERL) $(PERLFLAGS) -MVIM::Packager::Installer=uninstall   -e 'uninstall()' $(NAME)

upload : dist
		$(FULLPERL) $(PERLFLAGS) -MVIM::Packager::Uploader=upload -e 'upload()' $(PWD)/$(DISTNAME).tar.gz \
	$(VIM_VERSION) \
	$(VERSION) \
	$(SCRIPT_ID)

clean : 
		$(MV) $(FIRST_MAKEFILE) $(MAKEFILE_OLD)
		$(RM) *.tar.gz

