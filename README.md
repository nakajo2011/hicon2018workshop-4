# hicon2018workshop-4
# Description
## sol-traceを用いてバグの原因を探す
- step1. sol-traceを使わずにtestの結果からバグの原因を探してみる。
- step2. sol-traceを導入してエラーの発生箇所を特定する。

## how to integrate sol-trace to test
test/education_pass.jsの2,3行目に以下のコードを挿入

```
import { injectInTruffle } from 'sol-trace'
injectInTruffle(web3, artifacts)
```

### エラーの行数がうまく表示できない時
*.solをcompileしなおすと良い
```
rm build/contracts/*
truffle compile
```

※build/contracts/　以下を全て削除してからtruffle compileすること
