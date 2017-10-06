#!/bin/bash -e

if [ -d /etc/template.d ]; then
  if [[ -z "$siteInternalUrl" ]]; then
    export siteInternalUrl="drupal.cluster.local"
  fi

  if [[ -z "$siteExternalUrl" ]]; then
    export siteExternalUrl="drupal.cluster.ext"
  fi
  
  echo "==> Generating configuration ${siteInternalUrl}"
  echo "  + Using origin ${siteInternalUrl}"
  echo "  + Using external domain ${siteExternalUrl}"
  envsubst '\$siteInternalUrl,\$siteExternalUrl' < /etc/template.d/drupal.conf.tpl > /etc/nginx/conf.d/drupal.conf
fi

echo '==> Starting NGINX'
nginx -g 'daemon off;'
