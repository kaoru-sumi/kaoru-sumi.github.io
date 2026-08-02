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

## 主な研究テーマ

- Human–AI Interaction
- Human–Agent Interaction
- 感情コンピューティング
- 身体性を持つAI（Embodied AI）
- Mixed Reality（MR）エージェント
- ソーシャルロボット
- 四足エージェント
- ファントムセンス
- 球体ディスプレイ
- シリアスゲーム
- 非言語コミュニケーション
- 生体・神経情報計測

## 研究スタイル

本研究室では，以下を組み合わせながら研究を進めています．

- AI・機械学習
- Unityによるシステム開発
- VR・MRアプリケーション開発
- ロボット・エージェント開発
- ユーザ実験
- 心理評価
- 生体信号・脳波計測

システムを開発するだけでなく，人がどのように感じ，行動し，学習し，AIを信頼するのかを実験によって明らかにすることを重視しています．

## 主な研究プロジェクト

以下は現在進めている代表的な研究プロジェクトです．
各プロジェクトの詳細は英語ですが，研究内容や代表論文をご覧いただけます．

<div class="projects">

{% if site.enable_project_categories and page.display_categories %}

  {% for category in page.display_categories %}

    <h2 class="category">{{ category }}</h2>

    {% assign categorized_projects = site.projects
      | where: "category", category %}

    {% assign sorted_projects = categorized_projects
      | sort: "importance" %}

    {% if page.horizontal %}

      <div class="container">
        <div class="row row-cols-1">

          {% for project in sorted_projects %}
            {% include projects_horizontal.liquid %}
          {% endfor %}

        </div>
      </div>

    {% else %}

      <div class="grid">

        {% for project in sorted_projects %}
          {% include projects.liquid %}
        {% endfor %}

      </div>

    {% endif %}

  {% endfor %}

{% else %}

  {% assign sorted_projects = site.projects | sort: "importance" %}

  {% if page.horizontal %}

    <div class="container">
      <div class="row row-cols-1">

        {% for project in sorted_projects %}
          {% include projects_horizontal.liquid %}
        {% endfor %}

      </div>
    </div>

  {% else %}

    <div class="grid">

      {% for project in sorted_projects %}
        {% include projects.liquid %}
      {% endfor %}

    </div>

  {% endif %}

{% endif %}

</div>
{% assign sorted_projects = site.projects | sort: "importance" %}

{% if page.horizontal %}

{% for project in sorted_projects %} {% include projects_horizontal.liquid %} {% endfor %}
{% else %}
{% for project in sorted_projects %} {% include projects.liquid %} {% endfor %}
{% endif %} {% endif %}
