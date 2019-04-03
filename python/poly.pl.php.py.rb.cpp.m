#/*<?php echo "PHP Code\n"; __halt_compiler();?> */

#include <stdio.h> /*

print (("b" + "0" == 0 and "Perl Code\n") or (0 and "Ruby Code\n" or "Python Code"));

__DATA__ = 1
"""""
__END__

===== . ===== */

#ifdef __OBJC__
    char msg[17] = {'O','b','j','e','c','t','i','v','e','-','C',' ','C','o','d','e', '\n'};
#elif __cplusplus
    char msg[9] = {'C','+','+',' ','C','o','d','e', '\n'};
#else
    char msg[7] = {'C',' ','C','o','d','e', '\n'};
#endif

int main() { int i; for(i = 0; i < 17; ++i) putchar(msg[i]); return 0;} /*

outputs:

  $ perl polyglot.pl.php.py.rb.cpp.m
  Perl Code
  $ php polyglot.pl.php.py.rb.cpp.m
  #/*PHP Code
  $ python polyglot.pl.php.py.rb.cpp.m
  Python Code
  $ ruby polyglot.pl.php.py.rb.cpp.m
  Ruby Code
  $ g++ -x c++ polyglot.pl.php.py.rb.cpp.m -o poly; ./poly
  C++ Code
  $ g++ -x c polyglot.pl.php.py.rb.cpp.m -o poly; ./poly
  C Code
  $ gcc polyglot.pl.php.py.rb.cpp.m -o poly; ./poly # apple-darwin11-llvm-gcc
  Objective-C Code

"""
#*/
