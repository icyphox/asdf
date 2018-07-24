from ctypes import *

def main():
    test_lib = CDLL('./libpynim.so')
    test_lib.summer.restype = c_int32

    sum_res = test_lib.summer(1, 3)

    print(sum_res)

if __name__ == '__main__':
    main()
