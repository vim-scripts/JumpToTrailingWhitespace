" JumpToTrailingWhitespace.vim: Motions to locate unwanted whitespace at the end of lines.
"
" DEPENDENCIES:
"   - CountJump.vim, CountJump/Motion.vim autoload scripts, version 1.70 or
"     higher
"   - ShowTrailingWhitespace.vim autoload script (optional)
"
" Copyright: (C) 2012 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"   1.10.003	17-Aug-2012	As the search obeys the 'wrapscan' setting, also
"				issue corresponding "trailing whitespace search
"				hit BOTTOM, continuing at TOP" wrap warning
"				messages. This requires the enhanced CountJump
"				plugin version 1.70.
"   1.01.002    28-Mar-2012     Change g:JumpToTrailingWhitespace_mapping to
"				g:JumpToTrailingWhitespace_Mapping.
"   1.00.001	07-Mar-2012	file creation

" Avoid installing twice or when in unsupported Vim version.
if exists('g:loaded_JumpToTrailingWhitespace') || (v:version < 700)
    finish
endif
let g:loaded_JumpToTrailingWhitespace = 1
let s:save_cpo = &cpo
set cpo&vim

"- configuration ---------------------------------------------------------------

if ! exists('g:JumpToTrailingWhitespace_Mapping')
    let g:JumpToTrailingWhitespace_Mapping = '$'
endif


"- functions -------------------------------------------------------------------
function! s:Pattern()
    let l:pattern = '\s\+$'

    " The ShowTrailingWhitespace plugin can define exceptions where whitespace
    " should be kept; use that knowledge if it is available.
    silent! let l:pattern = ShowTrailingWhitespace#Pattern(0)

    return l:pattern
endfunction

function! JumpToTrailingWhitespace#Forward( mode )
    call CountJump#CountJumpWithWrapMessage(a:mode, 'trailing whitespace search', s:Pattern(), '')
endfunction
function! JumpToTrailingWhitespace#Backward( mode )
    call CountJump#CountJumpWithWrapMessage(a:mode, 'trailing whitespace search', s:Pattern(), 'b')
endfunction


"- mappings --------------------------------------------------------------------

call CountJump#Motion#MakeBracketMotionWithJumpFunctions('', g:JumpToTrailingWhitespace_Mapping, '',
\   function('JumpToTrailingWhitespace#Forward'),
\   function('JumpToTrailingWhitespace#Backward'),
\   '', '', 0)

let &cpo = s:save_cpo
unlet s:save_cpo
" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
