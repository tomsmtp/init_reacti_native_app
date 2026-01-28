#!/bin/bash
# Create RN Native - Installer
# Execute com: curl -fsSL https://raw.githubusercontent.com/seu-usuario/create-rn-native/main/install.sh | bash

set -e

# Cores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo ""
echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}  React Native - Setup${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# Pegar nome do projeto
if [ -z "$1" ]; then
    read -p "Nome do projeto: " PROJECT_NAME
else
    PROJECT_NAME="$1"
fi

if [ -z "$PROJECT_NAME" ]; then
    echo ""
    echo -e "${RED}Nome vazio! Abortando...${NC}"
    echo ""
    exit 1
fi

# Verificar se já existe
if [ -d "$PROJECT_NAME" ]; then
    echo ""
    echo -e "${RED}Pasta '$PROJECT_NAME' ja existe!${NC}"
    echo ""
    exit 1
fi

echo ""
echo -e "${YELLOW}Criando projeto $PROJECT_NAME...${NC}"
echo -e "${YELLOW}Aguarde...${NC}"
echo ""

# Criar projeto
if ! npx @react-native-community/cli@latest init "$PROJECT_NAME"; then
    echo ""
    echo -e "${RED}Erro ao criar projeto!${NC}"
    echo ""
    echo -e "${YELLOW}Verifique:${NC}"
    echo "- Node.js instalado"
    echo "- Conexao com internet"
    echo ""
    exit 1
fi

# Verificar se foi criado
if [ ! -d "$PROJECT_NAME" ]; then
    echo ""
    echo -e "${RED}Projeto nao foi criado!${NC}"
    echo ""
    exit 1
fi

echo ""
echo -e "${GREEN}Projeto criado!${NC}"
echo ""

# Entrar na pasta
cd "$PROJECT_NAME"

echo "Limpando arquivos desnecessarios..."

# Remover arquivos
rm -rf __tests__ 2>/dev/null || true
rm -f .prettierrc.js 2>/dev/null || true
rm -f .eslintrc.js 2>/dev/null || true
rm -f App.test.tsx 2>/dev/null || true
rm -f jest.config.js 2>/dev/null || true
rm -f Gemfile 2>/dev/null || true
rm -f Gemfile.lock 2>/dev/null || true
rm -rf .bundle 2>/dev/null || true

echo -e "${GREEN}Arquivos removidos${NC}"
echo ""

echo "Criando pasta src/..."
mkdir -p src
echo -e "${GREEN}Pasta src/ criada${NC}"
echo ""

echo "Configurando App.tsx..."

# Criar App.tsx limpo
cat > App.tsx << 'EOF'
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
EOF

echo -e "${GREEN}App.tsx configurado${NC}"
echo ""

echo "Configurando paths @/..."

# tsconfig.json
cat > tsconfig.json << 'EOF'
{
  "extends": "@react-native/typescript-config/tsconfig.json",
  "compilerOptions": {
    "baseUrl": ".",
    "paths": {
      "@/*": ["src/*"]
    }
  }
}
EOF

# babel.config.js
cat > babel.config.js << 'EOF'
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
EOF

echo -e "${GREEN}Paths configurados${NC}"
echo ""

echo "Instalando babel-plugin-module-resolver..."
if npm install --save-dev babel-plugin-module-resolver --loglevel=error; then
    echo -e "${GREEN}Dependencia instalada${NC}"
else
    echo -e "${YELLOW}Erro ao instalar (pode instalar depois)${NC}"
fi

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}PRONTO!${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo "Projeto: $PROJECT_NAME"
echo "Local: $(pwd)"
echo ""
echo -e "${YELLOW}Para rodar:${NC}"
echo "  cd $PROJECT_NAME"
echo "  npx react-native run-android"
echo ""
echo -e "${YELLOW}Use imports assim:${NC}"
echo "  import Button from '@/components/Button';"
echo ""
