Register-ArgumentCompleter -CommandName kubectl -Native -ScriptBlock {
    param($wordToComplete, $commandAst)
    
    # kubectl <wordToComplete>
    if ($commandAst -notmatch "^kubectl\s*$wordToComplete$") 
    {
        return
    } 
    
    if ($wordToComplete -notmatch '^[\w\-]*$') 
    {
         # don't process anything but [a-zA-Z0-9_-]
         # we only completing one word after kubectl
        return
    }
    
    #
    #   Generic completion: say 'kubectl --help' and use all commands it lists as suggestions
    #   TODO: add more specific suggestions for particular commands
    #
	$(foreach($line in kubectl --help) {
		if ($line -match '^  \S') {
            foreach($token in $line -split '\s+') {
                if ($token)
                {
                    if( $token -like "$wordToComplete*") {
                        $token
                    }
                    break; # found first non empty token
				}
			}
		}
    }) | Sort-Object
}

