if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect
  " TrialPay specific
  "autocmd BufRead,BufNewFile *.tp setfiletype php
  "autocmd BufRead,BufNewFile *.tpt setfiletype php.html

  autocmd BufRead,BufNewFile *.php setfiletype php.html
  autocmd BufRead,BufNewFile *bash* let b:is_bash = 1 | setfiletype sh
  autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
augroup end
