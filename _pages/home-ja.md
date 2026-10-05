---
layout: page
lang: ja
og_locale: ja_JP
description: 公立はこだて未来大学教授・角薫の公式サイト。感情コンピューティング、人とAIのインタラクション、説得技術、XR、シリアスゲームの研究と活動を紹介します。
title: ホーム
permalink: /ja/
nav: false
---

<p align="right">
  <a href="/">English</a>
</p>

<nav aria-label="日本語ページ" style="display: flex; flex-wrap: wrap; gap: 0.5rem 1rem; margin-bottom: 1.5rem; font-size: 0.9rem;">
  {% for item in site.data.ja_navigation %}
    <a href="{{ item.url | relative_url }}" hreflang="{{ item.lang }}"{% if page.url == item.url %} aria-current="page"{% endif %}>
      {% if page.url == item.url %}<strong>{{ item.title }}</strong>{% else %}{{ item.title }}{% endif %}
    </a>
  {% endfor %}
</nav>

<h2 id="角-薫" style="font-size: 2.5rem;">角 薫</h2>

公立はこだて未来大学　システム情報科学部　教授

感情コンピューティング，Human–AI Interaction，Human–Agent Interaction，説得技術，VR・MR・XR，シリアスゲーム，感情学習を中心に研究しています．

人間の感情，行動，身体性，非言語コミュニケーションを理解し，人に寄り添い，学習や行動変容を支援するAIおよびインタラクティブシステムの研究開発に取り組んでいます．
[公立はこだて未来大学 教員紹介ページ](https://www.fun.ac.jp/faculty/sumi-kaoru/)

## 主な研究分野

- Persuasive and Affective Human–AI Interaction
- 感情コンピューティング
- Human–AI Interaction・Human–Agent Interaction
- 身体性を持つAIとソーシャルエージェント
- VR・MR・XR
- シリアスゲームと感情学習
- 非言語コミュニケーション
- 生体・神経情報計測

## 最近の活動

- **キーノート講演：** 2026年10月29～31日にインド・ハイデラバードで開催される[IEEE TEMSMET 2026](https://r6.ieee.org/scv-tems/ieee-temsmet-2026/)にてキーノート講演を行います．
- **Open Lab：** 2026年10月19日午後，公立はこだて未来大学でPAHAI研究室のOpen Labを開催します．学生が研究システムやデモを紹介します．
- **論文受理：** 2026年9月30日，Ahmed SalemとKaoru Sumiの論文「Effects of Robot Personality and Facial Appearance on Embarrassment in HRI」がJournal of Visualized Experiments（JoVE）に受理されました．
- **国際会議論文採択：** 2026年，Daichi NakanoとKaoru Sumiの論文「The Impact of Nonverbal Information Visualization on Dialogue and Perceived Understanding in the Metaverse」が2026 IEEE International Symposium on Emerging Metaverse (ISEMV 2026)にFull Paperとして採択されました．
- **国際会議論文採択：** 2026年，Shuo MaoとKaoru Sumiの論文「Emotion-Adaptive Music Generation in Games: Comparing Dynamic and Real-Time AI-Generated Music」が15th EAI International Conference: ArtsIT, Interactivity & Game Creation (EAI ArtsIT 2026)に採択されました．
- **論文掲載：** 2026年9月16日，Pakpoom ChaimookとKaoru Sumiの論文「[DXSP: gesture-only temporal localization of decisive moments in dyadic persuasion](https://doi.org/10.3389/frai.2026.1928901)」がFrontiers in Artificial Intelligence（Vol. 9）に掲載されました．
- **新刊書籍：** 2026年6月，CRC Press / Taylor & Francisより，[_Affective Learning and Serious Games_](https://www.routledge.com/Affective-Learning-and-Serious-Games/Sumi/p/book/9781041322627)を刊行しました．
- **招待講演：** 2026年8月，IEEE RO-MAN 2026の[TED-HRI Workshop](https://sites.google.com/view/ted-hri/program?authuser=0)にて招待講演を行いました．
- **国際会議General Chair：** 2026年3月，函館で開催された[Persuasive 2026](https://2026.persuasivetech.org/)のGeneral Chairを務めました．
- **国際会議論文集：** Springer LNCS 16476，[_Persuasive Technology: PERSUASIVE 2026 Proceedings_](https://link.springer.com/book/10.1007/978-3-032-19687-3)のVolume Editorを務めました．
- **Guest Editor：** Frontiers in Artificial IntelligenceのResearch Topic，[“Next-Generation Persuasive Technologies for Human–AI Interaction and Behavior Change”](https://www.frontiersin.org/research-topics/75786/next-generation-persuasive-technologies-for-human-ai-interaction-and-behavior-change)．
- **Guest Editor：** JoVE Methods Collection，[“Interactive Technologies for Behavior Change and Emotional Engagement”](https://app.jove.com/methods-collections/3756)．
- **受賞：** PAHAI研究室の学生・共同研究者による主な受賞を掲載しています．[受賞一覧を見る](/ja/awards/)

## PAHAI研究室

PAHAI研究室では，感情的・説得的Human–AI Interactionを中心に，人間中心AI，身体性を持つエージェント，XR，シリアスゲーム，生体情報計測に関する研究を行っています．

[PAHAI研究室の紹介はこちら](/ja/lab/)

## 研究業績

研究業績は英語版のPublicationsページに掲載しています．

[Publications](/publications/)
