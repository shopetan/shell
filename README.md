shell
=====

組んだシェルスクリプトたち

*copy_rename.shの使い方

欲しいファイルを親ディレクトリから検索し，移動先ディレクトリに移動＆リネームを行う

cr_file [元となるディレクトリ] [移動先のディレクトリ]
元となるディレクトリ配下にあるファイルを子ディレクトリ全てから検索し移動先に渡し，リネームまで行う．

検索して拾いたいファイル名は，ext変数で決められる．
例えば，○○_2.cと名のつくファイルを拾ってきたい場合は，
ext='*_2.c'
と入力すればよい


-sougo.shの使い方

元となるディレクトリ配下にあるファイルを拾い，ファイル名をシャッフルした後に移動先ディレクトリに格納する

sougo_file [元となるディレクトリ] [移動先のディレクトリ]
で引数を与える．

※現時点での問題は重複や被りを考慮できていない点であり，随時更新予定である．


=注意点
どちらのファイルに対しても，実行時には
./sougo.sh > output
のようにして出力結果をファイルに格納しておくことが望ましい．
