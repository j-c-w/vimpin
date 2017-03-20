This is a plugin for vim that allows you to pin some lines to the top of the screen.

#Intsall
Install using Vundle by adding the following to your `.vimrc`:

> Bundle 'j-c-w/vimpin'
> :BundleInstall

#Setup

Map the following (with the keybindings as you wish):

> " Opening pins
> nnoremap <leader>o :<C-U>PinOpen(v:count)<CR>
> " Closing pins
> nnoremap <leader>c :PinClose<CR>


And optionally:
> " Closing all pins
> nnoremap <leader><leader>c :PinCloseAll<CR>
> " Closing nth pin:
> nnoremap <leader><leader>n :<C-U>PinCloseN(v:count)<CR>


#Use

Vimpin keeps a stack of pins that have been opened. They open
from the top of the screen downwards.

Closing a pin closes the most recently opened pin.

Example:

[demo] (https://raw.githubusercontent.com/wiki/j-c-w/vimpin/demo.gif)


