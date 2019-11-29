# Rails além do MVC - Rental Cars
## Terceiro dia

Feature:
Vamos realizar uma consulta para agrupar todas as locações, por filial e por
categoria.

**Explicar o que são prepared statements?**

Uma possibilidade é o scope, mas neste caso ele não é ideal, porque ele não deve
ser usado para mesclar consultas entre modelos diferentes. Além disso, scopes
devem ser concatenáveis.

Aqui vamos usar os QueryObjects

### QueryObject

Criamos a pasta queries dentro de spec para montarmos os testes em
rental_by_category_and_subsidiary_spec.rb.
A query deve retornar uma estrutura como:

Filial          | Categoria  | #locações |
----------------|------------|-----------|
"Vila Mariana"  | "A"        | 3         |
"Vila Madalena" | "B"        | 2         |

Em apps criamos a pasta queries para criar o arquivo com a classe
RentalByCategoryAndSubsidiaryQuery.
Já podemos fazer o initialize com as datas de início e final, assim como o
método call. Dentro dele devemos montar a query que queremos retornar.

Podemos usar ActiveRecord::Base.connection.execute(SQL) para rodarmos qualquer
código sql na query.

### ActiveJobs

Feature: queremos cancelar locações agendadas, mas que não foram efetivadas ao
final do dia.

Para isso montamos o Job, criando a pasta jobs dentro de app, e
nele o arquivo cancel_scheduled_rentals_job.rb com a classe
CancelScheduledRentalsJob.

No arquivo Gemfile precisamos adicionar a gem delayed_job_active_record e dar o
bundle install. Logo em seguida rodar dois comandos:
* rails generate delayed_job:active_record, que vai gerar uma migration
* rails db:migrate para rodar a migração da migration criada pelo comando
  anterior

No config/application.rb, incluir a linha
    config.active_job.enqueue_adapter = :delayed_job

