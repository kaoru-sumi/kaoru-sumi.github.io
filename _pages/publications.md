---
layout: page
permalink: /publications/
title: Publications
description: Recent and selected publications.
nav: true
nav_order: 3
---

<!-- _pages/publications.md -->

<!-- Bibsearch Feature -->

Publications are organized into recent publications and selected earlier works. For a complete publication record, please see my [ORCID profile](https://orcid.org/0000-0002-0514-1510) and [official Future University Hakodate faculty page](https://www.fun.ac.jp/en/faculty/sumi-kaoru/).

{% include bib_search.liquid %}

## Recent Publications

<div class="publications">

{% bibliography --query @*[year>=2024] %}

</div>

## Selected Earlier Publications

<div class="publications">

{% bibliography --query @*[selected=true && year<2024] %}

</div>
