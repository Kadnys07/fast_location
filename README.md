# FastLocation

Aplicativo mobile para consulta de CEP e endereços, desenvolvido para a empresa FastDelivery.

## Funcionalidades

- Consulta de endereço por CEP via API pública (ViaCEP)
- Armazenamento local do histórico de consultas (Hive)
- Gerenciamento de estado reativo com MobX
- Traçar rota até o endereço consultado (Android/iOS)
- Tela de histórico de consultas realizadas

## Tecnologias

- **Flutter** — framework multiplataforma (Android e iOS)
- **Dio** — requisições HTTP
- **MobX** — gerenciamento de estado
- **Hive** — banco de dados local
- **ViaCEP** — API pública de consulta de CEP

## Como executar

### Pré-requisitos

- Flutter SDK instalado ([flutter.dev](https://flutter.dev))
- Android Studio ou dispositivo físico conectado

### Passos

```bash
# 1. Clone o repositório
git clone https://github.com/Kadnys07/fast_location.git
cd fast_location

# 2. Instale as dependências
flutter pub get

# 3. Gere os arquivos do MobX e Hive
flutter pub run build_runner build --delete-conflicting-outputs

# 4. Execute o app
flutter run
```

## Estrutura do projeto

```
lib/
├── main.dart
└── src/
    ├── http/           # Configuração do Dio
    ├── routes/         # Rotas da aplicação
    ├── shared/         # Cores, métricas e storage compartilhados
    └── modules/
        ├── initial/    # Tela de splash
        ├── home/       # Consulta de CEP
        └── history/    # Histórico de consultas
```

## API utilizada

[ViaCEP](https://viacep.com.br) — `https://viacep.com.br/ws/{cep}/json/`
