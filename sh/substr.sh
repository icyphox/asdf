#!/usr/bin/env bash

msg=$(cat << 'END'
Test post

Signed-off-by: Anirudh Oppiliappan <x@icyphox.sh>

# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
#
# On branch master
# Your branch is up to date with 'origin/master'.
#
# Changes to be committed:
#	new file:   dirty
#
# ------------------------ >8 ------------------------
# Do not modify or remove the line above.
# Everything below it will be ignored.
diff --git a/dirty b/dirty
new file mode 100644
index 0000000..e69de29
[master 53171a7] Test post
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 dirty
END
)

if [[ $msg == *post* ]]; then
    printf "contains post"
fi
