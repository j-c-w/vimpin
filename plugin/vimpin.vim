" This stores the number of pins currently open.
let g:PinStack = 0

" Open a new window with the specified lines:
function PinOpen(n)
	" Generate a new name for the pin buffer
	let l:BuffName = s:NameGen(g:PinStack)
	g:PinStack += 1
	" Save the buffer before overwriting
	let AContents = @a
	" Yanks the lines to go in the buffer
	echo a:n
	execute "normal! " . a:n . "\"ayy"
	" Now creates the newly named byffer
	execute "new " . l:BuffName
	" Paste and format
	execute "normal! \"ap"
	" Set the right height
	execute "normal! " . a:n . "_"
	" and swap back to the buffer we were in before
	:normal! j
	" Finally, reset the contents of @a
	" let @a = AContents
endfunction

" This creates a name for the buffer that 
" corresponds to the ones wer are keeping track of
function s:NameGen(num)
	return "Pin" . a:num
endfunction

" Note that this function doess not keep track of
" the pin stack. It takes a name and closes it
" by that
function s:ClosePinByName(name)
	let l:Buffers = range(1, bufnr('$'))
	let l:Found = 0

	for l:BufName in l:Buffers
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

	return l:Found
endfunction

" This is just a wrapper funciton for pin close by name.
" closes the function by a given number
function ClosePinByNumber(number) 
	return s:ClosePinByName(s:NameGen(a:number))
endfunction

" This takes the top
" pin and closes it.
" It closes the first pin it finds
function PinClose()
	let l:Found = 0
	while g:PinStack >= 0 && !l:Found
		l:Found = ClosePinByNumber(g:PinStack)
		g:PinStack -= 1
	endwhile
endfunction

" Now, using these functions, we create 
" these commands:
command! -nargs=1 PinOpen call PinOpen(<args>)
command! -nargs=1 PinCloseN call ClosePinByNumber(<args>)
command! PinClose call PinClose()
