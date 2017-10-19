" gvimrc is required since macmenu commands don't work anywhere else.
" Same for columns/lines.
if has("gui_macvim")
  " unmap macvim menu key so Cmd-L is available
  macmenu Tools.List\ Errors key=<nop>

  " unmap cmd-z for gundo to use
  macmenu Edit.Undo<Tab>u key=<nop>

  " size for main external displays
  set columns=147
  set lines=58
  " set macligatures
  set guifont=Fira\ Code\ Retina:h14,Menlo:h14

  " e - graphical tabs
  " c - use console dialogs instead of graphical windows
  " g - set inactive menu items grey
  " everything else disabled
  set guioptions=ecg

  " always show tabline for more predictable window sizes
  set showtabline=2
end
