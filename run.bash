#!/bin/bash
if [ ! -z $INPUT_ENVIRONMENT_NAME ]; then
  echo "uses environment name $INPUT_ENVIRONMENT_NAME"
  ENVIRONMENT_NAME_UPPER=${INPUT_ENVIRONMENT_NAME^^}
  ENVIRONMENT_NAME_LOWER=${INPUT_ENVIRONMENT_NAME^l}

  vars=($(compgen -v DEFAULT))
  vars+=($(compgen -v default))
  vars+=($(compgen -v $ENVIRONMENT_NAME_LOWER))
  vars+=($(compgen -v $ENVIRONMENT_NAME_UPPER))

  # Override environment specific settings
  for name in "${vars[@]}"; do
    echo 'use override variable' $name
    override=$(echo ${name//$ENVIRONMENT_NAME_LOWER'_'/})
    override=$(echo ${override//$ENVIRONMENT_NAME_UPPER'_'/})
    override=$(echo ${override//DEFAULT'_'/})
    override=$(echo ${override//default'_'/})
    echo 'becomes variable' $override
    if [ $INPUT_MODE = "env" ]; then
      echo "${override}=${!name}" >> $GITHUB_ENV
    fi
    if [ $INPUT_MODE = "output" ]; then
      echo "${override}=${!name}" >> $GITHUB_OUTPUT
    fi
  done
fi
