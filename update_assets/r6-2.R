# https://adv-r.hadley.nz/r6

# https://stackoverflow.com/questions/35414576/multiple-inheritance-for-r6-classes
# https://rpubs.com/rappster/153394

library(R6)

#### public fields/methods
Accumulator <- R6Class(
    'Accumulator',
    public = list(
        sum = 0,
        add = function(x = 1) {
            self$sum <- self$sum + x
            invisible(self)
        }
    )
)

x <- Accumulator$new()
x$add(4)
x$sum
# Side-effect R6 methods should always return self invisibly <- enabling method chaning
x$add(10)$add(10)$sum

x$
    add(10)$
    add(10)$
    sum

#### useful functions - initialize, print
# $initialize() is a good place to check that name and age are the correct types
Person <- R6Class(
    'Person',
    public = list(
        name = NULL,
        age = NA,
        initialize = function(name, age = NA) {
            stopifnot(is.character(name), length(name) == 1)
            stopifnot(is.numeric(age), length(age) == 1)
            self$name <- name
            self$age <- age
        },
        print = function(...) {
            cat('Person: \n')
            cat('  Name: ', self$name, '\n', sep = '')
            cat('  Age: ', self$age, '\n', sep = '')
            invisible(self)
        }
    )
)

jk <- Person$new('jk', age = 100)
jk

#### adding methods after creation
Accumulator <- R6Class('Accumulator')
Accumulator$set('public', 'sum', 0)
Accumulator$set('public', 'add', function(x = 1) {
    self$sum <- self$sum + x
    invisible(self)
})

# Accumulator$set('public', 'sum', 1) ## error
Accumulator$set('public', 'sum', 1, overwrite = TRUE)
Accumulator$new()$sum

x1 <- Accumulator$new()
Accumulator$set('public', 'hello', function() message('Hi!'))
# x1$hello() # not for existing objects
x2 <- Accumulator$new()
x2$hello()

#### inheritance
# R6 only supports single inheritance: you cannot supply a vector of classes to inherit
AccumulatorChatty <- R6Class(
    'AccumulatorChatty',
    inherit = Accumulator,
    public = list(
        add = function(x = 1) {
            cat('Adding ', x, '\n', sep = '')
            super$add(x = x)
        }
    )
)

x3 <- AccumulatorChatty$new()
x3$add(10)$add(1)$sum

#### Introspection
class(x3)
names(x3)
# clone

#### Privacy
# cannot access private fields or methods outside of the class
Person <- R6Class(
    'Person',
    public = list(
        initialize = function(name, age = NA) {
            private$name <- name
            private$age <- age
        },
        print = function(...) {
            cat('Person: \n')
            cat('  Name: ', private$name, '\n', sep = '')
            cat('  Age: ', private$age, '\n', sep = '')
            invisible(self)
        }
    ),
    private = list(
        age = NA,
        name = NULL
    )
)

PersonMore <- R6Class(
    'PersonMore',
    inherit = Person,
    public = list(
        hello = function() {
            cat('Person: \n')
            cat('  Name: ', super$name, '\n', sep = '')
            cat('  Age: ', super$age, '\n', sep = '')
        }
    )
)

jk <- Person$new('jk')
jk
jk$name # NULL

PersonMore$new(jk)$hello() # privates not accessible in child class

#### Active fields
Rando <- R6Class(
    'Rando',
    active = list(
        random = function(value) runif(1)
    )
)

x <- Rando$new()
x$random
x$random

Person <- R6Class(
    'Person',
    private = list(
        .age = NA,
        .name = NULL,
        .region = NULL
    ),
    active = list(
        age = function(value) { # ensure age is read-only
            if (missing(value)) {
                private$.age
            } else {
                stop('"$age" is read only', call. = FALSE)
            }
        },
        name = function(value) { # ensure name is length 1 character vector
            if (missing(value)) {
                private$.name
            } else {
                stopifnot(is.character(value), length(value) == 1)
                private$.name <- value
                self
            }
        },
        region = function(value) {
            if (missing(value)) {
                stop('"$region" is write only', call. = FALSE)
            } else {
                private$.region <- value
            }
        }
    ),
    public = list(
        initialize = function(name, age = NA) {
            private$.name <- name
            private$.age <- age
        },
        print = function() {
            cat('Person: \n')
            cat('  Name: ', private$.name, '\n', sep = '')
            cat('  Age: ', private$.age, '\n', sep = '')
            cat('  Region: ', private$.region, '\n', sep = '')
            invisible(self)
        }
    )
)

jk <- Person$new('jk', 20)
jk$name
jk$name <- 10 # error

jk$age
jk$age <- 10 # error

jk$region # error
jk$region <- 'AU'

jk

#### Reference semantics - S3 objects built on top of environments
typeof(jk)

# reference semantics - objects are not copied when modified
y1 = Accumulator$new()
y2 <- y1

y1$add(10)
c(y1 = y1$sum, y2 = y2$sum)
#y1 y2
#11 11

# use $clone() for copying
# use $clone(deep = TRUE) for copying nested classes
y1 <- Accumulator$new()
y2 <- y1$clone()

y1$add(10)
c(y1 = y1$sum, y2 = y2$sum)

#### finalizer
TemporaryFile <- R6Class(
    'TemporaryFile',
    public = list(
        path = NULL,
        initialize = function() {
            self$path <- tempfile()
        },
        finalize = function() {
            message('Cleaning up ', self$path)
        },
        print = function() {
            message('Temp file ', self$path)
        }
    )
)

tf <- TemporaryFile$new()
rm(tf)
invisible(gc())

#### R6 fields
# child object is initialize once when the class is defined, not institiated
# beaware setting a defalut value to an R6 class
TemporaryDatabase <- R6Class(
    'TemporaryDatabase',
    public = list(
        con = NULL,
        file = TemporaryFile$new(),
        initialize = function() {
            #DBI::dbConnect(RSQLite::SQLite(), path = file$path)
        }
    )
)

db_a <- TemporaryDatabase$new()
db_b <- TemporaryDatabase$new()

db_a$file$path == db_b$file$path

TemporaryDatabase1 <- R6Class(
    'TemporaryDatabase1',
    public = list(
        con = NULL,
        file = NULL,
        initialize = function() {
            self$file <- TemporaryFile$new()
            #DBI::dbConnect(RSQLite::SQLite(), path = file$path)
        }
    )
)

db1_a <- TemporaryDatabase1$new()
db1_b <- TemporaryDatabase1$new()

db1_a$file$path == db1_b$file$path

## threading state
new_stack <- function(items = list()) {
    structure(list(items = items, class = 'stack'))
}

push <- function(x, y) {
    x$items <- c(x$items, list(y))
    x
}

pop <- function(x) {
    n <- length(x$items)

    item <- x$items[[n]]
    x$items <- x$items[[-n]]

    list(item = item, x = x)
}

s <- new_stack()
s <- push(s, 10)
s <- push(s, 20)

out <- pop(s)
out

Stack <- R6Class(
    'Stack',
    public = list(
        items = list(),
        push = function(x) {
            self$items <- c(self$items, x)
            invisible(self)
        },
        pop = function() {
            item <- self$items[[self$length()]]
            self$items <- self$items[-self$length()]
            item
        },
        length = function() {
            length(self$items)
        }
    )
)

s1 <- Stack$new()
s1$push(10)$push(20)
s1$pop()

