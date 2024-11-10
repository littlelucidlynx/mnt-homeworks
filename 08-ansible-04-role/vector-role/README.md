vector-role
=========

This role can install Vector on EL

Role Variables
--------------

| vars | description |
|---|---|
| vector_version | version of vector to install |
| vector_url | url to download vector |
| vector_config_dir | directory with vector config |
| clickhouse_db_name | database name on clickhouse service |
| clickhouse_table_name | table name on clickhouse service |

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: vector-role }

License
-------

GPL-2.0-or-later

Author Information
------------------

littlelucidlynx
