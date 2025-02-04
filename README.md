# WKtechnology - Projeto de Teste

## Requisitos

Para rodar o projeto completo em seu computador, será necessário:

- **Docker** (v27.5.1) e **Docker Compose** (v2.32.4)
- **Flutter** versão 3.27.3
- **Emulador Android** (ou um dispositivo físico, necessário ajustes de HOST)

## Configuração do Ambiente

Para configurar as versões corretas, utilizei o [ASDF](https://asdf-vm.com):

### Adicionando Plugins:
```bash
asdf plugin-add flutter
asdf plugin-add java
```

### Instalando Versões:
```bash
asdf install flutter 3.27.3-stable
asdf install java adoptopenjdk-17.0.14+7
```

### Verificando as Instalações:
```bash
flutter --version | grep "Flutter"
java --version | grep "openjdk"
```

## Executando o Projeto

### Backend
1. Acesse a pasta do backend e execute o docker compose:
   ```bash
   cd backend && docker compose up
   ```

### Frontend

1. Inicialize o emulador Android:
   ```bash
   flutter emulators --create --name wk-device -d wk-device
   flutter emulators --launch wk-device
   ```

2. Limpe o projeto e instale as dependências:
   ```bash
   cd frontend
   flutter clean
   flutter pub get
   flutter analyze
   ```

3. Inicie o projeto no emulador:
   ```bash
   flutter run -d emulator
   ```

## Upload de JSON

#### Disponizei alguns arquivos data.json extras no projeto, está em: /data

Para fazer o upload do primeiro JSON:

1. Certifique-se de que o arquivo JSON está salvo em sua máquina local.
2. Arraste o arquivo para o emulador.
3. No aplicativo, pressione **"Adicionar Candidatos"**.
4. Selecione o arquivo `json.data`.
5. O backend receberá o upload e o app poderá consultar os relatórios gerados.


## Observação para Dispositivos Físicos
Caso vá rodar o app Flutter em um dispositivo físico, será necessário alterar o endpoint HOST que client HTTP está apontando:

- Arquivo: `http_service.dart` na linha `11`:
  ```dart
  baseUrl: 'http://10.0.2.2:8082'
  ```

## Testes com Postman

Na pasta `/docs` há um export com os endpoints já configurados, caso deseje utilizar o Postman para testes dos endpoints.

## Banco de Dados - MySQL

Para visualizar os dados no banco de dados, utilizei o DBeaver. Segue a configuração para conexão no Docker:

- **Server Host:** localhost
- **Server Port:** 3307
- **Database:** wktechnology
- **Username:** root
- **Password:** root

Caso tenha problemas de conexão do DB com o DBeaver, verifique essas configurações na opção **"Driver Properties"**

```plaintext
- useSSL: false
- allowPublicKeyRetrieval: true
```

Mais informações: [StackOverflow - Connection between DBeaver & MySQL](https://stackoverflow.com/questions/61749304/connection-between-dbeaver-mysql)

---

O frontend foi desenvolvido utilizando Android Studio, e o backend foi desenvolvido utilizando JetBrains IDEA Community.

Qualquer dúvida ou sugestão, fique à vontade para entrar em contato: motter.edu@gmail.com

