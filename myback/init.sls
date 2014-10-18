#!jinja|yaml

{% from 'myback/defaults.yaml' import rawmap_osfam with context %}
{% set datamap = salt['grains.filter_by'](rawmap_osfam, merge=salt['pillar.get']('myback:lookup')) %}

include: {{ datamap.sls_include|default([]) }}
extend: {{ datamap.sls_extend|default({}) }}

myback:
  file:
    - managed
    - name: /usr/bin/myback
    - source: salt://myback/files/myback
    - mode: 700
    - user: root
    - group: root
    - template: jinja
