<img width="500" alt="PinCIM_logo" src="app/assets/images/PinCIM-logo&title_bg-none.png">

# PinCIM
顧客をマップベースで管理する営業支援アプリケーションです。
## 概要
PinCIMは、顧客が全国各地に散在する営業マン向けの顧客管理ツールです。
- マップ上で顧客の位置や優先順位を視覚的に確認でき、顧客情報の閲覧が可能
- カレンダーで訪問記録と有効なタスクを確認できる
- 訪問記録の活動内容を、指定した期間で集計できる

※ヒヤリングしたクライアント向けの設計・開発となっているため、一部個人に特化したツールとなっております。

### テーマを選んだ理由
学んだ技術で、**実際に他人を支援するツールを作りたい**と思ったためです。  
ヒヤリングで要件を抽出して、設計・開発し、運用時のフィードバックより、改善を続けています。

### 主な利用シーン
- 営業計画
- 訪問記録の管理と活動の集計
- 訪問時に得られたタスクの管理

## 設計書
**【要件定義書】**
- [要件定義書](https://docs.google.com/document/d/1VYsiHaBlQYy3CG8iiQNcKWAK1yWfmMwUOGHk4np_dGI/edit?usp=sharing) (google ドキュメント)

**【データベース設計】**
- [ER図](https://drive.google.com/file/d/1UKf_UOWui88kb5k9TbKfvhMiKuVJ-Adn/view?usp=sharing) (diagrams net)
- [テーブル定義書](https://docs.google.com/spreadsheets/d/12tuiDZNI5nJ7PYf06kyu3CpLgYO7GenQqfcQFNQ-ewk/edit?usp=sharing) (google スプレッドシート)

**【アプリケーション詳細設計】**
- [アプリケーション詳細設計](https://docs.google.com/spreadsheets/d/1ZN_7u0ZNkt1S25o69UGqhw-xEE71RfWZtR7fF3mqyQs/edit?usp=sharing) (google スプレッドシート)

**【画面設計】**
- [ワイヤーフレーム](https://drive.google.com/file/d/133BDMoWBbXNF28HqKPbfqE9BGPjeA46L/view?usp=sharing) (diagrams net)
- [UI Flows](https://drive.google.com/file/d/1ojvj6mcK18FXXl6hA1zko7_k5K9VaEqi/view?usp=sharing) (diagrams net)

※非同期通信を順次実装中のため、画面設計の内容は更新が間に合っていない可能性があります。

## 機能一覧
- [機能一覧](https://docs.google.com/spreadsheets/d/1A6S3yAGR7iKuectLNO92N2Kpv95bOUcJ2s8PFfZfkvQ/edit?usp=sharing)(google スプレッドシート)
- [チャレンジ要素一覧](https://docs.google.com/spreadsheets/d/1A3z6Wkq6ry9K3m2mlBMgdLitNztRJ3YCQJdI46ocBzQ/edit?usp=sharing) (google スプレッドシート)

## 開発環境
- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9

## 使用素材
[google map custom marker](https://sites.google.com/site/gmapsdevelopment/)
