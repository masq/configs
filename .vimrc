" Masq's vimrc 9/17/2017

" Ensure vim doesn't act weird
set nocompatible

" Turn on syntax highlighting
syntax enable

" enable line numbering
set number

" highlight/underline current line
set cursorline

" Set a colorcolumn at 80 (know when to stop typing ish) and make it purple
set cc=80
highlight ColorColumn ctermbg=5

" Set tabs and such to 2, shiftround so that shifts will round to our shiftwidth
set shiftwidth=4 softtabstop=4 tabstop=4 shiftround

" Turn on autoindenting
set autoindent

" Make tabs act/be written out as spaces
"set expandtab

" Make vim better-colored for dark backgrounds
set background=dark

" Ensure lines don't wrap down, and just carry on forever
set nowrap

" Move current tab into the specified direction.
"
" @param direction -1 for left, 1 for right.
function! TabMove(direction)
    " get number of tab pages.
    let total_pages=tabpagenr("$")
    " move tab, if necessary.
    if total_pages > 0
        " get number of current tab page.
        let current_index=tabpagenr()
        " move left.
        if a:direction < 0 
          if current_index == 1
            let index=total_pages " move to the last
          else
            let index=a:direction " move by -1
          endif
        elseif a:direction > 0 
          if current_index == total_pages
            let index=0 " move tab forward to position 0
          else
            let index="+1" " move forward by 1
          endif
        endif

        " move tab page.
        execute "tabmove ".index
    endif
endfunction

nnoremap <silent> gr :call TabMove(-1)<CR>
nnoremap <silent> gy :call TabMove(1)<CR>

function! Paste_Func()
    let s:inPaste = &paste
    if !s:inPaste
        set paste
    endif

    echom s:inPaste
    augroup paste_callback
        autocmd!
        autocmd InsertLeave <buffer> call Paste_End()
    augroup END

    startinsert
endfunction

function! Paste_End()
    augroup paste_callback
        autocmd!
    augroup END
    augroup! paste_callback

    if !s:inPaste
        set nopaste
    endif
endfunction

nnoremap ; :call Paste_Func()<cr>

" Python specific coding
autocmd FileType py setlocal shiftwidth=4 tabstop=4 softtabstop=4 expandtab
autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4 expandtab

" Javascript module specific coding
au BufNewFile,BufRead *.mjs set syntax=javascript
