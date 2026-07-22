
ADR-001: ARZIN Platform Bootstrap Architecture

Status: Accepted & Locked
Date: 2026-07-11

Context

نیاز به ایجاد کارخانه‌ی تولید محیط برای پلتفرم آرزین در افق ۱۰ ساله.

Decision

· OS: Ubuntu 24.04 LTS (Primary), Ubuntu 22.04, Debian 12 (Supported)
· معماری لایه‌ای: Shell (OS Adapter) → Ansible (Provisioning) → Docker Compose (Runtime)
· جداسازی مخازن: Bootstrap ≠ Core
· امنیت از روز اول: Vault + .env (بدون Secret در Git)
· قابلیت بازیابی: arzin backup و arzin restore

Amendments

A. جداسازی Ansible از Shell
B. اختیاری کردن K8s Tools در پروفایل developer
C. arzin doctor با چک نسخه‌ای
D. افزودن BACKUP_MANIFEST.json به بکاپ
E. بررسی JAVA_HOME در validate.sh

Signature

CTO: Approved & Locked
