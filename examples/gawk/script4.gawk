BEGIN {
print "The latest list of users and shells"
print "UserID \t\t Shell"
print "--------- \t -------"
FS=":"
}

{
print $1 "      \t " $7
}

END {
print "This concludes the listing"
}