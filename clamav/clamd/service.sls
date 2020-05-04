# -*- coding: utf-8 -*-
# vim: ft=sls

{%- from "clamav/map.jinja" import clamav with context %}
{%- set clamd = clamav.get('clamd', {}) %}

include:
  - .config

# It takes a long time to get the service to start and sometimes, especially on
# slower machines clamd scan takes too long and systemd terminates the process
# early and therefore fails to start the service.
clamd_service_override:
  file.managed:
    - name: '/etc/systemd/system/{{ clamd.service_name }}.d/override.conf'
    - source: 'salt://clamav/files/systemd-clamd-scan-override.conf'
    - user: root
    - group: root
    - mode: 0644

clamd_daemon:
  service.{{ clamd.service_state }}:
    - name: {{ clamd.service_name }}
    - enable: {{ clamd.service_onboot }}
    - watch:
      - file: clamd_config
      - file: clamd_service_override
    - require:
      - file: clamd_config
      - pkg: clamd_pkg
