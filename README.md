# メモ登録・変更アプリ
## 概要

・メモを作成、変更、削除できる。

・ユーザごとに表示するメモを出しわける

・ジャンルと各メモを紐づけてソートできる。

・日付でソートする（ジャンルが出来たら）

他思いついたら拡張していきます。

## 環境構築手順
ruby-buildインストール
```
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
```


aptの更新
```
sudo apt update
```

必要なライブラリをインストール
```
sudo apt-get install autoconf bison patch build-essential rustc libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libgmp-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev uuid-dev
```

```
sudo apt install rbenv
```

rbenvのバージョン確認
```
rbenv install -l
```

ruby3.1.3をインストール
```
rbenv install 3.1.3
```

sqlite3を動かす用
```
sudo apt install libsqlite3-dev
```

node.jsまわり設定
```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
```
```
exec $SHELL -l
```
```
nvm install --lts
```

yarn設定
```
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
```
```
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
```
```
sudo apt update && sudo apt install -y yarn
```

適当なディレクトリを作成

そこで下記リポジトリをクローン
```
git clone https://github.com/Yu-I-dimasfan/memo_crud.git
```

ディレクトリの移動
```
cd memo_crud/memo_app
```

rbenvを設定
```
rbenv local 3.1.3
```

bundlerインストール
```
rbenv exec gem install bundler
```

Gemのインストール
```
rbenv exec　bundle update
```
```
rbenv exec bundle install
```

マイグレーション実行
```
rbenv exec rails db:migrate
```

シード実行(ジャンル選択のため）
```
rbenv exec rails db:seed
```

アセットパイプラインの設定
```
rbenv exec rails assets:precompile
```

起動
```
rbenv exec rails s
```

