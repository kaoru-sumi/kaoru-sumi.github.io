---
layout: page
lang: ja
og_locale: ja_JP
description: 公立はこだて未来大学教授・角薫とPAHAI研究室へのお問い合わせ。メールアドレス、所在地、大学へのアクセス情報を掲載しています。
title: お問い合わせ
permalink: /ja/contact/
nav: false
---

<p align="right">
  <a href="/contact/">English</a>
</p>

<nav aria-label="日本語ページ" style="display: flex; flex-wrap: wrap; gap: 0.5rem 1rem; margin-bottom: 1.5rem; font-size: 0.9rem;">
  {% for item in site.data.ja_navigation %}
    <a href="{{ item.url | relative_url }}" hreflang="{{ item.lang }}"{% if page.url == item.url %} aria-current="page"{% endif %}>
      {% if page.url == item.url %}<strong>{{ item.title }}</strong>{% else %}{{ item.title }}{% endif %}
    </a>
  {% endfor %}
</nav>

## 新規のお問い合わせ

新規のお問い合わせは，角薫研究室窓口へお願いします．

**角薫研究室窓口：** kaorulab.office [at] gmail.com

メール送信時は [at] を @ に置き換えてください．

大学院進学，研究生，インターン，ポスドク，共同研究など，新規のお問い合わせはこちらへお願いします．

**留学生の方は，[英語版のお問い合わせページ](/contact/)をご確認ください．**

## 既存の共同研究者・関係者の方へ

既存の共同研究者や，すでに角薫教授と直接やり取りのある方は，以下の大学メールアドレスへご連絡ください．

**角 薫**  
公立はこだて未来大学  
システム情報科学部　教授  
PAHAI研究室

〒041-8655  
北海道函館市亀田中野町116番地2

**メール：** kaorus [at] fun.ac.jp

## アクセス

公立はこだて未来大学は，北海道函館市にあります．

<div style="max-width: 850px; margin: 1.5rem auto;">
  <iframe
    src="https://www.google.com/maps?q=公立はこだて未来大学&output=embed"
    width="100%"
    height="400"
    style="border:0;"
    allowfullscreen=""
    loading="lazy"
    referrerpolicy="no-referrer-when-downgrade"
    title="公立はこだて未来大学の地図">
  </iframe>
</div>

**公立はこだて未来大学**  
〒041-8655  
北海道函館市亀田中野町116番地2

<p align="center">
  <img
    src="/assets/img/future_university_hakodate.jpg"
    alt="公立はこだて未来大学"
    style="width: 45%; max-width: 650px; height: auto;"
  >
</p>

[公立はこだて未来大学公式ウェブサイト](https://www.fun.ac.jp/)
