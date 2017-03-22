# vimpin
---------
![build status](https://travis-ci.org/j-c-w/vimpin.svg?branch=master)

This is a plugin for vim that allows you to pin some lines to the top of the screen.

# Intsall

Install using Vundle by adding the following to your `.vimrc`:

    Bundle 'j-c-w/vimpin'
    :BundleInstall

# Setup (Recommended)

Map the following command:

    " Pin toggling:
	nnoremap <leader>p :<C-U>PinToggle(v:count)<CR>

Then press `N<leader>p` to open an `N` line pin, and 
`<leader>p` to close this pin.



# Setup (for multiple simultaneous pins)

Map the following (with the keybindings as you wish):

    " Opening pins
    nnoremap <leader>o :<C-U>PinOpen(v:count)<CR>
    " Closing pins
    nnoremap <leader>c :PinClose<CR>


And optionally:

    " Closing all pins
    nnoremap <leader><leader>c :PinCloseAll<CR>
    " Closing nth pin:
    nnoremap <leader><leader>n :<C-U>PinCloseN(v:count)<CR>


# Use

Vimpin keeps a stack of pins that have been opened. They open
from the top of the screen downwards.

Closing a pin closes the most recently opened pin.

# Example

![demo](https://raw.githubusercontent.com/wiki/j-c-w/vimpin/demo.gif)
