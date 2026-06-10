#!/usr/bin/env bash
set -euo pipefail

APP_ROOT="${APP_ROOT:-/usr/share/nginx/html}"
APP_VERSION="${APP_VERSION:-unknown}"
SOURCE_DIR="${SOURCE_DIR:-site}"

if command -v dnf >/dev/null 2>&1; then
  dnf -y install nginx
else
  yum -y install nginx
fi

rm -rf "${APP_ROOT:?}/"*
cp -R "${SOURCE_DIR}/." "${APP_ROOT}/"

cat >"${APP_ROOT}/release.json" <<EOF
{
  "application": "foggykitchen-instance-group-hello-world",
  "version": "${APP_VERSION}",
  "host": "$(hostname)"
}
EOF

if command -v firewall-cmd >/dev/null 2>&1; then
  firewall-cmd --permanent --add-service=http || true
  firewall-cmd --reload || true
fi

systemctl enable nginx
systemctl restart nginx
