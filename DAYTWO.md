# Rails além do MVC - Rental Cars
## Segundo dia

Feature:
No show de car_model, remover verificação de foto anexada.

obs: necessário arrumar factory de car_model.

### Decorator

Gem draper para ajudar a montar o pattern decorator/presenter
gem 'draper'. Basta instalar adicionando a gem no Gemfile e rodar bundle
install.

Mesmos processedimentos de presenter. Usar delegate_all, que sobrescreve method
missing.

O draper possui o método decorate, usado nos objetos que vc quer "decorar".
No controller sobrescrevamos o método photo, para que ele responda chamando o
super se possuir photo anexada, ou chamar outra imagem caso não tenha.

Feature: remover o split de car_options da view e jogar o código no decorator.

Sobrescrevemos o método car_options (definido pelo rails, já que car_model
possui o atributo car_option) para que ele chame o super se o não nada estiver
escrito em car_options, mas aplique o split e retorne um array com os itens
separados se houver alguma string definida.

### Partials e presenters

Na navbar temos verifiacações de quais usuários estão logados para escolher como
renderizar a barra de navegação. Em primeiro lugar, vamos separar cada navbar em
partials separadas. Em seguida, criamos um UserPresenter para criar métodos que
verificam o tipo de usuário e chamam a partial em cada caso.

O problema é que o temos que sobrescrever os métodos do devise criados para
nosso model User. Abrimos o ApplicationController onde sobrescrevemos o método
desejado. Assim, conseguimos embutir no User do devise os nossos métodos para
gerar a navbar.

Num primeiro momento, temos que adicionar um guard clause no current_user 
para verificar se existe user, já que não podemos chamar UserPresenter
sem um User.

Depois adicionamos guard clauses nos nossos métodos admin_navbar e user_navbar
para retornar uma string vazia caso a validação de usuário não passe.

Para lidar com usuário nulo, usamos o **Nil object pattern**.

### Nil Object Pattern

Criamos na pasta app/models o arquivo da classe NilUser com os métodos que
queremos que ele responda. Depois, dentro do método current_user, ao chamar o
UserPresenter, podemos chamar o super ou criar um objeto novo de NilUser.
Com o NilUser aplicado, podemos tranquilamente remover a guard clause do
current_user.

Dessa maneira, sempre temos um objeto que responde ao métodos que chamamos para
qualquer User.

Para resolver o coflito no método user_signed_in? devido ao método current_user
que foi sobrescrito, devemos implementar nosso próprio método user_signed_in?
para que verificar se temos um NilUser. Isso ocorre porque nosso current_user
sempre possui um objeto e na implementação do método pelo Devise, a presença de
um objeto é o que indica a presença de um usuário logado.
