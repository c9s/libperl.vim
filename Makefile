
install:
	mkdir -p ~/.vim/autoload/
	cp autoload/libperl.vim  ~/.vim/autoload/


dist:
	tar cvf libperl.tar.gz  autoload/  Makefile

