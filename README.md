puppet-common
============
Um simples módulo Puppet para a instalação e configuração de alguns pacotes basicos para qualquer servidor web.

####O que ele faz?
  Instala todos os pacotes abaixo:
  * Instala os pacotes git-core, curl, vim, libcurl4-openssl-dev;
  * Reserva um espaço para swap no tamanho de 1GB;
  * Adiciona um usuário chamado "admin" para gerenciamto do sistema;
  
####Como Utilizar
  Para utilizar esse módulo basta criar o projeto Vagrant na estrutura abaixo:
  
  <pre>
    root
      |-- manifests
      |-- modules
      |-- vagranfile
  </pre>
  
  No diretório root do projeto Vagrant, utilize o comando abaixo para baixar e adicionar o módulo a sua pasta de módulos.
    
    git clone https://github.com/magnocosta/puppet-common.git modules/common
    
  Adicione a linha abaixo no seu Vagrantfile, para dizer ao Puppet que a pasta modules possui módulos de extensão para seu projetos.
    
    puppet.module_path = "modules"
    
  Feito isso basta usar o módulo nos seu arquivo de provisionamento com a linha abaixo:
  
    include common::basic
    
  E pronto, seus pacotes basicos serão instalados no proximo provisionamento.  \o/ \o/
