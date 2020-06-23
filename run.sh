#!sh
pwd
echo $HOME
echo $PATH
export PATH="$PATH:/usr/local/bin"
echo $PATH


mlton

whereis mlton
/usr/local/bin/mlton

git clone https://github.com/MLton/mlton.git mlton_git
cd mlton_git
gmake MLTON=/usr/local/bin/mlton CC=/usr/bin/clang WITH_GMP_INC_DIR=/usr/local/include WITH_GMP_LIB_DIR=/usr/local/lib
