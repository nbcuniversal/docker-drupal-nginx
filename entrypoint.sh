#!/bin/bash -e

if [ -d /etc/template.d ]; then
  if [ -z "$siteInternalUrl" ]; then
    export siteInternalUrl="dimpl.cluster.local"
  fi
  echo "==> Generating configuration ${siteInternalUrl}"
  echo "  + Using origin ${siteInternalUrl}"
  echo "  + Using external domain ${siteExternalUrl}"
  envsubst '\$siteInternalUrl' < /etc/template.d/drupal.conf.tpl > /etc/nginx/conf.d/drupal.conf
fi

echo '==> Starting NGINX'
nginx -g 'daemon off;'
