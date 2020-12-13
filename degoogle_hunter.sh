#!/bin/bash
hostname=$1
target=${hostname%%.*}

declare -A dorks

dorks["# 3rd part exposure"]="site:http://ideone.com | site:http://codebeautify.org | site:http://codeshare.io | site:http://codepen.io | site:http://repl.it | site:http://justpaste.it | site:http://pastebin.com | site:http://jsfiddle.net | site:http://trello.com | site:*.atlassian.net | site:bitbucket.org \"$target\""
dorks["# Juicy files"]="site:$1 intitle:index.of | ext:xml | ext:conf | ext:cnf | ext:reg | ext:inf | ext:rdp | ext:cfg | ext:txt | ext:ora | ext:ini | ext:sql | ext:dbf | ext:mdb | inurl:wp- | inurl:wp-content | inurl:plugins | inurl:uploads | inurl:themes | inurl:download | ext:log | inurl:login | intext:\"sql syntax near\" | intext:\"syntax error has occurred\" | intext:\"incorrect syntax near\" | intext:\"unexpected end of SQL command\" | intext:\"Warning: mysql_connect()\" | intext:\"Warning: mysql_query()\" | intext:\"Warning: pg_connect()\" | ext:php intitle:phpinfo \"published by the PHP Group\" | inurl:shell | inurl:backdoor | inurl:wso | inurl:cmd | shadow | passwd | boot.ini | inurl:backdoor | inurl:readme | inurl:license | inurl:install | inurl:setup | inurl:config | inurl:\"/phpinfo.php\" | inurl:\".htaccess\" | inurl:\"/.git\" tesla.com -github | ext:swf"
dorks["# Exposed documents"]="site:$1 ext:doc | ext:docx | ext:odt | ext:pdf | ext:rtf | ext:sxw | ext:psw | ext:ppt | ext:pptx | ext:pps | ext:csv"
dorks["# Open redirects"]="site:$1 inurl:redir | inurl:url | inurl:redirect | inurl:return | inurl:src=http | inurl:r=http"
dorks["# Apache Struts RCE"]="site:$1 ext:action | ext:struts | ext:do"
dorks["# Search in pastebin"]="site:pastebin.com $1"
dorks["# Linkedin employees"]="site:linkedin.com employees $1"
dorks["# Wordpress files"]="site:$1 inurl:wp-content | inurl:wp-includes"
dorks["# Subdomains"]="site:*.$1"
dorks["# Sub-subdomains"]="site:*.*.$1"

for c in "${!dorks[@]}"; do
    printf "\n\e[32m"%s"\e[0m\n" "$c" && python3 degoogle.py -j "${dorks[$c]}"
done
