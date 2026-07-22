#!/usr/bin/env bash
set -euo pipefail
echo "================================="
echo " ARZIN SECRET VALIDATOR"
echo "================================="

FAILED=0

echo "[1/3] Checking tracked secret files..."
if git ls-files 2>/dev/null | grep -E '\.(env|secret|key|pem|crt|jks)$' | grep -v '\.template$' | grep -v 'profiles/.*\.env$' | grep -v 'secrets/README.md' >/dev/null 2>&1; then
    echo "[FAIL] Secret files tracked in Git:"
    git ls-files 2>/dev/null | grep -E '\.(env|secret|key|pem|crt|jks)$' | grep -v '\.template$'
    FAILED=1
else
    echo "[OK] No secret files tracked"
fi

echo "[2/3] Checking for hardcoded secrets in code..."
if git grep -n -i -E '(password|secret|token|key|credential)' 2>/dev/null | grep -v '.template' | grep -v 'profiles/.*\.env' | grep -v '.md' | grep -v 'change-me' | head -5 >/dev/null; then
    echo "[WARN] Potential hardcoded secrets found"
    git grep -n -i -E '(password|secret|token|key|credential)' 2>/dev/null | grep -v '.template' | grep -v 'profiles/.*\.env' | grep -v '.md' | head -5
    FAILED=1
else
    echo "[OK] No obvious hardcoded secrets"
fi

echo "[3/3] Checking .gitignore..."
if grep -q "\.env$" .gitignore 2>/dev/null && grep -q "secrets/" .gitignore 2>/dev/null; then
    echo "[OK] .gitignore properly configured"
else
    echo "[FAIL] .gitignore missing secret protection"
    FAILED=1
fi

echo
if [ $FAILED -eq 0 ]; then
    echo "✅ SECURITY VALIDATION: PASSED"
else
    echo "❌ SECURITY VALIDATION: FAILED"
fi
exit $FAILED
