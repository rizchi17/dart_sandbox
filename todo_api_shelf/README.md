# todo_api_shelf
Shelf を使ってDartでサーバーサイドを書いてみる
Dio を使ってクライアント側からAPI呼び出しを行う

# Shelf とは
DartのWebフレームワーク

## 使い方
### 起動
`dart run bin/server.dart`
### 終了
`control+c`

### curlコマンド
#### GET
`curl localhost:8080/todos`

#### POST
`curl -X POST localhost:8080/todos -d '{"text":"test"}'`
- -X: プロキシサーバとしてホストHOSTおよびポートPORTを利用
- -d: POSTリクエストとしてフォームを送信する
- JSONでデータをPOSTするときシングルクォーテーションで囲う

#### PUT
`curl -X PUT localhost:8080/todos/{id} -d '{"text":"test", "done":false}'`

#### DELETE
`curl -X DELETE localhost:8080/todos/{id}`
- {id}のところに1を指定することで todos/1 にDELETEリクエストを送れる

## httpステータスコード
[参考](https://qiita.com/unsoluble_sugar/items/b080a16701946fcfce70)

## Response
### header
サーバーがクライアントにレスポンスを返すときに、レスポンスの内容を補足するために付加される
[参考](https://atmarkit.itmedia.co.jp/ait/articles/1511/27/news013_2.html)

### body
HTTPリクエストメッセージの本文の部分のことで、クライアントがサーバーに送信したいデータを含めることができる

# dio とは
- HTTP通信を行う際に使う
- httpパッケージとの比較: より高度で柔軟性のある機能
