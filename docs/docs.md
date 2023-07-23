# Como executar run no projeto dart com b4a
Criar o DB no b4a e copiar as chaves de ApplicationId (neste exemplo vale 123) e ClientKey (neste exemplo vale 456)

Criado o arquivo .vscode/launch.json configurar deste modo:
```dart
{
  // Use IntelliSense to learn about possible attributes.
  // Hover to view descriptions of existing attributes.
  // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Dart & Flutter",
      "request": "launch",
      "type": "dart",
      "toolArgs": [
        "--define=ApplicationId=123",
        "--define=ClientKey=456"
      ]
    }
  ]
}
```
Nao esquecer de acrescentar esta pasta no .gitignore desta forma
```
# my ignore files
.vscode/
```


Na aplicacao ler as definições nomeadas de ApplicationId e ClientKey deste modo
```dart
  const keyApplicationId = String.fromEnvironment('ApplicationId');
  const keyClientKey = String.fromEnvironment('ClientKey');
```

Na aplicação apenas teclar F5 o programa vai executar e chamar as variáveis do dart define. Seguir com o resto do programa usando estas variáveis. O F5 deve ser acionado de dentro do arquivo main.dart.

Desta forma é impossível de ler estas variáveis pois ficam a nivel de compilação.

Como este projeto usa o build nao esqueca de ativar sempre com
$ 
dart run build_runner watch -d


update user_profile set nickname ='abc',phone='63992304757' where email='catalunha.mj@gmail.com';