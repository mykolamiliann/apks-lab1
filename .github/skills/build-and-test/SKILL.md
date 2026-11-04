---
name: build-and-test
description: "Налаштовує npm-збірку TypeScript, тестування Vitest і локальні кросплатформні CI-скрипти."
---

# build-and-test

## Коли застосовувати

Застосовуй після створення базової структури TypeScript-проєкту, щоб
налаштувати складання, тестову функцію, юніт-тест і локальні скрипти CI.

## Вхідні дані

- корінь Git-репозиторію;
- TypeScript-проєкт із `src/` і `tests/`;
- наявні `package.json`, `tsconfig.json`, `.gitignore` і lock-файл, якщо вони
  вже існують.

## Що створює (вихід)

- `package.json` із scripts:
  - `build`: `tsc`;
  - `test`: `vitest run`;
  - `start`: `node build/hello.js`;
- `devDependencies` з `typescript` і `vitest`;
- `tsconfig.json` з `rootDir: "src"` і `outDir: "build"`;
- `src/math.ts` з функцією `add(a, b)`;
- `tests/math.test.ts` із тестом `BasicAddition`;
- `ci.sh` для Linux/macOS;
- `ci.bat` для Windows.

`ci.sh` і `ci.bat` виконують `npm ci` або `npm install`, якщо
`package-lock.json` відсутній, потім `npm run build`, `npm test` і
`node build/hello.js`. Кожен скрипт завершується ненульовим кодом, якщо
будь-який крок не вдався. Повторний запуск не дублює scripts, залежності,
функцію, тест або конфігураційні правила.

На Windows запускати npm тільки як `npm.cmd`: `npm.cmd install`,
`npm.cmd run build`, `npm.cmd test`. На Linux/macOS використовувати `npm`.
Ніколи не змінювати політику виконання PowerShell.

## Перевірки

1. Перевірити наявність `package.json`, `tsconfig.json`, `src/math.ts`,
   `tests/math.test.ts`, `ci.sh` і `ci.bat`.
2. Перевірити точні npm scripts і devDependencies.
3. Виконати локальну збірку та перевірити створення `build/hello.js`.
4. Запустити Vitest і переконатися, що `BasicAddition` проходить.
5. Переконатися, що `build/` не перебуває під контролем Git.
6. Перевірити ненульовий код завершення після помилки будь-якого кроку
   локальних CI-скриптів.

## Що робити у випадку помилки

Зупинити послідовність на першому невдалому кроці, зберегти його вихід і
код завершення, не видаляти результати попередніх кроків. Перевірити
залежності, lock-файл, шляхи TypeScript і конфлікти наявних scripts.
Показати помилку та рішення й записати їх до `docs/ai-log.md`.

## Приклад входу

```text
Проєкт: apks-lab1
Мова: TypeScript
Потрібно: npm build, Vitest BasicAddition, ci.sh і ci.bat
```

## Очікуваний результат

Команди `npm run build`, `npm test` і `npm start` узгоджені між собою,
`build/hello.js` створюється, тест `BasicAddition` проходить, а `ci.sh` і
`ci.bat` виконують однакову послідовність перевірок на відповідній ОС.

## Типовий сценарій помилки

Якщо `package-lock.json` відсутній, локальний скрипт використовує
`npm install`, а не `npm ci`. Після завершення встановлення він продовжує
до build, test і start; якщо встановлення або будь-який наступний крок
завершився помилкою, скрипт одразу повертає ненульовий код і записує
деталі до `docs/ai-log.md`.

Якщо на Windows PowerShell блокує `npm.ps1` з помилкою
`PSSecurityException`, не змінювати політику виконання PowerShell. Повторити
команди через `npm.cmd install`, `npm.cmd run build` і `npm.cmd test`;
на Linux/macOS залишити команди `npm install`, `npm run build` і `npm test`.
