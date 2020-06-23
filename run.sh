#!sh
pwd
echo $HOME
echo $PATH

bash -c 'echo hello bash'

ls /usr/local/bin/
echo XXX
ls /usr/local/bin/mlton

/usr/local/bin/mlton -h

# git clone https://github.com/MLton/mlton.git mlton_git
# cd mlton_git
# gmake MLTON=/usr/local/bin/mlton CC=/usr/bin/clang WITH_GMP_INC_DIR=/usr/local/include WITH_GMP_LIB_DIR=/usr/local/lib
