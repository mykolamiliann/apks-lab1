---
name: github-actions
description: "Створює кросплатформний GitHub Actions CI для TypeScript-проєкту через локальні ci.sh і ci.bat."
---

# github-actions

## Коли застосовувати

Застосовуй після налаштування локальних скриптів `ci.sh` і `ci.bat`, щоб
створити або безпечно доповнити workflow GitHub Actions.

## Вхідні дані

- корінь Git-репозиторію;
- `ci.sh` і `ci.bat`;
- npm-проєкт із робочими scripts build і test;
- наявний `.github/workflows/ci.yml`, якщо він уже існує.

## Що створює (вихід)

Створює `.github/workflows/ci.yml` із:

- тригерами `push` і `pull_request` для гілок `develop` і `master`;
- тригером `push` для `feature/**`;
- однією job з matrix `ubuntu-latest`, `windows-latest`,
  `macos-latest`;
- `fail-fast: false` у strategy, щоб результат кожної ОС був незалежним;
- кроками checkout і налаштування Node.js через `actions/setup-node` з
  LTS-версією;
- запуском тільки `bash ci.sh` на Linux/macOS і `ci.bat` на Windows через
   `shell: cmd`;
- збереженням `build/` як artifact із назвою, що містить назву ОС.

Workflow не містить секретів, токенів або дубльованих команд npm. Повторний
запуск не створює другу job чи другий workflow і не дублює кроки.

## Перевірки

1. Перевірити синтаксис і структуру `.github/workflows/ci.yml`.
2. Переконатися, що присутні всі три ОС: `ubuntu-latest`,
   `windows-latest`, `macos-latest`.
3. Переконатися, що є `push` і `pull_request` для `develop` і `master`, а
   також `push` для `feature/**`.
4. Перевірити checkout, setup-node з LTS і завантаження `build/` artifact.
5. Перевірити `fail-fast: false` та умовний запуск: Linux/macOS виконують
   `bash ci.sh`, Windows — `ci.bat` через `shell: cmd`.
6. Переконатися, що yml запускає лише `ci.sh`/`ci.bat`, без команд npm.
7. Перевірити відсутність секретів і токенів у тексті workflow.

## Що робити у випадку помилки

Не видаляти наявний workflow і не створювати дубль. Зупинити операцію,
показати файл, рядок або перевірку, що не пройшла, та виправляти лише
мінімально необхідну невідповідність після підтвердження сумісності.
Зафіксувати помилку й рішення в `docs/ai-log.md`.

## Приклад входу

```text
Workflow: .github/workflows/ci.yml
ОС: ubuntu-latest, windows-latest, macos-latest
Скрипти: ci.sh для Linux/macOS, ci.bat для Windows
Тригери: develop, master, feature/**
```

## Очікуваний результат

Один workflow запускає однакову локальну перевірку на трьох ОС, не дублює
npm-команди в yml, зберігає `build/` з OS-specific назвою та реагує на
push/pull_request у визначених гілках.

## Типовий сценарій помилки

Якщо наявний `ci.yml` уже містить потрібну job, не створювати другу.
Порівняти тригери, matrix, кроки та artifact, додати лише відсутні поля,
потім повторно перевірити, що workflow запускає виключно `ci.sh` або
`ci.bat`, і записати результат у `docs/ai-log.md`.

Якщо на `windows-latest` крок із `run: ci.bat` не має `shell: cmd`, GitHub
Actions запускає його через PowerShell, де файл поточного каталогу не
знаходиться без префікса `./`. Додати `shell: cmd` до Windows-кроку, не
замінюючи `run: ci.bat`. Також встановити `fail-fast: false` у strategy,
щоб збій однієї ОС не скасовував результати інших платформ.
