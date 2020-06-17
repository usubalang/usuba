Short demonstration of a timing attack on a basic pincode checker
---

This experiment is the same as the one in `../random_password`, except
that it is less ambitious: it tries to break a pincode checker (only
using digits in the pincode).

Seems to work fairly well (on my computer) up to 10 digits (which is
the max for an unsigned int).

Compile and run with:

    gcc -O3 -Wall -Wextra -march=native pwd_check.c main.c -o main
    ./main
