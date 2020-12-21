e <- new.env()

# Assigning in the environment the usaual way
with(e, foo <- "bar")
e

ls.str(e)
e$foo
e$bar <- "baz"