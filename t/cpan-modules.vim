" include unit test library functions
cal ut#init()
cal ut#list_ok( [ 1 , 2 , 3 ] )

runtime vimlib/autoload/libperl.vim

cal ut#list_ok( libperl#get_cpan_module_list(0) )
cal ut#list_ok( libperl#get_cpan_module_list(1) )
" cal ut#list_ok( libperl#get_cpan_installed_module_list(1) )
" echo libperl#get_cpan_installed_module_list(0)
cal ut#list_ok( libperl#get_currentlib_cpan_module_list(1) )
cal ut#list_ok( libperl#get_currentlib_cpan_module_list(1) )
cal ut#list_ok( libperl#get_path_module_list( expand('~/work/rc/lib') , 1 ) )
echo 'done'
