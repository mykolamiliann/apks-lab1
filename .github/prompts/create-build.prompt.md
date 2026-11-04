---
description: "Викликати skill build-and-test для налаштування TypeScript-збірки, Vitest і локальних CI-скриптів."
agent: build-engineer
---

# create-build

## Передумови

- Виконано `create-project`, існують `src/` і `tests/`.
- Skill `build-and-test` доступний у `.github/skills/build-and-test/SKILL.md`.
- Наявні конфігурації прочитані перед доповненням.

## Дії

Викликати skill `build-and-test`. Створити або доповнити без дублювання
`package.json`, `tsconfig.json`, `src/math.ts`, `tests/math.test.ts`, `ci.sh`
і `ci.bat`; встановити залежності лише відповідно до наявних lock-файлів.
Не перезаписувати сумісні налаштування.

На Windows запускати npm тільки як `npm.cmd` (`npm.cmd install`,
`npm.cmd run build`, `npm.cmd test`); на Linux/macOS використовувати `npm`.
Ніколи не змінювати політику виконання PowerShell.

Не видаляти файли, не виконувати `git push`, `git push --force`,
`git reset --hard`, переписування Git, зміну захисту гілок або роботу із
секретами.

## Очікувані файли

`package.json`, `tsconfig.json`, `src/math.ts`, `tests/math.test.ts`, `ci.sh`
і `ci.bat` із build, test, start та коректним ненульовим завершенням після
помилки кроку.

## Команди перевірки

```text
Windows: npm.cmd run build
Windows: npm.cmd test
Linux/macOS: npm run build
Linux/macOS: npm test
node build/hello.js
```

Перевірити також, що `build/` не відстежується Git.

## Повідомлення про помилку

Зупинитися на першому невдалому кроці, показати команду, код завершення та
вивід; не видаляти результати. Записати помилку й рішення до
`docs/ai-log.md`, не вважати command успішною.
