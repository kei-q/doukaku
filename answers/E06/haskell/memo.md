# 資料

- https://www.haskell.org/hoogle/
- [document](https://downloads.haskell.org/~ghc/latest/docs/html/libraries/)
    - [Data.List](https://downloads.haskell.org/~ghc/latest/docs/html/libraries/base-4.9.0.0/Data-List.html)
    - [Data.List.Split](https://hackage.haskell.org/package/split-0.2.2/docs/Data-List-Split.html)
- 3rd party libraries
  - Lens
    - [Numeric.Lens](https://hackage.haskell.org/package/lens-4.14/docs/Numeric-Lens.html)
  - [basic-prelude](https://hackage.haskell.org/package/basic-prelude)
- 過去のdoukaku
  - https://github.com/keqh/doukaku/blob/master/answers/

# parse

- 文字列を数値に
  - `read`
- 16進数の文字列を数値に
  - `Numeric.readHex`
  - ? `Numeric.Lens`
    - `x ^? base 16`
- 8進数の文字列を数値に
  - `Numeric.readOct`
  - ? `Numeric.Lens`
- 2進数の文字列を数値に
  - 直接文字列で扱う？
- N文字で区切る
  - `chunksOf`
- 空白区切りの文字列を分割
  - `words`
- 改行区切りの文字列を分割
  - `lines`
- 特定の文字列で区切る
  - `splitOn`
- 特定の文字で区切る
  - `splitOneOf`

## ex

- 16進数二桁を上位と下位で分ける
  - `readHex`して`divmod x 16`



# format

- 文字列に変換する
  - `show`
- 文字列のリストを連結する
  - `intercalate`
  - `concat`
- 整形して文字列に
  - `printf`
- 変数展開 rubyの `#{var}`みたいな
  -
- 数値を16進数の文字列に
  - `Numeric.showHex`

```haskell
chunksOf

```



# solve

## List

```haskell

```

## Tuple



# debugging

- `Debug.Trace`
- [Haskell でのデバッグ - あどけない話](http://d.hatena.ne.jp/kazu-yamamoto/20120606/1338957783)

# test

- hspec
  - ? 簡単な使い方
