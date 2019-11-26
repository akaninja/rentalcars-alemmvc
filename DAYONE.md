# Rails além do MVC - Rental Cars
## Primeiro dia

Feature:
badge de status no show de rental. Alterar cor de acordo com status.

obs: neste repositório corrigimos a factory de rental.

### Usando helpers

Criar arquivo de teste dentro da pasta helpers dentro de spec: rental_helper_spec.rb ou usar
application_helper_spec.rb.

"describe" é um alias de "context".
Escreve o teste.

Definir o método status dentro do Application Helper usando content_tag,
concatenando o status dentro a classe.

Tudo funcionando. Mas o problema é que se você precisa do objeto para o método
funcionar, talvez ele não seja bom como um helper. O helper é melhor para coisas
genéricas, que podem ser usadas em qualquer lugar. Se passarmos outro tipo de
objeto, ele quebrará.

### Presenter
O presenter é um *pattern* que se encaixa melhor nessa função.

Criar arquivo de teste rental_presenter_spec.rb
Uma prática na Campus é criar o presenter como um PORO. Então definimos um
initialize com attr_reader de @rental e, em seguida, o método status_badge. Para
podermos usar o método content_tag precisamos importar os helpers, então usamos
o método privado helper (ou h) chamando os métodos do application controller. 

Para evitar chamar os helpers toda chamada, podemos delegar content_tag para helper.

No controller, passar RentalPresenter.new(Rental.find(params[:id]). E na view,
podemos só chamar o `@rental.status_badge`.
Só que dessa forma, o presenter não possui os métodos de rental. Sendo
necessário delegar os métodos. Uma maneira de lidar com isso é modificar o
método `method_missing` de objeto.
Outra maneira é usar o SimpleDelegator, passando rental dentro de super no
initialize. Assim o presenter passa para rental todos os métodos chamados a ele
que não são encontrados na classe. Sabendo que o presenter agora responde a
todos os métodos de rental, podemos refatorar, tirando rental de `rental.status`
e o `initialize`.

============================================================================


Feature:
No show de car_model, remover verificação de foto anexada.

obs: necessário arrumar factory de car_model.
### Decorator

Gem draper para ajudar a montar o pattern decorator/presenter
gem 'draper'. Basta instalar adicionando a gem no Gemfile e rodar bundle
install.

mesmo processedimentos de presenter. Usar delegate_all, que sobrescreve method
missing.
