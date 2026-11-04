@echo off
setlocal

if exist package-lock.json (
  call npm ci
) else (
  call npm install
)
if errorlevel 1 exit /b %errorlevel%
call npm run build
if errorlevel 1 exit /b %errorlevel%
call npm test
if errorlevel 1 exit /b %errorlevel%
node build\hello.js
if errorlevel 1 exit /b %errorlevel%