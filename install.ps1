# Create RN Native - Installer
# Execute com: irm https://raw.githubusercontent.com/seu-usuario/create-rn-native/main/install.ps1 | iex

param(
    [string]$ProjectName
)

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "========================================" -ForegroundColor Blue
Write-Host "  React Native - Setup" -ForegroundColor Blue
Write-Host "========================================" -ForegroundColor Blue
Write-Host ""

# Pedir nome se não foi passado
if (-not $ProjectName) {
    $ProjectName = Read-Host "Nome do projeto"
}

if ([string]::IsNullOrWhiteSpace($ProjectName)) {
    Write-Host ""
    Write-Host "Nome vazio! Abortando..." -ForegroundColor Red
    Write-Host ""
    exit 1
}

# Verificar se já existe
if (Test-Path $ProjectName) {
    Write-Host ""
    Write-Host "Pasta '$ProjectName' ja existe!" -ForegroundColor Red
    Write-Host ""
    exit 1
}

Write-Host ""
Write-Host "Criando projeto $ProjectName..." -ForegroundColor Yellow
Write-Host "Aguarde..." -ForegroundColor Yellow
Write-Host ""

# Criar projeto
try {
    & npx "@react-native-community/cli@latest" init $ProjectName
} catch {
    Write-Host ""
    Write-Host "Erro ao criar projeto!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Verifique:" -ForegroundColor Yellow
    Write-Host "- Node.js instalado"
    Write-Host "- Conexao com internet"
    Write-Host ""
    exit 1
}

# Verificar se foi criado
if (-not (Test-Path $ProjectName)) {
    Write-Host ""
    Write-Host "Projeto nao foi criado!" -ForegroundColor Red
    Write-Host ""
    exit 1
}

Write-Host ""
Write-Host "Projeto criado!" -ForegroundColor Green
Write-Host ""

# Entrar na pasta
Set-Location $ProjectName

Write-Host "Limpando arquivos desnecessarios..."

# Remover arquivos
$filesToRemove = @(
    "__tests__",
    ".prettierrc.js",
    ".eslintrc.js",
    "App.test.tsx",
    "jest.config.js",
    "Gemfile",
    "Gemfile.lock",
    ".bundle"
)

foreach ($file in $filesToRemove) {
    if (Test-Path $file) {
        Remove-Item -Path $file -Recurse -Force -ErrorAction SilentlyContinue
    }
}

Write-Host "Arquivos removidos" -ForegroundColor Green
Write-Host ""

Write-Host "Criando pasta src/..."
if (-not (Test-Path "src")) {
    New-Item -ItemType Directory -Path "src" | Out-Null
}
Write-Host "Pasta src/ criada" -ForegroundColor Green
Write-Host ""

Write-Host "Configurando App.tsx..."

# Criar App.tsx limpo
@"
import React from 'react';
import {SafeAreaView, StyleSheet, Text, View} from 'react-native';

function App(): React.JSX.Element {
  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.content}>
        <Text style={styles.title}>Hello React Native!</Text>
      </View>
    </SafeAreaView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#ffffff',
  },
  content: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#333333',
  },
});

export default App;
"@ | Out-File -FilePath "App.tsx" -Encoding UTF8

Write-Host "App.tsx configurado" -ForegroundColor Green
Write-Host ""

Write-Host "Configurando paths @/..."

# tsconfig.json
@"
{
  "extends": "@react-native/typescript-config/tsconfig.json",
  "compilerOptions": {
    "baseUrl": ".",
    "paths": {
      "@/*": ["src/*"]
    }
  }
}
"@ | Out-File -FilePath "tsconfig.json" -Encoding UTF8

# babel.config.js
@"
module.exports = {
  presets: ['module:@react-native/babel-preset'],
  plugins: [
    [
      'module-resolver',
      {
        root: ['./src'],
        alias: {
          '@': './src',
        },
      },
    ],
  ],
};
"@ | Out-File -FilePath "babel.config.js" -Encoding UTF8

Write-Host "Paths configurados" -ForegroundColor Green
Write-Host ""

Write-Host "Instalando babel-plugin-module-resolver..."
try {
    & npm install --save-dev babel-plugin-module-resolver --loglevel=error | Out-Null
    Write-Host "Dependencia instalada" -ForegroundColor Green
} catch {
    Write-Host "Erro ao instalar (pode instalar depois)" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "PRONTO!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Projeto: $ProjectName"
Write-Host "Local: $PWD"
Write-Host ""
Write-Host "Para rodar:" -ForegroundColor Yellow
Write-Host "  cd $ProjectName"
Write-Host "  npx react-native run-android"
Write-Host ""
Write-Host "Use imports assim:" -ForegroundColor Yellow
Write-Host "  import Button from '@/components/Button';"
Write-Host ""
