# always_update_submodules

plugin "jshint", "https://github.com/wookiehangover/jshint.vim.git"

plugin "vim-ruby", "https://github.com/vim-ruby/vim-ruby.git"
plugin "ragtag", "git://github.com/tpope/vim-ragtag.git"
plugin "repeat", "git://github.com/tpope/vim-repeat.git"
plugin "liquid", "git://github.com/vim-ruby/vim-ruby.git"
plugin "ragel", "https://github.com/jayferd/ragel.vim.git"
plugin "scss", "https://github.com/cakebaker/scss-syntax.vim.git"
plugin "sinatra", "https://github.com/hallison/vim-ruby-sinatra.git"
plugin "less", "git://gist.github.com/369178.git"
plugin "camelcasemotion", "https://github.com/vim-scripts/camelcasemotion.git"
# plugin "zencoding", "https://github.com/mattn/zencoding-vim.git"
plugin "session", "https://github.com/vim-scripts/session.vim--Odding.git"
plugin "css-color", "https://github.com/ap/vim-css-color.git" do
  sh "cp after/syntax/{css,less}.vim"
  sh "cp after/syntax/{css,scss}.vim"
end
plugin "jasmine", "https://github.com/claco/jasmine.vim.git"


plugin "tabmerge" do
  mkdir_p "plugin"
  sh "curl 'http://www.vim.org/scripts/download_script.php?src_id=8828' > plugin/Tabmerge.vim"
end

plugin "html5", "git://github.com/othree/html5.vim.git"
plugin "html5-syntax", "git://github.com/othree/html5-syntax.vim.git"

plugin "lesscss", "git://gist.github.com/161047.git" do
  mkdir_p "syntax"
  cp "less.vim", "syntax"
end

plugin "copy-as-rtf", "git://github.com/aniero/vim-copy-as-rtf.git"

plugin "molokai" do
  mkdir_p "colors"
  sh "curl https://raw.github.com/mrtazz/molokai.vim/master/colors/molokai.vim > colors/molokai.vim"
  File.open("colors/molokai.vim", "a") do |f|
    f.puts <<-overrides
    hi SpecialComment  guifg=#6E858A               gui=bold
    hi Comment         guifg=#6E858A
    " Normal bg color is #1B1D1E, or in 256color, 233
    hi ColorColumn     guibg=#17191A " slightly darker
    " hi ColorColumn     guibg=#121414
    if &t_Co > 255
      hi ColorColumn ctermbg=232
    end
    overrides
  end
end

plugin "tomorrow-night", "https://github.com/ChrisKempson/Vim-Tomorrow-Theme.git"

plugin "nerdtree_command-t" do
  mkdir_p "after/plugin"
  File.open("after/plugin/nerdtree_command-t.vim", "w") do |f|
    f.puts <<-HACK
" NERDTree and Command-T compatibility hack
"
" Open an empty buffer and then start a real NERDTree, but only if
" vim was opened with a single directory as the first argument.
" The empty buffer gives command-t a buffer in which to open a
" file, rather than having it fail to clobber the default directory browser.
"
" This preserves the NERDTree netrw browsing replacement, but overrides it
" when vim is first loading.
"
" This script is in after/plugins since it needs to add the autocmd
" override after the plugin's autocmds are loaded and defined.

function ReplaceNERDTreeIfDirectory()
  if argc() == 0 || (argc() == 1 && isdirectory(argv(0)))
    " replace the directory browser with an empty buffer
    enew
    " and open a regular NERDTree instead
    NERDTree
  endif
endfunction

augroup NERDTreeHijackNetrw
  au VimEnter * call ReplaceNERDTreeIfDirectory()
augroup END
    HACK
  end
end

# disable formatoptions "o" to disallow comment continuation
# in various ftplugin that enable it
plugin "fo_minus_o" do
  mkdir_p "after/ftplugin"
  %w(ruby vim coffee gitconfig).each do |filetype|
    File.open("after/ftplugin/#{filetype}.vim", "w+") do |f|
      f.puts <<-vim
        setlocal formatoptions-=o
        if has('gui')
          " disable ri for ruby
          setlocal noballooneval
        endif
      vim
    end
  end
end
