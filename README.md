Startkit Rails Rdmapps
=====================

Este projeto deve ser utilizado como base para qualquer projeto web padrão. Ele hoje está com o ambiente Docker pré-configurado, com o rails e o ruby em versões recentes, e com diversas Gems que são necessárias em quase todos os projetos que fazemos já instaladas.

As mais importantes são:

 - Devise (autenticação)
 - Cancancan (autorização)
 - Formtastic (inputs mais poderosos para formulários)
 - Papertrail (auditoria)
 - Pgsearch (busca textual em bancos postgresql)
 - Pghero (interface web para monitorar ineficiências no banco)
 - Sidekiq (processamento de tarefas em background)
 - Sidekiq-Cron (tarefas agendadas com sidekiq)

O layout do site, junto com os formulários usando formtastic e o gerador de scaffold foram modificados utilizar um tema baseado no Material Design.

Passo a passo para começar a utilizar o projeto
--------------

1. **Pré-requisitos**

Para executar este projeto, você precisa ter o Docker Desktop e o Git instalados na sua máquina.

Como IDE de desenvolvimento, sugerimos o Visual Studio Code.

2. **Faça o download do projeto, modificando o seu nome:**

```bash
git clone git@gitlab.roadmaps.com.br:rdmapps/web/startkit-rails.git nome-do-projeto
cd nome-do-projeto
```

3. **Remova a referência ao projeto do startkit no git:**

_[passo necessário apenas para trabalhar em novos projetos]_ 

```bash
git remote rm origin
```

4. **Em seguida, crie os volumes globais no docker:**

```bash
docker volume create --name=global_gems_cache
docker volume create --name=global_node_modules_cache
```

5. **Levante o projeto e inicialize o banco:**

```bash
docker-compose build
docker-compose up web 
# Aguarde a instalação das gems ser concluída, e encerre o docker pressionando ctrl+c
docker-compose run web rake db:create db:migrate
```

6. **Levante o projeto, aguarde o rails e o yarn indicarem que terminaram de levantar o projeto, e acesse o mesmo no seu navegador em http://localhost:3000**

```bash
docker-compose up
```

7. **Se você pretende utilizar o byebug, você deve executar o docker de modo *detached*. Para isso, levante o projeto utilizando o comando abaixo:**

```bash
docker-compose up -d && docker attach web
```