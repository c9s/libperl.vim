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

thub.com/$(1)/$(2)/raw/$(3)/$(4) -o $(5)      \
		; elif [[ ! -z `which wget` ]] ; then                               \
			wget $(WGET_OPT) http://github.com/$(1)/$(2)/raw/$(3)/$(4) -O $(5)  \
		; fi									\
		; echo $(5) >> .bundlefiles

# fetch script from local file
fetch_local = @cp -v $(1) $(2) \
		; @echo $(2) >> .bundlefiles

# 1: NAME , 2: URI
dep_from_git = \
		D=/tmp/$(1)-$$RANDOM ; git clone $(2) $$D ; cd $$D ; make install ; 

dep_from_svn = \
		D=/tmp/$(1)-$$RANDOM ; svn checkout $(2) $$D ; cd $$D ; make install ;

# }}}
# }}}
# ======= DEFAULT CONFIG ======= {{{

# Default plugin name
NAME=`basename \`pwd\``
VERSION=0.1

# Files to add to tarball:
DIRS=`ls -1F | grep / | sed -e 's/\///'`

# Runtime path to install:
VIMRUNTIME=~/.vim

# Other Files to be added:
FILES=`ls -1 | grep '.vim$$'`
MKFILES=Makefile `ls -1 | grep '.mk$$'`

# ======== USER CONFIG ======= {{{
#   please write config in config.mk
#   this will override default config
#
# Custom Name:
#
# 	NAME=[plugin name]
#
# Custom dir list:
#
# 	DIRS=autoload after doc syntax plugin 
#
# Files to add to tarball:
#
# 	FILES=
# 
# Bundle dependent scripts:
#
# 	bundle-deps:
# 	  $(call fetch_github,[account id],[project],[branch],[source path],[target path])
# 	  $(call fetch_url,[file url],[target path])
# 	  $(call fetch_local,[from],[to])

SHELL=bash

CONFIG_FILE=config.mk
-include ~/.vimauthor.mk
-include $(CONFIG_FILE)

# }}}
# }}}
# ======= SECTIONS ======= {{{
-include ext.mk

all: install


check-require:
	@if [[ -n `which wget` || -n `which curl` || -n `which fetch` ]]; then echo "wget|curl|fetch: OK" ; else echo "wget|curl|fetch: NOT OK" ; fi
	@if [[ -n `which vim` ]] ; then echo "vim: OK" ; else echo "vim: NOT OK" ; fi


config:
	@rm -f $(CONFIG_FILE)
	@echo "NAME="                                                                                      >> $(CONFIG_FILE)
	@echo "VERSION="                                                                                           >> $(CONFIG_FILE)
	@echo "#DIRS="
	@echo "#FILES="
	@echo ""                                                                                           >> $(CONFIG_FILE)
	@echo "bundle-deps:"                                                                               >> $(CONFIG_FILE)
	@echo "\t\t\$$(call fetch_github,ID,REPOSITORY,BRANCH,PATH,TARGET_PATH)" >> $(CONFIG_FILE)
	@echo "\t\t\$$(call fetch_url,FILE_URL,TARGET_PATH)"                                           >> $(CONFIG_FILE)


init-author:
	@echo "AUTHOR=" > ~/.vimauthor.mk

bundle-deps:

bundle: bundle-deps

dist: bundle mkfilelist
	@$(TAR) $(NAME)-$(VERSION).tar.gz --exclude '*.svn' --exclude '.git' $(DIRS) $(README_FILES) $(FILES) $(MKFILES)
	@echo "$(NAME)-$(VERSION).tar.gz is ready."

init-runtime:
	@mkdir -vp $(VIMRUNTIME)
	@mkdir -vp $(VIMRUNTIME)/record
	@if [[ -n "$(DIRS)" ]] ; then find $(DIRS) -type d | while read dir ;  do \
			mkdir -vp $(VIMRUNTIME)/$$dir ; done ; fi

release:
	if [[ -n `which vimup` ]] ; then \
	fi

pure-install:
	@echo "Using Shell:" $(SHELL) 
	@echo "Installing"
	@if [[ -n "$(DIRS)" ]] ; then find $(DIRS) -type f | while read file ; do \
			cp -v $$file $(VIMRUNTIME)/$$file ; done ; fi
	@echo "$(FILES)" | while read vimfile ; do \
		if [[ -n $$vimfile ]] ; then \
			$(call install_file,$$vimfile) ; fi ; done

install: init-runtime bundle pure-install record


uninstall-files:
	@echo "Uninstalling"
	@if [[ -n "$(DIRS)" ]] ; then find $(DIRS) -type f | while read file ; do \
			rm -fv $(VIMRUNTIME)/$$file ; done ; fi
	@echo "$(FILES)" | while read vimfile ; do \
		if [[ -n $$vimfile ]] ; then \
			$(call unlink_file,$$vimfile) ; fi ; done

uninstall: uninstall-files rmrecord

link: init-runtime
	@echo "Linking"
	@if [[ -n "$(DIRS)" ]]; then find $(DIRS) -type f | while read file ; do \
			ln -sfv $(PWD)/$$file $(VIMRUNTIME)/$$file ; done ; fi
	@echo "$(FILES)" | while read vimfile ; do \
		if [[ -n $$vimfile ]] ; then \
			$(call link_file,$$vimfile) ; fi ; done

mkfilelist:
	@echo $(NAME) > $(RECORD_FILE)
	@echo $(VERSION) >> $(RECORD_FILE)
	@if [[ -n "$(DIRS)" ]] ; then find $(DIRS) -type f | while read file ; do \
			echo $(VIMRUNTIME)/$$file >> $(RECORD_FILE) ; done ; fi
	@echo "$(FILES)" | while read vimfile ; do \
		if [[ -n $$vimfile ]] ; then \
			$(call record_file,$$vimfile,$(RECORD_FILE)) ; fi ; done

vimball-edit:
	find $(DIRS) -type f > .tmp_list
	vim .tmp_list
	vim .tmp_list -c ":MkVimball $(NAME)-$(VERSION)" -c "q"
	@rm -vf .tmp_list
	@echo "$(NAME)-$(VERSION).vba is ready."

vimball:
	find $(DIRS) -type f > .tmp_list
	vim .tmp_list -c ":MkVimball $(NAME)-$(VERSION)" -c "q"
	@rm -vf .tmp_list
	@echo "$(NAME)-$(VERSION).vba is ready."

mkrecordscript:
		@echo ""  >  $(RECORD_SCRIPT)
		@echo "fun! s:mkmd5(file)"  >> $(RECORD_SCRIPT)
		@echo "  if executable('md5')"  >> $(RECORD_SCRIPT)
		@echo "    return system('cat ' . a:file . ' | md5')"  >> $(RECORD_SCRIPT)
		@echo "  else"  >> $(RECORD_SCRIPT)
		@echo "    return \"\""  >> $(RECORD_SCRIPT)
		@echo "  endif"  >> $(RECORD_SCRIPT)
		@echo "endf"  >> $(RECORD_SCRIPT)
		@echo "let files = readfile('.record')"  >> $(RECORD_SCRIPT)
		@echo "let package_name = remove(files,0)"  >> $(RECORD_SCRIPT)
		@echo "let script_version      = remove(files,0)"  >> $(RECORD_SCRIPT)
		@echo "let record = { 'version' : 0.3 , 'generated_by': 'Vim-Makefile' , 'script_version': script_version , 'install_type' : 'makefile' , 'package' : package_name , 'files': [  ] }"  >> $(RECORD_SCRIPT)
		@echo "for file in files "  >> $(RECORD_SCRIPT)
		@echo "  let md5 = s:mkmd5(file)"  >> $(RECORD_SCRIPT)
		@echo "  cal add( record.files , {  'checksum': md5 , 'file': file  } )"  >> $(RECORD_SCRIPT)
		@echo "endfor"  >> $(RECORD_SCRIPT)
		@echo "redir => output"  >> $(RECORD_SCRIPT)
		@echo "silent echon record"  >> $(RECORD_SCRIPT)
		@echo "redir END"  >> $(RECORD_SCRIPT)
		@echo "let content = join(split(output,\"\\\\n\"),'')"  >> $(RECORD_SCRIPT)
		@echo "let record_file = expand('~/.vim/record/' . package_name )"  >> $(RECORD_SCRIPT)
		@echo "cal writefile( [content] , record_file )"  >> $(RECORD_SCRIPT)
		@echo "echo \"Done\""  >> $(RECORD_SCRIPT)


record: mkfilelist mkrecordscript
	vim --noplugin -V10install.log -c "so $(RECORD_SCRIPT)" -c "q"
	@echo "Vim script record making log: install.log"

rmrecord:
	@echo "Removing Record"
	@rm -vf $(VIMRUNTIME)/record/$(NAME)

clean: clean-bundle-deps
	@rm -vf $(RECORD_FILE)
	@rm -vf $(RECORD_SCRIPT)
	@rm -vf install.log
	@rm -vf *.tar.gz

clean-bundle-deps:
	@echo "Removing Bundled scripts..."
	@if [[ -e .bundlefiles ]] ; then \
		rm -fv `echo \`cat .bundlefiles\``; \
	fi
	@rm -fv .bundlefiles

update:
	@echo "Updating Makefile..."
	@URL=http://github.com/c9s/vim-makefile/raw/master/Makefile ; \
	if [[ -n `which curl` ]]; then \
		curl $$URL -o Makefile ; \
	if [[ -n `which wget` ]]; then \
		wget -c $$URL ; \
	elif [[ -n `which fetch` ]]; then \
		fetch $$URL ; \
	fi

version:
	@echo version - $(MAKEFILE_VERSION)

# }}}
