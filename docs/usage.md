# Використання

## Запуск агента

У VS Code відкрийте **Copilot Chat**, виберіть режим **Local**, агента
`build-engineer` і виконайте `/init`.

Для окремої підсумкової перевірки в цьому самому режимі та з цим агентом
виконайте `/check`.

## Локальна перевірка

Windows:

```powershell
.\ci.bat
```

Linux/macOS:

```bash
bash ci.sh
```

## Ручний запуск проєкту

Windows:

```powershell
npm.cmd install
npm.cmd run build
npm.cmd test
npm.cmd start
```

Linux/macOS:

```bash
npm install
npm run build
npm test
npm start
```
