# Rails além do MVC - Rental Cars
## Terceiro dia

Feature:
Refatorar a action create do RentalsController

### Services

Podemos aproveitar os testes que já estão feitos.
Dentro da pastas services, criamos o arquivo rental_builder.rb para a classe
RentalBuilder. Nessa classe, começamos definindo o que é necessário para
colocarmos no initialize. Neste caso, os params e subsidiary atual.
E dentro do método build, podemos montar um novo rental, usando os paramentros
recebidos pelo RentalBuilder. Assim, no controller, podemos criar um novo
RentalBuilder com os parametros necessários e chamar o método build.
Agora, na própria action create podemos verificar se o @rental pode ser salvo em
banco.


Feature:
No RentalController reescrever metodo authorize_user!

### Policies

Como essa é uma regra que parece ser crítica para o negócio, podemos criar uma
Policy. Criamos a pasta policies e dentro dela o arquivo da classe
RentalAuthorizer, que deve verificar a autorização de usuários para acessar
locações.
Dentro dessa classe podemos abusar de novos métodos, criando um método para
verificar se o usuário é admin ou se é um funcionário da mesma filial em que a
locação foi agendada. No método authorized? apenas chamamos esses métodos.


Feature:
No RentalController refatorar o método `confirm`.

### Services

Vamos criar um RentalConfirmer. Nele podemos criar os métodos que encontram a
locação, o carro e os adicionais, pelos ids recebidos no initilize.


