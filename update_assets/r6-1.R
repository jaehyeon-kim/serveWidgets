library(magrittr)
library(jsonlite)
library(pryr)
library(R6)

#### basic
Person <- R6Class(
    'Person',
    public = list(
        name = NA,
        initialize = function(name, gender) {
            self$name <- name
            private$gender <- gender
        },
        hello = function() {
            print(paste('Hello', self$name))
            private$myGender()
        },
        member = function() {
            print(self)
            print(private) # environment in an environment where self object is located
            print(ls(envir = private))
        }
    ),
    private = list(
        gender = NA,
        myGender = function() {
            print(paste(self$name, 'is', private$gender))
        }
    )
)

u1 <- Person$new('Bernie', 'Male')
u1$hello()
u1$name
u1$gender # NULL
# u1$myGender() # Error: attempt to apply non-function

u1$member()

Person1 <- R6Class(
    'Person1',
    public = list(
        num = 100
    ),
    active = list(
        active = function(value) {
            if (missing(value)) return(self$num + 10)
            else self$num <- value
        },
        rand = function() rnorm(1)
    )
)

u2 <- Person1$new()
u2$num
u2$active
u2$num
u2$active <- 200
u2$num

u2$rand
# u2$rand <- 1 # error

#### inheritance
Person2 <- R6Class(
    'Person2',
    public = list(
        name = NA,
        initialize = function(name, gender) {
            self$name <- name
            private$gender <- gender
        },
        hello = function() {
            print(paste('Hello', self$name))
            private$myGender()
        }
    ),
    private = list(
        gender = NA,
        myGender = function() {
            print(paste(self$name, 'is', private$gender))
        }
    )
)

Worker2 <- R6Class(
    'Worker2',
    inherit = Person2,
    public = list(
        bye = function() {
            print(paste('bye', self$name))
        }
    )
)

w2 <- Worker2$new('Bernie', 'Male')
w2$bye()
