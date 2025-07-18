- name: install packages
  hosts: localhost
  become: yes
  tasks:
  - name: install package
    ansible.builtin.yum:
      name: "{{item}}"
      state: installed
    #list of string
    loop:
    - nginx
    - postfix