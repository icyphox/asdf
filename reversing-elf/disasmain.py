from elftools.elf.elffile import ELFFile
from capstone import *

with open('./chall.elf', 'rb') as f:
    elf = ELFFile(f)
    code = elf.get_section_by_name('.text')
    ops = code.data()                 # returns a bytestring with the opcodes
    addr = code['sh_addr']            # starting address of `.text`
    md = Cs(CS_ARCH_X86, CS_MODE_64)
    for i in md.disasm(ops, 0x7aa):    # looping through each opcode
        print(f"0x{i.address:x}:\t{i.mnemonic}\t{i.op_str}")
