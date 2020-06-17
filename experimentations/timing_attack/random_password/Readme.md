Short demonstration of a timing attack on a basic password checker
---
1;5202;0c
It is well known that timing attacks are to be dreaded in the security
world. For instance, the following code is vulnerable to timing
attacks:
1;5202;0c
```c
int check_password(char* provided, char* expected, int length) {
    for (int i = 0; i < length; i++) {
        if (provided[i] != expected[i]) {
            return 0;
        }
    }
    return 1;
}
```

The folder contains a small experiment to demonstrate a timing attack
on this small code:

  - `pwd_check.c` contains a function `init_password` to initialize a
    random password, and this function `check_password` that checks
    wether a provided password is correct.
    
  - `main.c` attempts to find out the length and the value of the
    password by calling `check_password`, and measuring the time it
    takes, using `rdtscp` (which counts CPU cycles). 
    
Note that this is not the most ambitious implementation ever: there is
basically no noise, we use `rdtscp` (which basically any language but
C won't be able to use), and we assume that we can run _a lot_ of
measurements.

Nevertheless, the goal is only to show that timing attacks are easy to
setup and do indeed work.

Compile and run with:

    gcc -O3 -Wall -Wextra -march=native pwd_check.c main.c -o main
    ./main

(it works less well with Clang; I blame compiler optimizations :D )


It seems to work pretty well some times, less well other times. I
think there is a bug with some special characters; to investiguate.
