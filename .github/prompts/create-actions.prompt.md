---
description: "Викликати skill github-actions для створення кросплатформного workflow CI."
agent: build-engineer
---

# create-actions

## Передумови

- Виконано `create-build`, доступні `ci.sh` і `ci.bat`.
- Skill `github-actions` доступний у `.github/skills/github-actions/SKILL.md`.
- Наявний workflow прочитано перед змінами.

## Дії

Викликати skill `github-actions` і створити або мінімально доповнити
`.github/workflows/ci.yml`. Використати одну job з matrix для
`ubuntu-latest`, `windows-latest`, `macos-latest`, запускати тільки `bash
ci.sh` на Linux/macOS і `ci.bat` на Windows. Не дублювати job, кроки або
конфігурації та не додавати секрети.

Не видаляти файли, не виконувати `git push`, `git push --force`,
`git reset --hard`, переписування Git або зміну захисту гілок.

## Очікувані файли

`.github/workflows/ci.yml` із checkout, setup-node LTS, тригерами `push` і
`pull_request` для `develop` і `master`, push для `feature/**`, а також
artifact `build/` із назвою, що містить ОС.

## Команди перевірки

```text
Select-String -Path .github/workflows/ci.yml -Pattern "ubuntu-latest|windows-latest|macos-latest|ci.sh|ci.bat"
```

Перевірити, що yml не містить окремих команд npm.

Не видаляти файли, не виконувати `git push`, `git push --force`,
`git reset --hard`, переписування Git або зміну захисту гілок.

## Повідомлення про помилку

Показати workflow, крок і невиконану перевірку, не видаляти наявний yml і не
створювати дубль. Записати помилку й рішення до `docs/ai-log.md` та
зупинитися.
