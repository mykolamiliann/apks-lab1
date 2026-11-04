---
description: "Викликати skill project-scaffold для створення мінімального TypeScript Hello World-проєкту apks-lab1."
agent: build-engineer
---

# create-project

## Передумови

- Виконано `git-init` або підтверджено наявність Git і `.gitignore`.
- Проєкт має назву `apks-lab1` і мову `TypeScript`.
- Skill `project-scaffold` доступний у `.github/skills/project-scaffold/SKILL.md`.

## Дії

Викликати skill `project-scaffold` з параметрами TypeScript і `apks-lab1`.
Створювати лише відсутні каталоги та файли, доповнювати README без
перезапису, не дублювати правила конфігурації.

Не видаляти файли, не виконувати `git push`, `git push --force`,
`git reset --hard`, переписування Git, зміну захисту гілок або роботу із
секретами.

## Очікувані файли

`src/`, `tests/`, `docs/`, `src/hello.ts`, `.gitignore`, `.gitattributes` і
доповнений `README.md`. Код складання, workflow та залежності на цьому кроці
не створюються.

## Команди перевірки

```text
Test-Path src/hello.ts
Select-String -Path src/hello.ts -Pattern "Hello World"
```

## Повідомлення про помилку

Повідомити назву skill, крок і шлях, на якому сталася помилка; зупинитися,
не видаляти та не перезаписувати наявні файли, записати помилку й рішення до
`docs/ai-log.md`.
