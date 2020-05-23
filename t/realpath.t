# bash

. realpath.sh

_REALPATH_DEBUG=

mkdir -p tmp

pushd tmp
tmp_path=$(pwd)

mkdir -p src/pkg{1..3}
mkdir -p dst
ln -s ../src/pkg1 dst/pkg1

t_is "$(realpath dst/pkg1)" ${tmp_path}/src/pkg1
t_is "$(realpath src/pkg1)" ${tmp_path}/src/pkg1
t_is "$(realpath $(pwd)/dst/pkg1)" ${tmp_path}/src/pkg1

(
  cd src
  t_is "$(realpath pkg1)" ${tmp_path}/src/pkg1
  (
    cd pkg1
    t_is "$(realpath .)" ${tmp_path}/src/pkg1
    t_is "$(realpath ..)" ${tmp_path}/src
  )
)

popd
rm -rf tmp

# vim:set ft=sh :
