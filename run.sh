#!bash
set -v
pwd
echo $HOME
echo $PATH

declare -a rargs

echo '#!bash' > foo
echo 'set -v' >> foo
cat /usr/local/bin/mlton >> foo
bash foo

# git clone https://github.com/MLton/mlton.git mlton_git
# cd mlton_git
# gmake MLTON=/usr/local/bin/mlton CC=/usr/bin/clang WITH_GMP_INC_DIR=/usr/local/include WITH_GMP_LIB_DIR=/usr/local/lib
