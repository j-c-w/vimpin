" This stores the number of pins currently open.
let g:PinStack = 0

" Open a new window with the specified lines:
function! PinOpen(n)
	" Generate a new name for the pin buffer
	let l:BuffName = s:NameGen(g:PinStack)
	let g:PinStack += 1
	" Gets the position so that it can be set.
	let l:Position = getpos('.')
	" Save the buffer before overwriting
	let AContents = @a
	let @a = ""
	call setpos('.', l:Position)
	" Yanks the lines to go in the buffer
	execute "normal! " . a:n . "\"ayy"
	" Now creates the newly named byffer
	execute "new " . l:BuffName
	" Paste and format
	execute "normal! \"apkdd"
	" Set the right height
	execute "normal! " . a:n . "_"
	" Also store the buffer height in the window
	" so it can be reset whenever it needs to be
	let b:BufferHeight = a:n
	execute "set wfh"
	" and swap back to the buffer we were in before
	:normal! j
	" Finally, reset the contents of @a
	let @a = AContents
	" And reset heights of the windows that may have been changed up
	call s:ResizeWindows()
endfunction

" This creates a name for the buffer that 
" corresponds to the ones wer are keeping track of
function! s:NameGen(num)
	return "Pin" . a:num
endfunction

" Note that this function doess not keep track of
" the pin stack. It takes a name and closes it
" by that
function! s:ClosePinByName(name)
	let l:Found = 0

	for l:BufName in range(1, bufnr('$'))
		if bufloaded(l:BufName) && bufname(l:BufName) ==# a:name
			" This is the buffer we are after
			let l:Found = 1
			" And get the window number of the current buffer
			let l:CloseWindowNum = bufwinnr(l:BufName)
			let l:CloseBufferNum = bufnr(l:BufName)
			" Swtich and do the closing
			execute "bd! " . l:CloseBufferNum
		endif
	endfor
	call s:ResizeWindows()
	return l:Found
endfunction

function! s:ResizeWindows() 
	let l:CurrentWindow = winnr()
	" Now resize the buffers where appropriate:
	for l:BufName in range(1, bufnr('$'))
		if bufloaded(l:BufName) && exists("b:BufferHeight")
			" Then resize the buffer:
			echo "win num " . l:WindowNum . " is a pin"
			let l:WindowNum = bufwinnr(l:BufName)
			execute l:WindowNum . "wincmd m"
			execute "normal! " . b:BufferHeight "_"
		endif
	endfor

	" And go back to the original buffer
	execute l:CurrentWindow . "wincmd m"
endfunction

" This is just a wrapper funciton for pin close by name.
" closes the function by a given number
function! ClosePinByNumber(number) 
	return s:ClosePinByName(s:NameGen(a:number))
endfunction

" This takes the top
" pin and closes it.
" It closes the first pin it finds
function! PinClose()
	let l:Found = 0
	while g:PinStack > 0 && !l:Found
		let g:PinStack -= 1
		let l:Found = ClosePinByNumber(g:PinStack)
	endwhile
endfunction

function! PinCloseAll()
	while g:PinStack > 0
		let g:PinStack -= 1
		call ClosePinByNumber(g:PinStack)
	endwhile
endfunction

" Now, using these functions, we create 
" these commands:
command! -nargs=1 PinOpen call PinOpen(<args>)
command! -nargs=1 PinCloseN call ClosePinByNumber(<args>)
command! PinClose call PinClose()
command! PinCloseAll call PinCloseAll()
