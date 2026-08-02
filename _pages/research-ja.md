---
layout: page
title: 研究
permalink: /ja/research/
nav: true
nav_order: 2
horizontal: false
---

<p align="right">
  <a href="/research/">English</a>
</p>

PAHAI研究室では，人とAIが自然に理解し合い，信頼関係を築き，共に生活・学習・仕事ができる未来のHuman–AI Interactionを研究しています．

AI，ロボット，XR（VR・MR），感情コンピューティング，生体情報計測などを組み合わせ，人に寄り添い，人の学習や行動変容を支援するインタラクティブシステムを開発しています．

## 感情コンピューティングとHuman–AI Interaction

人間の感情や非言語行動を認識・解釈し，それらに応答する計算手法とインタラクティブシステムを研究しています．

## 身体性を持つAIとソーシャルエージェント

バーチャルエージェント，ロボット，身体性を持つAIが，外見，視線，ジェスチャー，対人距離，感情表現を通してどのようにコミュニケーションするかを研究しています．

## 説得技術と行動変容

人の意欲，学習，ウェルビーイング，望ましい行動変容を支援するインタラクティブ技術を設計しています．

## VR・MR・XR

VR・MR・XR環境における社会的インタラクション，身体性，存在感，ファントムセンス，知的エージェントを研究しています．

## シリアスゲームと感情学習

感情，物語，知的エージェント，没入型メディアを組み合わせたシリアスゲームとインタラクティブ学習環境を開発・評価しています．

## 非言語コミュニケーションと生体情報計測

ジェスチャー，表情，姿勢，対人行動，ECG，EDA，EEGなどを分析し，感情的・社会的インタラクションを明らかにします．

## 現在の研究トピック

- 感情を理解し，説得や支援を行う身体性エージェント
- Human–AI間の信頼と適応的な非言語行動
- 学習，社会的支援，意思決定のためのMRエージェント
- ソーシャルVRにおけるファントムセンスと身体性
- シリアスゲームと感情学習
- ジェスチャーと感情表現の文化比較
- 没入型環境における生体情報計測

## 主な研究プロジェクト

<div class="projects">

{% assign sorted_projects = site.projects | sort: "importance" %}

{% if page.horizontal %}

<div class="container">
  <div class="row row-cols-1 row-cols-md-2">
    {% for project in sorted_projects %}
      {% include projects_horizontal.liquid %}
    {% endfor %}
  </div>
</div>

{% else %}

<div class="row row-cols-1 row-cols-md-3">
  {% for project in sorted_projects %}
    {% include projects.liquid %}
  {% endfor %}
</div>

{% endif %}

</div>
