# -*- coding: utf-8 -*-
# vim: ft=sls

{%- from "clamav/map.jinja" import clamav with context %}
{%- set freshclam = clamav.get('freshclam', {}) %}

freshclam_pkg:
  pkg.installed:
    - pkgs:
{%- for pkg in freshclam.pkgs %}
      - {{ pkg }}
{%- endfor %}

{% if (clamav.freshclam.config.UpdateLogFile is defined) and clamav.freshclam.config.UpdateLogFile is defined %}
{{clamav.freshclam.config.UpdateLogFile}}:
  file.directory:
    - makedirs: true
    - user: {{clamav.clamd.config.User}}
