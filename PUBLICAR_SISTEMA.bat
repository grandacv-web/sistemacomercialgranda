@echo off
title GCore - Publicar Sistema Online
color 0A
echo.
echo  ============================================
echo   GCORE - PUBLICAR SISTEMA GRANDA ONLINE
echo  ============================================
echo.
echo  Este programa vai publicar o sistema online.
echo  Aguarde cada etapa terminar antes de continuar.
echo.
pause

echo.
echo  [1/4] Verificando se Node.js esta instalado...
node --version >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo.
    echo  ATENÇÃO: Node.js NAO encontrado!
    echo  Acesse https://nodejs.org e instale a versao LTS.
    echo  Depois execute este arquivo novamente.
    echo.
    pause
    start https://nodejs.org
    exit
)
echo  Node.js encontrado! OK

echo.
echo  [2/4] Instalando Firebase (pode demorar 1-2 minutos)...
call npm install -g firebase-tools --quiet
echo  Firebase instalado! OK

echo.
echo  [3/4] Fazendo login no Firebase...
echo  Uma janela do navegador vai abrir.
echo  Entre com a conta Google: grandacv@gmail.com
echo.
pause
call firebase login --reauth

echo.
echo  [4/4] Publicando o sistema online...
cd /d "%~dp0"
echo  Projetos disponiveis na sua conta:
call firebase projects:list
echo.
echo  Tentando publicar...
call firebase deploy --only hosting --project gcore-d45c5

echo.
echo  ============================================
if %ERRORLEVEL% EQU 0 (
    echo   SISTEMA PUBLICADO COM SUCESSO!
    echo   Acesse: https://gcore-d45c5.web.app
    echo   Compartilhe o link acima com a equipe Granda.
) else (
    echo   ERRO NO DEPLOY - leia a mensagem acima
)
echo  ============================================
echo.
pause
