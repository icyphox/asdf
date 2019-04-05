import pefile

pe = pefile.PE('/home/icy/.wine/drive_c/windows/system32/notepad.exe')
print(pe.OPTIONAL_HEADER)
print(pe.FILE_HEADER)

for section in pe.sections:
    print(section.Name, 
            hex(section.VirtualAddress), 
            hex(section.Misc_VirtualSize),
            section.SizeOfRawData)
