#!/bin/bash
# /etc/profile.d/set_prompt.sh

# CONTAINER_NAME 환경 변수가 설정되어 있으면 PS1을 수정
if [ -n "$CONTAINER_NAME" ]; then
  export PS1="\u@$CONTAINER_NAME:\w\$ "
fi
