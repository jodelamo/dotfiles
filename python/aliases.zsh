alias pu="pip list --outdated | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U"
