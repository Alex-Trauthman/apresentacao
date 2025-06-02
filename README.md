# Padronização de ambientes de homologação, produção e testes.
O projeto é feito a partir de: OLIVEIRA, Brenda Mendonça Silva. Implementação de infraestrutura como código e integração CI/CD na AWS. 2024. 21 f. Trabalho de Conclusão de Curso (Graduação em Gestão da Informação) – Universidade Federal de Uberlândia, Uberlândia, 2025. Acesso em : (https://repositorio.ufu.br/handle/123456789/44462)
O seu objetivo é iniciar um ambiente para execução de uma função lambda e armazenamento dos dados, usando terraform, github actions, python, s3 buckets, api gateway, dynamodb e awsLambda.
# Execução
Para execução o usuário deve ter aws configurada em sua máquina e git, além disso, deve criar um bucket do s3 e pode escolher entre: nomea-lo: "estados-ambientes" ou escolher outro nome e configura-lo em bucket no arquivo providers.tf, na pasta terraform também deve configura a região, escolhendo ou "us-east-1" ou mudando na pasta providers.tf . O usuário deve criar um repositório no github, entrar na parte de configurações, depois, segredos e variáveis, ações e então criar os seguintes segredos: 
NOME: AWS_ACCESS_KEY_ID 
CHAVE: Sua chave
NOME: AWS_SECRET_ACCESS_KEY
CHAVE: Sua chave
NOME: BUCKET_TF_STATE
CHAVE: Nome do seu bucket s3
Após isso, deve-se fazer um push para o repositório e as instruções presentes em terraform.yml serão executadas. Caso o usuário queira repetir a execução, pode ir até actions no repositório, entrar no workflow e executa-lo, com apply.
# Uso de Endpoints
Para usar os endpoints, o usuário deve entrar no API Gateway em seu console da AWS, ir à API gerada e clicar em POST, então teste. A partir disso, há 4 operações possíveis, que devem ser feitas passando o nome e payload:
# Create
{
  "operation": "create",
  "payload": {
    "Item": {
      "usuario": "1",
      "nome": "Joao",
      "email": "joao@example.com"
    }
  }
} 
# Read
{
  "operation": "read",
  "payload": {
    "Key": {
      "usuario": "1"
    }
  }
}
# Update 
{
  "operation": "update",
  "payload": {
    "Key": {
      "usuario": "1"
    },
    "UpdateExpression": "set nome = :nome, email = :email",
    "ExpressionAttributeValues": {
      ":nome": "João Silva",
      ":email": "joao.silva@example.com"
    }
  }
}
# Delete 
{
  "operation": "delete",
  "payload": {
    "Key": {
      "usuario": "1"
    }
  }
}

# Referência
Os arquivos de configuração foram baseados nos arquivos presentes em: 
https://github.com/brendamendon/TCC 
