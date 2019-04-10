# -*- coding: utf-8 -*-
# vim: ft=sls

{% if (clamav.log_folder is defined) %}
{{clamav.log_folder}}:
  file.directory:
    - makedirs: true
 {%- if clamav.freshclam.config.UpdateLogFile is defined %}
    - user: {{clamav.clamd.config.User}}
{% endif %}
{% endif %}


include:
  - clamav.freshclam
  - clamav.clamd
