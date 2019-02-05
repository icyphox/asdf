import sys
from elftools.elf.elffile import ELFFile
from capstone import *

def process_file(filename):
    with open(filename, 'rb') as f:
        elffile = ELFFile(f)
        code = elffile.get_section_by_name('.text')
        opcodes = code.data()
        addr = code['sh_addr']
        print('Entry Point:', hex(elffile.header['e_entry']))
        md = Cs(CS_ARCH_X86, CS_MODE_64)
        for i in md.disasm(opcodes, 0x520):
            print("0x%x:\t%s\t%s" %(i.address, i.mnemonic, i.op_str))

if __name__ == '__main__':
    if len(sys.argv) == 2:
        process_file(sys.argv[1])
