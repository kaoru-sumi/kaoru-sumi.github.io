---
layout: page
permalink: /publications/
title: Publications
description: Recent and selected publications.
nav: true
nav_order: 3
---

<!-- _pages/publications.md -->

The home page highlights a small set of representative works as **Featured Publications**. This page provides recent publications together with a broader selection of earlier work.

Publications are organized into a recent book and book chapters, edited conference proceedings, recent publications, and selected earlier works.

For a complete publication record, please see my [ORCID profile](https://orcid.org/0000-0002-0514-1510) and [official Future University Hakodate faculty page](https://www.fun.ac.jp/en/faculty/sumi-kaoru/).

{% include bib_search.liquid %}

## Book

<div class="publications">

{% bibliography --query @book[category=book2026] %}

</div>

## Book Chapters

<div class="publications">

{% bibliography --query @inbook[category=book2026] %}

</div>

## Edited Conference Proceedings

<div class="publications">

{% bibliography --query @proceedings --style assets/csl/edited-proceedings.csl --template {{reference}} <div class="links"><a href="https://doi.org/{{entry.doi}}" class="btn btn-sm z-depth-0" role="button">DOI</a></div> %}

</div>

## Recent Publications

<div class="publications">

{% bibliography --query !@proceedings[year>=2024 && category!=book2026] %}

</div>

## Selected Earlier Publications

<div class="publications">

{% bibliography --query @*[selected=true && year<2024] %}

</div>
