# WatchNote（視聴記録アプリ）

このアプリは、Java + HTML + CSS + JavaScript + MySQL を使用して作成された視聴記録アプリです。アニメ、ドラマ、映画などのジャンルにとらわれず、過去に観た作品、今後観たい作品の登録・編集・削除ができます。

---

## 📌 主な機能

- 観た作品の一覧
- 観た作品の登録
- 観た作品の編集・削除
- 観たい作品の一覧
- 観たい作品の登録
- 観たい作品の編集・削除


---

## ⚙️ 使用技術

| 技術            | バージョン |
| --------------- | ---------- |
| Java            | 17 以上    |
| MySQL           |            |

---


## 🗃️ データベース構成

| watchnote  |                                                                   |
| ---------- | --------------------------------------------------------------------------- |
| genres     | id（PK）, name|
| stars      | id（PK）,name|
| viewed_works   | id（PK）,titel,updated_at,star_id,review|
| viewed_work_genres   | viewed_work_id,genre_id|
| wishlist_works | id（PK）,titel,updated_at,star_id,review|
| wishlist_work_genres | wishlist_work_id,genre_id|
---


## 📌 今後の改善予定

- ソート機能の追加
- 検索機能の追加
- お気に入り機能の追加

---

## 📄 ライセンス

このプロジェクトは MIT ライセンスのもとで公開されています。

---

## 👩 作者

- [/ponsu1394](https://github.com/ponsu1394/watch-note.git)
