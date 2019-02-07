from elftools.elf.elffile import ELFFile

with open('./bin.elf', 'rb') as f:
    e = ELFFile(f)
    for section in e.iter_sections():
        print(hex(section['sh_addr']), section.name, section['sh_size'])
