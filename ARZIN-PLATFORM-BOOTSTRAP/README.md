# ARZIN PLATFORM BOOTSTRAP v1.0

**کارخانه‌ی تولید و نگهداری محیط اجرایی پلتفرم آرزین**

## اصول معماری
- **سیستم‌عامل مرجع:** Ubuntu 24.04 LTS
- **سازگاری:** Ubuntu 22.04 LTS و Debian 12 Bookworm
- **جداسازی لایه‌ها:** OS Adapter (Shell) → Ansible (Provisioning) → Docker Compose (Runtime)
- **امنیت:** عدم ذخیره‌سازی Secrets در Git، استفاده از Vault و 
