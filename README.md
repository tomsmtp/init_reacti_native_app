# 🚀 Create RN Native

Crie projetos React Native **sem Expo** de forma rápida e limpa.

## ✨ Features

- ✅ Setup automático do React Native CLI
- ✅ Remove arquivos desnecessários (testes, prettier, eslint, etc)
- ✅ App.tsx limpo e pronto para usar
- ✅ Pasta `src/` criada automaticamente
- ✅ Paths configurados (`@/` aponta para `src/`)
- ✅ TypeScript configurado
- ✅ Babel module resolver instalado

## 📦 Instalação Rápida

### Windows (PowerShell)

```powershell
irm https://raw.githubusercontent.com/seu-usuario/create-rn-native/main/install.ps1 | iex
```

### Linux / Mac

```bash
curl -fsSL https://raw.githubusercontent.com/seu-usuario/create-rn-native/main/install.sh | bash
```

### Com nome do projeto direto

```bash
# Linux/Mac
curl -fsSL https://raw.githubusercontent.com/seu-usuario/create-rn-native/main/install.sh | bash -s MeuApp

# Windows
irm https://raw.githubusercontent.com/seu-usuario/create-rn-native/main/install.ps1 | iex -ProjectName MeuApp
```

## 🎯 O que é criado

```
MeuApp/
├── android/
├── ios/
├── src/              ← Pasta criada para você
├── App.tsx           ← Limpo e simples
├── babel.config.js   ← Com alias @/
├── tsconfig.json     ← Com paths @/*
└── package.json
```

## 💡 Imports com @/

Depois de criar o projeto, você pode usar imports assim:

```typescript
// Ao invés de:
import Button from '../../../src/components/Button';

// Use:
import Button from '@/components/Button';
```

## 🔧 Pré-requisitos

- Node.js 14+
- npm ou yarn

## 🚀 Próximos passos

Depois de criar o projeto:

```bash
cd MeuApp

# Para Android
npx react-native run-android

# Para iOS (Mac apenas)
cd ios && pod install && cd ..
npx react-native run-ios
```

## 📱 Arquivos removidos automaticamente

- `__tests__/` - Testes
- `.prettierrc.js` - Prettier config
- `.eslintrc.js` - ESLint config
- `jest.config.js` - Jest config
- `Gemfile` - Ruby Gemfile
- `.bundle/` - Bundle cache

## 🤝 Contribuindo

Contribuições são bem-vindas! Sinta-se à vontade para abrir issues ou pull requests.

## 📄 Licença

MIT

## 🐛 Problemas?

Se encontrar algum problema, [abra uma issue](https://github.com/seu-usuario/create-rn-native/issues).

---

**Feito com ❤️ para a comunidade React Native**
