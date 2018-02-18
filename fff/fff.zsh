# `cd` on exit
# Ref: https://github.com/dylanaraps/fff#cd-on-exit
f() {
    fff "$@"
    cd "$(cat "${XDG_CACHE_HOME:=${HOME}/.cache}/fff/.fff_d")"
}
