#!sh
pwd

echo $PATH

whereis mlton

mlton

git clone https://github.com/MLton/mlton.git mlton_git
cd mlton_git
gmake CC=/usr/bin/clang WITH_GMP_INC_DIR=/usr/local/include WITH_GMP_LIB_DIR=/usr/local/lib
