## MariVM

**Mari** is a simple assembly-like, interpreted, object-oriented language designed with speed in mind.

**MariVM** is the interpreter for Mari code, written in D.

## Running a program

To run a "hello world" program in Mari:

- Compile Mari by running `dub build` in the root directory of the git repo

- Create a file called "helloworld.mari", with the content:

`log "Hello, World!";`

- Run in the same directory you compiled mari in: `./mari helloworld.mari`