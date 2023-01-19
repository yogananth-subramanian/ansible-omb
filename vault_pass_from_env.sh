#!/bin/bash

if [ -z "${VAULT_PASS:-}" ]; then
    echo "\$VAULT_PASS not set" >&2
    exit 1
else
    echo "$VAULT_PASS"
fi
