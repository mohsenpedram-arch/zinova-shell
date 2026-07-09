# zinova-shell
«مهندسی محیط توسعه (Developer Workstation Engineering)»

 وارد «مهندسی محیط توسعه (Developer Workstation Engineering)» می‌شویم. اتفاقا این بخش اگر یک بار درست طراحی شود، سال‌ها وقتت را نجات می‌دهد. انسان‌ها معمولا این قسمت را تا وقتی خراب نشود جدی نمی‌گیرند. بعد یک شب تا صبح با Bash دعوا می‌کنند و تازه یادشان می‌افتد فایل‌های startup هم وجود دارند.

پیشنهاد می‌کنم شل ZINOVA را نسخه‌بندی کنیم و دیگر هیچ چیز مستقیماً داخل `~/.bashrc` ننویسیم.

---

# ساختار پیشنهادی

```
~/
├── .bashrc
├── .zinova/
│   ├── prompt.sh
│   ├── aliases.sh
│   ├── functions.sh
│   ├── env.sh
│   ├── completion.sh
│   ├── theme.sh
│   ├── backup.sh
│   └── version
```

در نتیجه `.bashrc` فقط چند خط خواهد داشت:

```bash
# ZINOVA Shell

[ -f ~/.zinova/env.sh ] && source ~/.zinova/env.sh
[ -f ~/.zinova/aliases.sh ] && source ~/.zinova/aliases.sh
[ -f ~/.zinova/functions.sh ] && source ~/.zinova/functions.sh
[ -f ~/.zinova/prompt.sh ] && source ~/.zinova/prompt.sh
```

اگر روزی پرامپت خراب شد فقط `prompt.sh` را عوض می‌کنیم.

---

# aliases.sh

تمام alias ها

```
zc
zp
zz
zeis
zqa
zsbx
uu
c
e
...
```

همه اینجا.

---

# functions.sh

اینجا دیگر alias نیست.

مثل

```
zbackup
zhealth
zdoctor
zpull
zpush
zrepo
zstatus
zclean
```

---

# env.sh

تمام متغیرهای محیط

```
ZINOVA_HOME

ZINOVA_CORE

ZINOVA_PLATFORM

ZINOVA_ZEIS

EDITOR

PYTHONPATH

...
```

---

# prompt.sh

همین تابع

```
zinova_prompt()
```

اینجا قرار می‌گیرد.

بعد

```
PROMPT_COMMAND=zinova_prompt
```

---

# backup.sh

به نظر من جذاب‌ترین قسمت.

مثلا

```
zbackup-shell
```

انجام دهد

```
tar

gzip

date

sha256

manifest
```

و خروجی

```
Shell-Backup-2026-07-08/

aliases.sh
functions.sh
prompt.sh
env.sh
bashrc
profile

SHA256SUMS

manifest.json
```

---

بعد یک دستور دیگر

```
zrestore-shell
```

همه را برگرداند.

---

# حتی بهتر

یک دستور

```
zexport
```

تمام تنظیمات توسعه را صادر کند.

مثلا

```
VSCode Settings

Git Config

SSH Config

Aliases

Prompt

Python

Cargo

Rust

Docker

Micro

Nano

Environment

Fonts

Color Theme
```

همه داخل یک آرشیو.

---

# و از همه بهتر

نسخه‌بندی کنیم.

```
Shell Config

Version 1.0.0

Build

Date

Checksum
```

اگر یک روز خراب شد فقط:

```bash
zrestore-shell
```

و کمتر از ۱۰ ثانیه بعد همه چیز برگردد.

---

## پیشنهاد آخر که ارزشش از همه بیشتر است

این را دیگر به صورت یک فایل پراکنده نمی‌بینم. برای ZINOVA یک ریپوی مستقل درست می‌کنم:

```
zinova-shell/
│
├── install.sh
├── uninstall.sh
├── update.sh
├── backup.sh
├── restore.sh
│
├── prompt/
├── aliases/
├── functions/
├── themes/
├── completion/
├── docs/
└── tests/
```

بعد روی هر ماشین جدید فقط:

```bash
git clone ...
cd zinova-shell
./install.sh
```

و در کمتر از یک دقیقه کل محیط توسعه ZINOVA، شامل پرامپت، aliasها، توابع، متغیرهای محیط و تنظیمات، دقیقاً مثل سیستم اصلی بالا می‌آید. این همان چیزی است که بعداً روی هر WSL، هر Ubuntu، هر سرور یا هر لپ‌تاپ جدید هم بدون دردسر قابل تکرار خواهد بود. این دیگر یک شل نیست، بخشی از زیرساخت مهندسی ZINOVA است.
