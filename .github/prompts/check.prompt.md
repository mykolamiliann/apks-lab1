---
description: "Перевірити повноту AI-агента, структуру TypeScript-проєкту, build, Vitest, запуск і CI без змін."
agent: build-engineer
---

# check

## Передумови

- Вихідні файли проєкту вже створені.
- Доступні `npm`, `node`, `git` і YAML workflow.
- Усі перевірки виконуються лише для читання та не змінюють вихідні файли.

## Дії

Перевірити manifest агента з роллю, обмеженнями та критеріями завершення;
три skills і шість commands; `src/hello.ts`, `src/math.ts`,
`tests/math.test.ts`, `package.json`, `tsconfig.json`, `ci.sh`, `ci.bat`;
складання через `npm run build`, тест `BasicAddition` через `npm test`,
вивід `Hello World` через `node build/hello.js`; workflow із трьома ОС і
виключно `ci.sh`/`ci.bat`; відсутність `build/` і `node_modules/` у
`git ls-files`.

## Очікувані файли

Нові або змінені файли не очікуються. Результат — таблиця
`перевірка | OK/FAIL | деталі`.

## Команди перевірки

```text
npm run build
npm test
node build/hello.js
git ls-files build/ node_modules/
```

Додатково перевірити структуру customization-файлів і вміст
`.github/workflows/ci.yml`.

Не видаляти файли, не виконувати `git push`, `git push --force`,
`git reset --hard`, переписування Git, зміну захисту гілок або роботу із
секретами.

## Повідомлення про помилку

Для кожного FAIL показати перевірку, деталі та спосіб виправлення. Якщо хоча
б одна перевірка FAIL, повідомити про помилку й не вважати роботу успішною.
Не виправляти файли автоматично та записати підсумок до `docs/ai-log.md`.
