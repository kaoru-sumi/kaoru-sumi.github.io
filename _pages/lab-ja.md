---
layout: page
lang: ja
og_locale: ja_JP
description: 公立はこだて未来大学のPAHAI研究室を紹介します。人とAIのインタラクションを中心に、研究分野、メンバー、研究環境、国際交流、研究室配属・大学院進学の情報を掲載しています。
title: PAHAI研究室
permalink: /ja/lab/
nav: false
---

<p align="right">
  <a href="/lab/">English</a>
</p>

<nav aria-label="日本語ページ" style="display: flex; flex-wrap: wrap; gap: 0.5rem 1rem; margin-bottom: 1.5rem; font-size: 0.9rem;">
  {% for item in site.data.ja_navigation %}
    <a href="{{ item.url | relative_url }}" hreflang="{{ item.lang }}"{% if page.url == item.url %} aria-current="page"{% endif %}>
      {% if page.url == item.url %}<strong>{{ item.title }}</strong>{% else %}{{ item.title }}{% endif %}
    </a>
  {% endfor %}
</nav>

PAHAI研究室では，人とAIが感情や意図を理解し合い，状況に応じて自然に協力できるHuman–AI Interactionの実現を目指しています．

人の感情，非言語行動，生体反応を捉えながら，AIエージェントやロボット，VR・MR環境が，学習，意思決定，行動変容，コミュニケーション，社会的つながりをどのように支援できるかを研究しています．

生成AI・大規模言語モデル，身体性AI，ソーシャルロボット，XR，感情コンピューティング，生体情報計測などを組み合わせ，実際に動作するインタラクティブシステムを開発し，人を対象とした実験によってその効果を検証することを重視しています．

## 研究分野

- Human–AI Interaction / Human–Agent Interaction
- 感情コンピューティング（Affective Computing）
- 身体性AI・ソーシャルエージェント（Embodied AI / Social Agents）
- 説得技術・行動変容（Persuasive Technology / Behavior Change）
- 生成AI・対話エージェント
- VR・MR・XR・メタバース
- 非言語コミュニケーション・マルチモーダルインタラクション
- シリアスゲーム・感情を考慮した学習支援
- 生体情報・脳活動計測

## 受賞

PAHAI研究室の学生・共同研究者は，国際会議，学会研究会，学生コンテストなどで受賞しています．

[主な受賞を見る](/ja/awards/)

## 現在のメンバー

<p align="center">
  <img
    src="/assets/img/pahai_lab_members.png"
    alt="PAHAI研究室メンバー"
    style="width:40%; max-width:580px; height:auto;"
  >
</p>

### 博士後期課程

#### D3

- <img src="/assets/img/flags/ph.svg" alt="" style="width:16px;"> Espulgar Candy Joyce Herminado（フィリピン）

#### D2

- <img src="/assets/img/flags/th.svg" alt="" style="width:16px;"> Pakpoom Chaimook（タイ）
- <img src="/assets/img/flags/ph.svg" alt="" style="width:16px;"> Sandra Mae Famador（フィリピン）

### 修士課程

#### M2

- <img src="/assets/img/flags/jp.svg" alt="日本" style="width:16px;"> 太田 健 / Takeru Ohta
- <img src="/assets/img/flags/ke.svg" alt="" style="width:16px;"> KIPRUTO Andrew Wanyonyi（ケニア）
- <img src="/assets/img/flags/jp.svg" alt="日本" style="width:16px;"> 嵯峨 京介 / Kyosuke Saga
- <img src="/assets/img/flags/jp.svg" alt="日本" style="width:16px;"> 長澤 颯音 / Hayato Nagasawa
- <img src="/assets/img/flags/my.svg" alt="" style="width:16px;"> BINTI ZULKARNAIN Iffah Nurain（マレーシア）

#### M2（9月入学）

- <img src="/assets/img/flags/bd.svg" alt="" style="width:16px;"> Md. Abdul Momin（バングラデシュ）

#### M1

- <img src="/assets/img/flags/jp.svg" alt="日本" style="width:16px;"> 鈴木 隼 / Shun Suzuki
- <img src="/assets/img/flags/jp.svg" alt="日本" style="width:16px;"> 中野 大地 / Daichi Nakano
- <img src="/assets/img/flags/bd.svg" alt="" style="width:16px;"> JOSEPH Mushfiqur Rahman（バングラデシュ）
- <img src="/assets/img/flags/bd.svg" alt="" style="width:16px;"> HOSSAIN Md. Ismail（バングラデシュ）

#### M1（9月入学）

- <img src="/assets/img/flags/cn.svg" alt="" style="width:16px;"> 王 智偉 / Wang Zhiwei（中国）

### 学部4年

- <img src="/assets/img/flags/jp.svg" alt="日本" style="width:16px;"> 磯角 翔太 / Shota Isokado
- <img src="/assets/img/flags/jp.svg" alt="日本" style="width:16px;"> 佐藤 光将 / Kosuke Sato
- <img src="/assets/img/flags/jp.svg" alt="日本" style="width:16px;"> 菅原 温太 / Haruta Sugawara
- <img src="/assets/img/flags/jp.svg" alt="日本" style="width:16px;"> 阿部 優太 / Yuta Abe
- <img src="/assets/img/flags/jp.svg" alt="日本" style="width:16px;"> 木村 了 / Satoru Kimura
- <img src="/assets/img/flags/jp.svg" alt="日本" style="width:16px;"> 黒田 凌大 / Ryota Kuroda
- <img src="/assets/img/flags/jp.svg" alt="日本" style="width:16px;"> 佐藤 陽翔 / Haruto Sato

## 研究環境

研究室では，Furhatソーシャルロボット，VR・MRヘッドセット，生成AI・大規模言語モデル，生体センサ，脳波計測装置などを活用し，人とAIのインタラクションを実際に体験できる研究システムを開発しています．

研究では，アイデアの提案からシステムの設計・実装，ユーザ実験，データ解析までを一貫して行います．AIやXRを「使う」だけでなく，自ら新しいインタラクションを作り，人がどのように感じ，行動し，AIとの関係を形成するのかを実験的に明らかにすることを重視しています．

学生の研究成果は，国内研究会に加え，Human–AI Interaction，Affective Computing，VR・MR，Persuasive Technologyなどの国際会議や学術論文での発表を目指します．

## 研究室配属・大学院進学を希望する方へ

PAHAI研究室では，AIを利用するだけでなく，「人とAIの新しい関係を自分で考え，実際にシステムとして作り，実験によって確かめてみたい」という学生を歓迎しています．

AI，ロボット，VR・MR，ゲーム，感情コンピューティング，Human–AI Interactionなどに興味があり，プログラミング，インタラクティブシステム開発，ユーザ実験，データ解析に挑戦したい方に適した研究室です．

研究テーマは，学生自身の興味を大切にしながら，研究室で進めているHuman–AI Interaction，身体性AI，感情・非言語行動，Persuasive Technology，XR，シリアスゲームなどの研究と結び付けて発展させていきます．

学部の研究室配属，卒業研究，大学院進学，研究生，留学生としての受入れを検討している方は，公立はこだて未来大学の教員紹介ページをご覧ください．出願方法，応募条件，必要書類，奨学金などの詳細を掲載しています．

- [公立はこだて未来大学 教員紹介ページ](https://www.fun.ac.jp/faculty/sumi-kaoru/)
- [研究プロジェクトを見る](/ja/research/)
- [お問い合わせ](/ja/contact/)

---

## 国際的な研究コミュニティ

PAHAI研究室では，日本人学生と留学生がともに研究に取り組み，海外の大学・研究機関とも継続的に共同研究を進めています．これまでアジア，ヨーロッパ，北米など多くの国・地域から，正規学生，研究生，短期研究学生，研究者を受け入れてきました．

異なる文化的背景や専門分野を持つメンバーが，同じ研究テーマについて議論し，システムを開発し，国際的に研究成果を発信することを，本研究室の大きな特徴の一つとしています．

<p align="center">
  <a href="/assets/img/global_pahai_network.png" target="_blank">
    <img
      src="/assets/img/global_pahai_network.png"
      alt="Global PAHAI Network"
      style="width:65%; max-width:900px; height:auto; cursor:zoom-in;"
    >
  </a>
</p>

<p align="center">
<small>クリックすると拡大表示されます．</small>
</p>

### これまで正規課程に在籍した学生の出身国・地域

- <img src="/assets/img/flags/jp.svg" alt="" style="width:16px;"> 日本
- <img src="/assets/img/flags/th.svg" alt="" style="width:16px;"> タイ
- <img src="/assets/img/flags/ph.svg" alt="" style="width:16px;"> フィリピン
- <img src="/assets/img/flags/eg.svg" alt="" style="width:16px;"> エジプト
- <img src="/assets/img/flags/id.svg" alt="" style="width:16px;"> インドネシア
- <img src="/assets/img/flags/tw.svg" alt="" style="width:16px;"> 台湾
- <img src="/assets/img/flags/cn.svg" alt="" style="width:16px;"> 中国
- <img src="/assets/img/flags/ke.svg" alt="" style="width:16px;"> ケニア
- <img src="/assets/img/flags/my.svg" alt="" style="width:16px;"> マレーシア
- <img src="/assets/img/flags/bd.svg" alt="" style="width:16px;"> バングラデシュ

### 研究生・短期研究・交流

- <img src="/assets/img/flags/in.svg" alt="" style="width:16px;"> インド
- <img src="/assets/img/flags/us.svg" alt="" style="width:16px;"> アメリカ
- <img src="/assets/img/flags/mx.svg" alt="" style="width:16px;"> メキシコ
- <img src="/assets/img/flags/fr.svg" alt="" style="width:16px;"> フランス
- <img src="/assets/img/flags/tw.svg" alt="" style="width:16px;"> 台湾

国内外から意欲ある学生・研究者を歓迎しています．

### 国際共同研究

- <img src="/assets/img/flags/fr.svg" alt="" style="width:16px;"> フランス
- <img src="/assets/img/flags/ph.svg" alt="" style="width:16px;"> フィリピン
- <img src="/assets/img/flags/th.svg" alt="" style="width:16px;"> タイ
- <img src="/assets/img/flags/ca.svg" alt="" style="width:16px;"> カナダ
- <img src="/assets/img/flags/us.svg" alt="" style="width:16px;"> アメリカ
- <img src="/assets/img/flags/my.svg" alt="" style="width:16px;"> マレーシア

PAHAI研究室では，国内外の大学・研究機関・企業と共同研究を進めています．
