library(tidyverse)
library(dados)

#1 Introdução ----

"Este script estão algumas atividades e resoluções do capítulo 9 chamado visualizar do livro
R for data science. Nele é explorado de forma aprofundada a gramática dos gráficos.


O maior valor de uma imagem está em quando ela nos força a perceber o que não esperávamos ver.
- John Tukey"



#2. Mapeamento estético ----

# Entendendo sobre o conjunto de dados milhas.
dados::milhas
?milhas
view(milhas)
glimpse(milhas)
summary(milhas)


# Testando mapeamentos estéticos utilizando algumas funções.

# cor
ggplot(milhas, aes(cilindrada, y = rodovia, color = classe))+
  geom_point()

# geometria
ggplot(milhas, aes(x = cilindrada, y = rodovia, shape = classe))+
  geom_point()

# tamanho
ggplot(milhas, aes(x = cilindrada, y = rodovia, size = classe))+
  geom_point()

# transparência

ggplot(milhas, aes(x = cilindrada, y = rodovia, alpha = classe)) +
  geom_point()


# Mapeando de forma local e colorindo os dados
ggplot(milhas, aes(x = cilindrada, y = rodovia))+
  geom_point(color = "blue")


#Exercicio 9.2.1 ----
# 1 - Crie um gráfico de dispersão de rodovia vs. cilindrada no qual os pontos sejam triângulos preenchidos em cor-de-rosa (pink).
ggplot(milhas, aes(cilindrada, y = rodovia))+
  geom_point(fill = "pink", color = "pink", shape = 24)+
  labs(
    title = "                     Gráfico dispersão rodovia vs cilindrada",
    x = "Cilindrada",
    y = "Rodovia"
  )
# 2 - Por que o código abaixo não resultou em um gráfico com pontos em azul?
# O aes está sendo mapeado dentro da função geom_point, fazendo com que o R não reconheça.
ggplot(milhas) + 
  geom_point(aes(x = cilindrada, y = rodovia, color = "blue"))

# Aqui seria um exemplo do código funcionando corretamente.
ggplot(milhas, aes(x = cilindrada, y = rodovia))+
  geom_point(color = "blue")

# 3 - O que o atributo estético stroke faz? Com quais formas esse atributo estético funciona?
#O stroke altera o tamanho das observações
ggplot(milhas, aes(x = cilindrada, y = rodovia))+
  geom_point(stroke = 4)

ggplot(milhas, aes(x = cilindrada, y = rodovia))+
  geom_point(stroke = 10)

# 4 - O que acontece se você mapear um atributo estético para algo que não seja o nome 
#de uma variável, como aes(color = cilindrada < 5)?
#Observe que você também precisará definir os atributos estéticos x e y.

# Ele da cor somente as cilindradas maiores do que 5 e atribui valores booleanos.
ggplot(milhas, aes(x = cilindrada, y = rodovia, color = cilindrada < 5))+
  geom_point()













#

#3. Geometrias ----
