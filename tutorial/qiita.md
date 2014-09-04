
オフラインリアルタイムどう書く
====

オフラインリアルタイムどう書くとは？

```ruby
def hoge
end
```

parse
----

- 一文字一入力
  - http://nabetani.sakura.ne.jp/hena/ord5railsontiles/
  - http://nabetani.sakura.ne.jp/hena/ord7xysort/
- 区切り文字
  - http://nabetani.sakura.ne.jp/hena/ord6lintersection/
- 2/8/10/16進数
  - http://nabetani.sakura.ne.jp/hena/ord11bitamida/
- 二桁の数字で座標
  - http://nabetani.sakura.ne.jp/hena/ord6lintersection/
- N文字区切り
  - http://nabetani.sakura.ne.jp/hena/ord14linedung/
- 複雑な入力
  - [regex-posix-0.95.2: Replaces/Enhances Text.Regex](http://www.haskell.org/platform/doc/2013.2.0.0/packages/regex-posix-0.95.2/doc/html/index.html)
  - Parsec

tips
しなくてもいい変換はしない
  inputを数値に変換するとか

solve
----

[Data.List](http://www.haskell.org/ghc/docs/latest/html/libraries/base-4.6.0.1/Data-List.html)

show
----

- 文字列 id
  - [異星の電光掲示板 〜 横へな 2013.11.1](http://nabetani.sakura.ne.jp/hena/ord15elebubo/)
- 数値 show
  - [L被覆 〜 横へな 2013.12.7 参考問題](http://nabetani.sakura.ne.jp/hena/ord16lcove/)
- 区切り文字
  - [境界線分 〜 横へな 2013.12.7](http://nabetani.sakura.ne.jp/hena/ord16boseg/)
- 解無し Maybe
  - [数を作る 〜 横へな 2013.4.6 の参考問題](http://nabetani.sakura.ne.jp/hena/ord9nummake/)
- 自由なformat
  - [Text.Printf](http://www.haskell.org/ghc/docs/latest/html/libraries/base-4.6.0.1/Text-Printf.html)

問題整理
====

01a. [split,maybe]