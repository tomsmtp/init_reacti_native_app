# 🚀 Como Usar o Create RN Native do GitHub

Este guia ensina como criar projetos React Native usando o script direto do GitHub, sem precisar publicar no NPM.

---

## 📋 Pré-requisitos

- ✅ Node.js instalado (versão 14+)
- ✅ Git instalado
- ✅ Conexão com internet

Para verificar:
```bash
node --version
git --version
```

---

## 🎯 Método 1: NPX direto do GitHub (MAIS RÁPIDO)

```bash
npx github:tomsmtp/init_reacti_native_app MeuApp
```

**Explicação:**
- `npx` = executa pacotes sem instalar
- `github:tomsmtp/init_reacti_native_app` = seu repositório
- `MeuApp` = nome do projeto

---

## 🎯 Método 2: Clone e Execute

### Passo 1: Clonar o repositório

```bash
git clone https://github.com/tomsmtp/init_reacti_native_app.git
cd init_reacti_native_app
```

### Passo 2: Executar o script

```bash
node index.js MeuApp
```

Ou sem nome (vai pedir):
```bash
node index.js
```

---

## 🎯 Método 3: Download do Script Raw

### Windows (PowerShell):

```powershell
# Baixar o script
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/tomsmtp/init_reacti_native_app/main/index.js" -OutFile "create-rn.js"

# Executar
node create-rn.js MeuApp
```

### Linux/Mac:

```bash
# Baixar o script
curl -o create-rn.js https://raw.githubusercontent.com/tomsmtp/init_reacti_native_app/main/index.js

# Executar
node create-rn.js MeuApp
```

---

## 🎯 Método 4: Criar Alias Global (Uso Frequente)

Se você vai usar muito, crie um alias:

### Windows (PowerShell):

```powershell
# Adicionar ao perfil do PowerShell
notepad $PROFILE

# Adicione esta linha:
function create-rn { npx github:tomsmtp/init_reacti_native_app $args }

# Salve e recarregue:
. $PROFILE

# Agora use assim:
create-rn MeuApp
```

### Linux/Mac (Bash/Zsh):

```bash
# Adicionar ao .bashrc ou .zshrc
echo 'alias create-rn="npx github:tomsmtp/init_reacti_native_app"' >> ~/.bashrc

# Recarregar
source ~/.bashrc

# Agora use assim:
create-rn MeuApp
```

---

## ✅ O Que o Script Faz

1. ✅ Cria projeto React Native CLI (sem Expo)
2. ✅ Remove arquivos desnecessários:
   - `__tests__/`
   - `.prettierrc.js`
   - `.eslintrc.js`
   - `jest.config.js`
   - `Gemfile`
3. ✅ Cria pasta `src/`
4. ✅ Configura `App.tsx` limpo e simples
5. ✅ Configura paths com `@/`:
   - `tsconfig.json` → paths
   - `babel.config.js` → alias
6. ✅ Instala `babel-plugin-module-resolver`

---

## 📁 Estrutura do Projeto Criado

```
MeuApp/
├── android/              # Projeto Android
├── ios/                  # Projeto iOS
├── src/                  ← Pasta criada para você
├── App.tsx               ← Limpo e pronto
├── babel.config.js       ← Com alias @/
├── tsconfig.json         ← Com paths @/*
└── package.json
```

---

## 💡 Usando os Paths @/

Depois de criar o projeto, você pode importar assim:

```typescript
// ❌ Antes (ruim):
import Button from '../../../src/components/Button';

// ✅ Agora (bom):
import Button from '@/components/Button';
import { api } from '@/services/api';
```

---

## 🚀 Executar o Projeto

Depois de criar:

```bash
cd MeuApp

# Android
npx react-native run-android

# iOS (Mac apenas)
cd ios && pod install && cd ..
npx react-native run-ios
```

---

## 🐛 Solução de Problemas

### Erro: "Node.js não instalado"
```bash
# Instale Node.js
https://nodejs.org/
```

### Erro: "Projeto já existe"
```bash
# Use outro nome ou remova a pasta
rm -rf MeuApp
```

### Erro: "Sem internet"
```bash
# Verifique sua conexão
ping google.com
```

### Erro: "Permissão negada"
```bash
# Linux/Mac
sudo node index.js MeuApp
```

---

## 📦 Compartilhar com Time

Compartilhe este comando com seu time:

```bash
npx github:tomsmtp/init_reacti_native_app NomeDoProjeto
```

Todos podem usar sem precisar clonar o repositório!

---

## 🔄 Atualizar para Última Versão

O `npx` sempre baixa a versão mais recente do GitHub.

Para garantir:
```bash
npx --yes github:tomsmtp/init_reacti_native_app MeuApp
```

O `--yes` força download da última versão.

---

## 📝 Links Úteis

- **Repositório:** https://github.com/tomsmtp/init_reacti_native_app
- **Issues:** https://github.com/tomsmtp/init_reacti_native_app/issues
- **React Native Docs:** https://reactnative.dev/

---

## 🤝 Contribuir

Encontrou um bug? Tem sugestões?

1. Abra uma [issue](https://github.com/tomsmtp/init_reacti_native_app/issues)
2. Ou faça um Pull Request

---

## ⭐ Gostou?

Se este script te ajudou, dê uma ⭐ no repositório!

```bash
# Estrelar pelo navegador:
https://github.com/tomsmtp/init_reacti_native_app
```

---

**Feito com ❤️ por Tom**
