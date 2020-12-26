# FSWiki 用ダークテーマ kati_dark

FSWiki に標準で含まれております kitta 氏の [kati](https://fswiki.osdn.jp/cgi-bin/wiki.cgi?page=BugTrack%2Dtheme%2F4) theme をダークに変換したものです。

動作や見た目は自分の使っている範囲でしか確認できていないのと、画像などのパーツは改良の予知があるので、有志の方々に改良してもらえることを期待して公開致しました。

## スクリーンショット

![スクリーンショット](./docs/screenshot.png)

## 適用方法

### 設定を変更する場合

1. FSWiki の theme/ フォルダ内に移動し

    ```shell
    git clone git@github.com:KazKobara/kati_dark.git
    ```

1. config/config.dat 内の `theme=` で始まる行を `theme=kati_dark` に変更するか、FSWiki画面の右上から [ログイン] -> [管理] でログインし、画面中の [スタイル設定] -> [テーマ] で "kati_dark!" を選択。

1. サイドメニューについては画面上部の [新規] で "Menu" というページを以下のような内容でご作成下さい。

    ```text
    {{calendar 予定表}}

    //!サイト内検索
    !Menu
    {{search v}}

    ----
    //!最近編集されたトップ50ページ
    {{recent 50,v}}

    //!表示ページの章立て
    ! outline

    {{outline}}
    ```

### Docker で試す場合

- [こちら](https://github.com/KazKobara/dockerfile_fswiki_local)で起動される Docker container の theme として設定してあります。
  - 上記の FSWiki は（インターネット上に公開するサーバー用ではなく、データ自体はクラウドスレージなどと同期させるなどして、その同期したデータや手元の wiki データを）、PCのブラウザで表示させることを意図したものになります…
