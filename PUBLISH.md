# 📝 Guia de Publicação no NPM

## Pré-requisitos

1. Conta no NPM (criar em https://www.npmjs.com/)
2. Node.js instalado

## Passo a Passo

### 1. Login no NPM

```bash
npm login
# Digite seu username, password e email
```

### 2. Testar localmente (opcional)

```bash
# Na pasta do pacote
npm link

# Em outra pasta, teste
npx create-rn-native TestApp
```

### 3. Verificar se o nome está disponível

```bash
npm search create-rn-native
```

Se já existir, mude o nome no `package.json`:
- Exemplo: `@seu-username/create-rn-native`

### 4. Publicar

```bash
# Primeira vez
npm publish

# Se o nome tiver @seu-username (scoped package)
npm publish --access public
```

### 5. Testar a instalação

```bash
npx create-rn-native MeuApp
```

## Atualizações

Quando fizer mudanças:

```bash
# Atualizar versão (escolha uma)
npm version patch  # 1.0.0 -> 1.0.1
npm version minor  # 1.0.0 -> 1.1.0
npm version major  # 1.0.0 -> 2.0.0

# Publicar nova versão
npm publish
```

## Dicas

- **Nome único**: Se `create-rn-native` já existe, use `@seu-usuario/create-rn-native`
- **Versão semântica**: Siga o padrão MAJOR.MINOR.PATCH
- **README**: Mantenha atualizado para aparecer no npmjs.com
- **Keywords**: Ajudam na busca do pacote

## Estrutura de versões

- **PATCH** (1.0.x): Bug fixes
- **MINOR** (1.x.0): Novas features (compatível)
- **MAJOR** (x.0.0): Breaking changes

## Remover do NPM (cuidado!)

```bash
npm unpublish create-rn-native --force
```

⚠️ Só faça isso em até 72h após publicar!

## GitHub

Não esqueça de:

1. Criar repositório no GitHub
2. Fazer commit e push
3. Adicionar URL no `package.json`

```bash
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/seu-usuario/create-rn-native.git
git push -u origin main
```
