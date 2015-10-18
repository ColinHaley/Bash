if [ $# -eq 0 ]; then
    du -hsx * | sort -rh | head -10
    exit     
fi

du -hsx * | sort -rh | head -$1
