#!/usr/bin/env node

const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');
const readline = require('readline');

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

// Cores para terminal
const colors = {
  reset: '\x1b[0m',
  bright: '\x1b[1m',
  green: '\x1b[32m',
  red: '\x1b[31m',
  yellow: '\x1b[33m',
  blue: '\x1b[34m',
};

function log(message, color = '') {
  console.log(`${color}${message}${colors.reset}`);
}

function askProjectName() {
  return new Promise((resolve) => {
    rl.question('Nome do projeto: ', (answer) => {
      resolve(answer.trim());
    });
  });
}

async function main() {
  console.clear();
  log('\n========================================', colors.blue);
  log('  React Native - Setup', colors.blue);
  log('========================================\n', colors.blue);

  // Pegar nome do projeto (da linha de comando ou perguntar)
  let projectName = process.argv[2];

  if (!projectName) {
    projectName = await askProjectName();
  }

  if (!projectName) {
    log('\nNome vazio! Tente novamente.\n', colors.red);
    rl.close();
    process.exit(1);
  }

  // Verificar se já existe
  if (fs.existsSync(projectName)) {
    log(`\nPasta "${projectName}" ja existe!\n`, colors.red);
    rl.close();
    process.exit(1);
  }

  log(`\nCriando projeto ${projectName}...`, colors.yellow);
  log('Aguarde...\n');

  try {
    // Criar projeto React Native
    execSync(`npx @react-native-community/cli@latest init ${projectName}`, {
      stdio: 'inherit',
    });
  } catch (error) {
    log('\nNao consegui criar o projeto!\n', colors.red);
    log('Motivos possiveis:', colors.yellow);
    log('- Node.js nao instalado');
    log('- Sem internet');
    log('- Erro no comando\n');
    rl.close();
    process.exit(1);
  }

  // Verificar se foi criado
  if (!fs.existsSync(projectName)) {
    log('\nProjeto nao foi criado!\n', colors.red);
    rl.close();
    process.exit(1);
  }

  log('\nProjeto criado!', colors.green);
  
  // Entrar na pasta
  const projectPath = path.resolve(projectName);
  process.chdir(projectPath);

  log('\nLimpando arquivos desnecessarios...');

  // Remover arquivos
  const filesToRemove = [
    '__tests__',
    '.prettierrc.js',
    '.eslintrc.js', 
    'App.test.tsx',
    'jest.config.js',
    'Gemfile',
    'Gemfile.lock',
    '.bundle'
  ];

  filesToRemove.forEach(file => {
    const filePath = path.join(projectPath, file);
    if (fs.existsSync(filePath)) {
      if (fs.statSync(filePath).isDirectory()) {
        fs.rmSync(filePath, { recursive: true, force: true });
      } else {
        fs.unlinkSync(filePath);
      }
    }
  });

  log('Arquivos removidos', colors.green);

  // Criar pasta src
  log('\nCriando pasta src/...');
  const srcPath = path.join(projectPath, 'src');
  if (!fs.existsSync(srcPath)) {
    fs.mkdirSync(srcPath);
  }
  log('Pasta src/ criada', colors.green);

  // Criar App.tsx limpo
  log('\nConfigurando App.tsx...');
  const appTsx = `import React from 'react';
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
`;
  
  fs.writeFileSync(path.join(projectPath, 'App.tsx'), appTsx);
  log('App.tsx configurado', colors.green);

  // Configurar tsconfig.json
  log('\nConfigurando paths @/...');
  const tsConfig = {
    extends: '@react-native/typescript-config/tsconfig.json',
    compilerOptions: {
      baseUrl: '.',
      paths: {
        '@/*': ['src/*']
      }
    }
  };
  
  fs.writeFileSync(
    path.join(projectPath, 'tsconfig.json'),
    JSON.stringify(tsConfig, null, 2)
  );

  // Configurar babel.config.js
  const babelConfig = `module.exports = {
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
`;
  
  fs.writeFileSync(path.join(projectPath, 'babel.config.js'), babelConfig);
  log('Paths configurados', colors.green);

  // Instalar babel-plugin-module-resolver
  log('\nInstalando babel-plugin-module-resolver...');
  try {
    execSync('npm install --save-dev babel-plugin-module-resolver', {
      stdio: 'pipe',
    });
    log('Dependencia instalada', colors.green);
  } catch (error) {
    log('Erro ao instalar dependencia (pode instalar depois)', colors.yellow);
  }

  // Mensagem final
  log('\n========================================', colors.green);
  log('PRONTO!', colors.green + colors.bright);
  log('========================================\n', colors.green);
  
  log(`Projeto: ${projectName}`);
  log(`Local: ${projectPath}\n`);
  
  log('Para rodar:', colors.yellow);
  log(`  cd ${projectName}`);
  log('  npx react-native run-android\n');
  
  log('Use imports assim:', colors.yellow);
  log('  import Button from \'@/components/Button\';\n');

  rl.close();
}

main().catch(error => {
  console.error(error);
  rl.close();
  process.exit(1);
});
