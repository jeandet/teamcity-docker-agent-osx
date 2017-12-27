#!/bin/xonsh

vars = $(env).split()
for var in vars:
  print(var)
print("==================================================================")
print("====================    FILTERING VARS    ========================")
print("==================================================================")
for VAR_TO_EXCLUDE in ["PATH=", "PWD=", "SHELL_TYPE", "LOADED_RC_FILES", "LC_CTYPE=", "TERM=", "XONSH", "HOME=", "BASH_COMPLETIONS=", "ARGS=", "SHLVL=", "GUESTFISH", "LESSOPEN=", "_="]:
  vars = [ var for var in vars if not VAR_TO_EXCLUDE in var ]

for var in vars:
  print(var)

with open("env","w") as file:
  lines = [ 'export {VARNAME}={VARVALUE}\n'.format(VARNAME=var.split("=")[0], VARVALUE=var.split("=")[1] ) for var in vars if "=" in var ]
  file.writelines(lines)

chmod +x env

vagrant up --provider=virtualbox
vagrant halt
