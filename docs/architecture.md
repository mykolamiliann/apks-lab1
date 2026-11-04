# Архітектура AI-агента

## Призначення

AI-агент автоматизує підготовку кросплатформного TypeScript-проєкту Hello
World: від ініціалізації Git і створення структури до складання, тестування та
CI/CD. Він зменшує кількість ручних конфігураційних помилок, забезпечує
ідемпотентний повторний запуск і перевіряє результат на трьох операційних
системах.

## Skills

Агент використовує такі skills:

- `project-scaffold` — створення структури проєкту та базової TypeScript
  конфігурації;
- `build-and-test` — npm scripts, компіляція TypeScript і тести Vitest;
- `github-actions` — workflow CI для Ubuntu, Windows і macOS.

Skills зберігаються у `.github/skills/<назва>/SKILL.md`.

## Commands

Доступні користувачу commands:

| Command | Призначення |
|---|---|
| `git-init` | Ініціалізація Git і перевірка робочого стану |
| `create-project` | Створення структури TypeScript-проєкту Hello World |
| `create-build` | Налаштування npm scripts, складання та Vitest |
| `create-actions` | Створення GitHub Actions workflow для CI |
| `check` | Перевірка файлів, збірки та тестів |
| `init` | Оркестрація всіх етапів у визначеному порядку |

Commands зберігаються у `.github/prompts/<назва>.prompt.md` у форматі VS Code
Copilot.

## Потік даних між етапами

1. `git-init` передає наступним етапам корінь репозиторію та підтвердження
   доступного Git.
2. `create-project` передає перелік створених або вже наявних файлів,
   структуру каталогів і налаштування TypeScript.
3. `create-build` використовує `package.json` і структуру проєкту та передає
   результати складання, тестові scripts і статус тесту `BasicAddition`.
4. `create-actions` використовує npm scripts і передає шлях до workflow та
   перелік платформ matrix.
5. `check` отримує всі результати, перевіряє критерії успіху й формує звіт.

Кожен етап також дописує інформацію про виконання до `docs/ai-log.md`.

## Обробка помилок в `init`

Оркестратор `init` запускає етапи послідовно. Якщо будь-який етап завершується
помилкою, `init` зупиняється на першій помилці, не запускає наступні етапи та
показує звіт із назвою етапу, повідомленням про помилку, виконаними діями й
можливим рішенням. Подія фіксується в `docs/ai-log.md`.

## Особливості технологій

Для TypeScript замість `CMakeLists.txt` використовується `package.json` з npm
scripts, а замість CTest — Vitest. Складання генерує JavaScript-файли в
`build/`, а CI запускає однакові npm scripts на Ubuntu, Windows і macOS.

## Відповідність файлів і ролей

| Файл або каталог | Роль |
|---|---|
| `.github/agents/build-engineer.agent.md` | Manifest і правила build engineer |
| `.github/skills/<назва>/SKILL.md` | Опис і процедури доступних skills |
| `.github/prompts/<назва>.prompt.md` | Користувацькі commands у форматі VS Code Copilot |
| `package.json` | Залежності та npm scripts для TypeScript, build і Vitest |
| `tsconfig.json` | Налаштування компілятора TypeScript |
| `src/` | Вихідний код проєкту |
| `tests/` | Тести, зокрема `BasicAddition` |
| `build/` | Результат компіляції TypeScript |
| `.github/workflows/ci.yml` | Кросплатформний GitHub Actions CI |
| `.gitignore` | Виключення `build/` і `node_modules/` з Git |
| `docs/ai-log.md` | Журнал запитів, дій, помилок і рішень AI |
