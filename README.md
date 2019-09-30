# Teste iOS PAG

  

### Detalhes e requisitos:

-  Xcode 11.0

-  Swift 5

-  CocoaPods 1.7.5

  

---

### Bibliotecas utilizadas:

- `Alamofire` Requisições HTTP

- `Realm` Banco de Dados Local

- `JGProgressHUD` Indicador de loading

  

---

### Arquitetura:

O projeto foi feito em VIPER, a estrutura de arquivos é baseada em três camadas principais:

- *_Modules_*: Contém as cenas separadas por modulos. Cada cena tem seu Presenter, Interector, Router e View.

- *_Entities:_* Foi separada da camada *_Modules_* por ter modelos e casos de uso comuns em todos os Modulos.

- *_Services:_* Contém as classes de Network, APILayer, DatabaseManager...
