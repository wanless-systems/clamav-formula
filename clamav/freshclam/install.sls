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

{% if clamav.log_folder is defined %}
{{clamav.log_folder}}:
  file.directory:
    - makedirs: true
 {%- if clamav.freshclam.config.UpdateLogFile is defined %}
    - user: {{clamav.clamd.config.User}}
    - group: virusgroup
    - mode: 775
{% endif %}
{% endif %}

/var/log/clamav:
  file.directory:
    group: virusgroup
    mode: 775
