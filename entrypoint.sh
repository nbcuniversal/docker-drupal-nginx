#!/bin/bash -e

if [ -d /etc/template.d ]; then
  if [ -z "$siteInternalUrl" ]; then
    export siteInternalUrl="dimpl.cluster.local"
  fi
  echo "==> Generating origin vhost ${siteInternalUrl}"
  envsubst '\$siteInternalUrl' < /etc/template.d/origin.conf.tpl > /etc/nginx/conf.d/origin.conf

  if [ -z "$siteExternalUrl" ]; then
    export siteExternalUrl="dimpl.cluster.pub"
  fi
  echo "==> Generating external vhost ${siteExternalUrl}"
  envsubst '\$siteExternalUrl' < /etc/template.d/external.conf.tpl > /etc/nginx/conf.d/external.conf
fi

echo '==> Starting NGINX'
nginx -g 'daemon off;'
