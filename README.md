## サービス概要
カレンダーに「どこどこに行った」「友達とこれをした」「この作品を観た」など、なんでも良いので楽しかったことや、面白かったこと、リラックスしたことなどのポジティブな思い出を記録していき、毎月「思い出の合計」が表示され、過去の月との比較もできると共に、「行った場合」「食べた物」「観た作品」などに１〜５個の星で評価もつけられ、評価したものを投稿し他ユーザーから「いいね」を貰うことができるアプリ

## このサービスへの思い・作りたい理由
- 私は映画をたくさん観るので、この日この作品を観たというのを忘れてしまうことがよくあります。そこで観た作品を記録し、評価ができるアプリがあったら良いなと思い、サービス考えていくうちにカレンダーアプリを作ろうという考えに纏まりました。
- 何もしないで１日が終わってしまったという日を誰しも経験していると思います。そこで無駄な１日を無くしていきたいと思ったのでこのサービスを考えました。
- 毎月少しでも良いので思い出を残していき、楽しかった、満足したと思える人生を過ごして欲しいという思いもあります。

## ユーザー層について
### ユーザー層
20代〜30代の社会人を主な対象にしたいと考えています。
### 理由
社会人の中には仕事が辛くて知らず知らずネガティブ思考になっている人がいると思います。ましてや社会人はプライベートな時間が限られていて休日も少ないです。なのでこのサービスを利用して、貴重な休日を無駄にせず、アクションを起こし、ポジティブ思考で生活して欲しいと思い、社会人を主な対象にしたいと考えました。

## サービスの利用イメージ
思い出記録アプリとして使っていただき、会話の題材として「行った場所」や「観た作品」などを確認するのに使うのもよし、「食べた物」や「観た作品」に対して星の評価をし「いいね」を送り合うのもよし、毎月「思い出の合計」を確認し充実感を実感するのもよし、このようにユーザーに自由に使ってもらい、毎月楽しく生きている実感を感じて欲しいです。

## ユーザーの獲得について
- SNSでの発信
- 友人からその友人へと広めていく

## サービスの差別化ポイント・推しポイント
- 毎月「思い出の合計」が表示されることによって、その月がどのぐらい充実した月なのかが一目で分かる。
- タグ機能を使用し、記録をした日の合計と、その月にどういうことを何回したかを表示できる。
- 評価したものをアプリ内で投稿し他ユーザーと共有することができ、いいね機能で「いいね」を送り合うことができる。
- カレンダーの機能、「食べた物」や「観た作品」に対しての評価ができる機能、評価したものを投稿し「いいね」を送り合う機能が一つのサービスに纏まっている。
- リマインダー機能を使用し、ユーザーに指定してもらった日の朝に「今日は休日です、思い出を残しましょう」というメッセージをLINE通知でリマインドすることができる。

## 機能候補
### MVPリリース時
- ユーザー登録機能 (gem devise)
- カレンダー機能（gem simple_calendar）
- 思い出登録機能
- 思い出の合計を表示させる機能
- 星評価機能（javascript）
- 投稿機能
- 画像スライド表示機能
### 本リリース時
- 毎月の「思い出の合計」を比較するグラフを表示する機能
- タグ機能
- いいね機能
- オートコンプリート検索機能
- リマインダー機能（LINE Messaging API）
- パスワードリセット機能
- [i18n]多言語対応

## 機能の実装方針予定
- Search（検索）:年と月を指定して検索できる
- Filter（フィルター）: 指定したタグを使っている内容を表示する
- Aggregate（集約）: 思い出の合計を表示させる
- LINE Messaging API

## 利用する技術スタック
- Ruby on Rails
- PostgreSQL
- HTML
- CSS
- JavaScript

## 画面遷移図
Figma：https://www.figma.com/design/q4G7Nwu8Wyb56KLD9ks0TM/recollection_calendar_app?node-id=0-1&p=f&t=CC89fp5GsBNClTqM-0

## ER図
ER図：https://drive.google.com/file/d/18CzP48Ffv42-0Ntx27n2pQAB2zTgmDRc/view?usp=sharing