" vim:fdm=syntax:fdl=0:
"
" libperl.vim
"    standard vim functions for perl code
"
" Author: Cornelius (c9s) (Yo-An Lin)
" Web:    http://oulixe.us
" Github: http://github.com/c9s
" Mail:   cornelius.howl@DELETE-ME.gmail.com
"

let g:libperl#lib_version = 0.3
let g:libperl#pkg_token_pattern = '\w[a-zA-Z0-9:_]\+'


" libperl#echo:
"   @msg[String]:
"
fun! libperl#echo(msg)
  redraw
  echomsg a:msg
endf

" libperl#get_perl_lib_paths:
"   @return[List]:
"       return paths from perl @INC 
"
fun! libperl#get_perl_lib_paths()
  return split( system('perl -e ''print join "\n",@INC''') , "\n" ) 
endf

" libperl#get_module_file_path:
"   @mod[String]: package name
"   
"   @return[String: package file path
"
fun! libperl#get_module_file_path(mod)
  let paths = libperl#get_perl_lib_paths()
  let fname = libperl#translate_module_name( a:mod )
  call insert(paths,'lib/')
  for p in paths
    let fullpath = p . '/' . fname
    if filereadable( fullpath ) 
      return fullpath
    endif
  endfor
  return 
endf


" libperl#tab_open_module_file_in_paths(mod)
"
"
fun! libperl#tab_open_module_file_in_paths(mod)
  let paths = libperl#get_perl_lib_paths()
  let fname = libperl#translate_module_name( a:mod )
  let methodname = libperl#get_cursor_method_name()
  let path = libperl#get_module_file_path( a:mod )
  if filereadable( path ) 
    call libperl#edit_file( path , methodname ) 
  endif
endf

fun! libperl#tab_open_tag(tag)
  let list = taglist( a:tag )
  if len(list) == 1 | exec 'tab tag ' . a:tag
  else | exec 'tab ts ' . a:tag | endif
endf

" translate module name to file path
fun! libperl#translate_module_name(n)
  return substitute( a:n , '::' , '/' , 'g' ) . '.pm'
endf

fun! libperl#open_tag(tag)
  resize 60 
  let list = taglist( a:tag )
  if len(list) == 1 | exec ' tag ' . a:tag
  else | exec ' ts ' . a:tag | endif
endf

fun! libperl#open_module()
  if g:cpan_win_type == 'v'
    vertical resize 98
  else
    resize 60
  endif
  call libperl#open_module_in_paths( getline('.') )
endf

fun! libperl#get_cursor_module_name()
  return matchstr( expand("<cWORD>") , g:libperl#pkg_token_pattern )
endf

fun! libperl#get_cursor_method_name()
  let cw = expand("<cWORD>")
  let m = substitute( cw , '.\{-}\([a-zA-Z0-9_:]\+\)->\(\w\+\).*$' , '\2' , '' )
  if m != cw 
    return m
  endif
  return
endf


fun! libperl#find_method(method_name)
  call search( 'sub\s\+\<' . a:method_name . '\>','',0)
endf

fun! libperl#edit_file(fullpath,method)
  execute ':e ' . a:fullpath
  if strlen(a:method) > 0
    cal libperl#find_method(a:method)
  endif
  return 1
endf

fun! libperl#tab_open_module_from_cursor()
  call libperl#tab_open_module_file_in_paths( libperl#get_cursor_module_name() )
endf

fun! libperl#open_module_in_paths(mod)
  let paths = libperl#get_perl_lib_paths()
  let fname = libperl#translate_module_name( a:mod )
  let methodname = libperl#get_cursor_method_name()
  call insert(paths, 'lib/' )
  for p in paths 
    let fullpath = p . '/' . fname
    if filereadable( fullpath ) && libperl#edit_file( fullpath , methodname ) 
      return
    endif
  endfor
  echomsg "No such module: " . a:mod
endf

fun! libperl#get_inc()
  return system('perl -e ''print join(" ",@INC)'' ')
endf

fun! libperl#find_perl_package_files()
  let paths = 'lib ' .  libperl#get_inc()
  let pkgs = split("\n" , system(  'find ' . paths . ' -type f -iname *.pm ' 
        \ . " | xargs -I{} egrep -o 'package [_a-zA-Z0-9:]+;' {} "
        \ . " | perl -pe 's/^package (.*?);/\$1/' "
        \ . " | sort | uniq " )
  return pkgs
endf

" please defined g:cpan_install_command to install module 
fun! libperl#install_module()
  exec '!' . g:cpan_install_command . ' ' . libperl#get_cursor_module_name()
endf

fun! libperl#get_package_sourcelist_path()
  let paths = [ 
        \expand('~/.cpanplus/02packages.details.txt.gz'),
        \expand('~/.cpan/sources/modules/02packages.details.txt.gz')
        \]
  if exists('g:cpan_user_defined_sources')
    call extend( paths , g:cpan_user_defined_sources )
  endif

  for f in paths 
    if filereadable( f ) 
      return f
    endif
  endfor
  return
endf


" return a list , each item contains two items : [ class , file ].
fun! libperl#find_base_classes(file)
  let script_path = expand('$HOME') . '/.vim/bin/find_base_classes.pl'
  if ! filereadable( script_path )
    echoerr 'can not read ' . script_path
    return [ ]
  endif
  let out = system('perl ' . script_path . ' ' . a:file)
  let classes = [ ]
  for l in split(out,"\n") 
    let [class,refer,path] = split(l,' ')
    call add(classes,[class,refer,path])
  endfor
  return classes
endf

" XXX: Try PPI
fun! libperl#grep_file_functions(file)
  let out = system('grep -oP "(?<=^sub )\w+" ' . a:file )
  return split( out , "\n" )
endf

fun! libperl#parse_base_class_functions(filepath)
  let base_classes = libperl#find_base_classes( a:filepath ) 
  let result = [ ]
  for [class,class_refer,path] in base_classes
    let class_comp = { 'class': class , 'refer': class_refer , 'functions': [ ] }
    let class_comp.functions = libperl#grep_file_functions( path )
    call add( result , class_comp )
  endfor
  return result
endf

" Data::Dumper->something
" $self->something
" Jifty->
" Jifty->a

" should get the start postion of something like Data::Dumper and $self
fun! libperl#get_method_comp_refer_start()
  return searchpos( '\S\+\(->\)\@='  , 'bn' , line('.') )
endf

" should return something like 'Data::Dumper' and '$self'
fun! libperl#get_method_comp_refer_base()
  let start = libperl#get_method_comp_refer_start()
  let end = libperl#get_method_comp_start()
  if start[0] == 0 && start[1] == 0
    return ""
  endif
  return strpart( getline('.') , start[1] - 1 , end[1] - 2 - start[1] )
endf

fun! libperl#get_method_comp_start()
  let pos = searchpos( '->'  , 'bn' , line('.') )
  let pos[1] += 2
  return pos
endf

fun! libperl#get_method_comp_base()
  let [lnum,coln] = libperl#get_method_comp_start()
  if lnum == 0 && coln == 0
    return ""
  endif
  return strpart( getline('.') , coln - 1 , col('.') - coln + 1 )
endf

fun! libperl#clear_method_comp_base()
  let [numl,coln] = libperl#get_method_comp_start()
  let new = strpart( getline('.') , 0 , coln - 1 )
  call setline( line('.') , new )
endf

" return [ lnum , col ]
fun! libperl#get_pkg_comp_start()
  return searchpos( '[^a-zA-Z0-9:_]' , 'bn' , line('.') )
endf


" return package completion base string
" for example:   Catalyst::...
fun! libperl#get_pkg_comp_base()
  let col = col('.')
  let [ lnum , coln ] = libperl#get_pkg_comp_start()
  let line = getline('.')
  return strpart( getline('.') , coln , col )
endf

" echo libperl#use_ok('Data::Dumper')
fun! libperl#use_ok(pkg)
  let cmd = "perl -M" . a:pkg . ' -e "print q{OK}"'
  let out = system( cmd )
  return out == 'OK'
endf

" if vim compiled with perl


" Return: cpan module list [list]
fun! libperl#get_cpan_module_list(force)
  if ! filereadable( g:cpan_source_cache ) && IsExpired( g:cpan_source_cache , g:cpan_cache_expiry  ) || a:force
    let path =  libperl#get_package_sourcelist_path()
    cal libperl#echo("executing zcat: " . path )
    cal system('zcat ' . path . " | grep -v '^[0-9a-zA-Z-]*: '  | cut -d' ' -f1 > " . g:cpan_source_cache )
    cal libperl#echo("cached.")
  endif
  return readfile( g:cpan_source_cache )
endf

" Return: installed cpan module list [list]
fun! libperl#get_installed_cpan_module_list(force)
  if ! filereadable( g:cpan_installed_cache ) && IsExpired( g:cpan_installed_cache , g:cpan_cache_expiry ) || a:force
    let paths = 'lib ' .  system('perl -e ''print join(" ",@INC)''  ')
    call libperl#echo("finding packages from @INC... This might take a while. Press Ctrl-C to stop.")
    call system( 'find ' . paths . ' -type f -iname "*.pm" ' 
          \ . " | xargs -I{} head {} | egrep -o 'package [_a-zA-Z0-9:]+;' "
          \ . " | perl -pe 's/^package (.*?);/\$1/' "
          \ . " | sort | uniq > " . g:cpan_installed_cache )
    " sed  's/^package //' | sed 's/;$//'
    call libperl#echo("ready")
  endif
  return readfile( g:cpan_installed_cache )
endf

" Return: current lib/ cpan module list [list]
fun! libperl#get_currentlib_cpan_module_list(force)
  let cpan_curlib_cache = expand( '~/.vim/' . tolower( substitute( getcwd() , '/' , '.' , 'g') ) )
  if ! filereadable( cpan_curlib_cache ) && IsExpired( cpan_curlib_cache , g:cpan_cache_expiry ) || a:force
    call libperl#echo( "finding packages... from lib/" )

    if exists('use_pcre_grep') 
      call system( 'find lib -type f -iname "*.pm" ' 
          \ . " | xargs -I{} grep -Po '(?<=package) [_a-zA-Z0-9:]+' {} "
          \ . " | sort | uniq > " . cpan_curlib_cache )
    else
      call system( 'find lib -type f -iname "*.pm" ' 
          \ . " | xargs -I{} egrep -o 'package [_a-zA-Z0-9:]+;' {} "
          \ . " | perl -pe 's/^package (.*?);/\$1/' "
          \ . " | sort | uniq > " . cpan_curlib_cache )
    endif

    call libperl#echo('cached')
  endif
  return readfile( cpan_curlib_cache )
endf
