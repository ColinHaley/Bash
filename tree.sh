find . -type d -print | sed -e 's;[^/]*/;|____;g;s;___|; |;g'
