import string
import os

os.chdir("C:\\Users\\Or\\Desktop\\Reverse Engineering\\exercises_repo\\ex3")
result_dict = dict()
for char in string.printable:
    pipe = os.popen('keygen.exe ' + char)
    if pipe:
        decoded_char = pipe.read()
        result_dict[decoded_char] = char
print(result_dict)
password = []

OUR_PASSWORD = 'LHSBXVUGS1KFFADR'
for pass_char in OUR_PASSWORD:
    password.append(result_dict[pass_char])

final_password = ''.join(password)
print(final_password)
