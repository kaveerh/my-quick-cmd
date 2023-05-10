git log --graph --abbrev-commit --decorate --format=format:"%C(green)%h%C(reset) - %C(white)%s%C(reset) %C(reset)%C(red)%d%C(reset)" --all
gl='git log --all --graph --decorate --date=relative --pretty=format:'\''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'' --abbrev-commit ':w
