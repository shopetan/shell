#!/bin/sh
##############################################################
## file name: sougo.sh                                     ##
##  function :copy&rename file                             ##
##############################################################

# src file
ext='*_2.c'

# move function
cr_file(){
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
 

#  ls -F| grep /

 
  # search file 
  # find no ugokini tyuui 
  for fName in `find . -name "$ext"`
  do
      
      rName=$fName
      #substring j1xxxx.c
      rName=`echo ${rName:2:6}`
      rName=`echo $rName | sed -e "s/$/.c/"`
      
      
      # get file name
      efName=`echo $fName  | sed -e 's/^..*//'`
      dstFile=$dstDir/$efName
      
      # preDir file check
      if [ -f $dstFile ]; then
	  echo "[$dstFile] is already exist"
	  exit
      fi
      
      echo "copy [$fName] to [$dstDir]"
      # copy file
      cp -f $fName $dstDir
      
      #reName
      cd $dstDir
      prName=`find . -name "$ext"`
      mv $prName $rName
      cd $srcDir
      
      # after file check
      #    if [ ! -f $dstFile ]; then
      #      echo "after copy [$dstFile] is not found"
      #      exit
      #    fi
      
  done
}

echo "###############################################"
echo "##                   START                   ##"
echo "###############################################"
echo ""
 
# start function
# move_file srcDir destDir

cr_file ~/shdbg ~/admin
 
echo ""
echo "###############################################"
echo "##                    END                    ##"
echo "###############################################"
 
exit
