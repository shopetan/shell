#!/bin/sh
##############################################################
## file name: sougo.sh                                     ##
##  function :move file                                    ##
##############################################################

# src file
ext='*_2.c'

# move function
move_file(){
  srcDir=$1
  dstDir=$2

  echo srcDir is [$srcDir]
  echo dstDir is [$dstDir]
  

#src:source file ,dst:destination file

  # srcDir check(sonzai kakunin)
  if [ ! -d $srcDir ]; then
    echo "src [$srcDir] is not found"
    exit
  fi
 
  # destDir check
  if [ ! -d $dstDir ]; then
    echo "dst [$dstDir] is not found "
    exit
  fi
 
  # change dir
  cd $srcDir
 
  # search file 
  # find no ugokini tyuui 
  for fName in `find . -name "$ext"`
  do

    # get file name
    efName=`echo $fName`
    dstFile=$dstDir/$efName

    # preDir file check
    if [ -f $dstFile ]; then
      echo "[$dstFile] is already exist"
      exit
    fi
 
    echo "copy [$fName] to [$dstDir]"
    # copy file
    cp -f $fName $dstFile
 
    # after file check
    if [ ! -f $dstFile ]; then
      echo "after copy [$dstFile] is not found"
      exit
    fi
  done
}
 
echo "###############################################"
echo "##                   START                   ##"
echo "###############################################"
echo ""
 
# start function
# move_file srcDir destDir

move_file ~/shdbg ~/shdbg/home
 
echo ""
echo "###############################################"
echo "##                    END                    ##"
echo "###############################################"
 
exit
