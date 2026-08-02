---
layout: page
title: Research
permalink: /research/
nav: true
nav_order: 2
---
<p align="right">
  <a href="/ja/research/">日本語 / Japanese</a>
</p>

My research explores how intelligent and embodied technologies can understand human emotions and behavior, support learning and behavior change, and create meaningful interactions between humans and AI.


## Affective Computing and Human–AI Interaction

We investigate computational methods and interactive systems that recognize, interpret, and respond to human emotions and nonverbal behavior.

## Embodied AI and Social Agents

Our research examines how virtual agents, robots, and embodied AI systems communicate through appearance, gaze, gesture, interpersonal distance, and emotional expression.

## Persuasive Technology and Behavior Change

We design interactive technologies that support motivation, learning, well-being, and positive behavior change.

## Virtual, Mixed, and Extended Reality

We study social interaction, embodiment, presence, phantom sensations, and intelligent agents in VR, MR, and XR environments.

## Serious Games and Affective Learning

We develop and evaluate serious games and interactive learning environments that combine emotion, narrative, intelligent agents, and immersive media.

## Nonverbal Communication and Physiological Sensing

We analyze gesture, facial expression, posture, interpersonal behavior, ECG, EDA, EEG, and other physiological signals to understand affective and social interaction.

## Current Research Topics

- Emotion-aware and persuasive embodied agents
- Human–AI trust and adaptive nonverbal behavior
- MR agents for learning, social support, and decision-making
- Phantom sensations and embodiment in social VR
- Serious games and affective learning
- Cross-cultural analysis of gesture and emotion
- Physiological sensing in immersive environments
<!-- pages/projects.md -->
<div class="projects">
{% if site.enable_project_categories and page.display_categories %}
  <!-- Display categorized projects -->
  {% for category in page.display_categories %}
  <a id="{{ category }}" href=".#{{ category }}">
    <h2 class="category">{{ category }}</h2>
  </a>
  {% assign categorized_projects = site.projects | where: "category", category %}
  {% assign sorted_projects = categorized_projects | sort: "importance" %}
  <!-- Generate cards for each project -->
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
  {% endfor %}

{% else %}

<!-- Display projects without categories -->

{% assign sorted_projects = site.projects | sort: "importance" %}

  <!-- Generate cards for each project -->

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
{% endif %}
</div>
