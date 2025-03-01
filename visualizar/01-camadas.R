library(tidyverse)
library(dados)

#1. Introdução ----

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


#3. Geometrias ----

# Analisando um mesmo gráfico com geometrias diferentes

# pontos
ggplot(milhas, aes(x = cilindrada, y = rodovia))+
  geom_point

# linha
ggplot(milhas, aes(x = cilindrada, y = rodovia))+
  geom_smooth()

# modificando o tipo da linha
ggplot(milhas, aes(x = cilindrada, y = rodovia, linetype = tracao))+
  geom_smooth()

ggplot(milhas, aes(x = cilindrada, y = rodovia, color = tracao))+
  geom_point()+
  geom_smooth(aes(linetype = tracao))

# testando o group e separando por COR
ggplot(milhas, aes(x = cilindrada, y = rodovia))+
  geom_smooth()

ggplot(milhas, aes(x = cilindrada, y = rodovia))+
  geom_smooth(aes(group = tracao))

ggplot(milhas, aes(x = cilindrada, y = rodovia))+
  geom_smooth(aes(color = tracao), show.legend = FALSE)

ggplot(milhas, aes(x = cilindrada, y = rodovia))+
  geom_point(aes(color = classe))+
  geom_smooth()

# mesma ideia especificando dados
ggplot(milhas, aes(x = cilindrada, y = rodovia))+
  geom_point()+
  geom_point(
    data = milhas |> filter(classe == "2 assentos"),
    color = "red"
  )+
  geom_point(
    data = milhas |> filter(classe == "2 assentos"),
    shape = "circle open", size = 5, color = "red"
  )

# Outras geometrias do ggplot
ggplot(milhas, aes(x = rodovia))+
  geom_histogram(binwidth = 2)

ggplot(milhas, aes(x = rodovia))+
  geom_density()

ggplot(milhas, aes(x = rodovia))+
  geom_boxplot()

# Testando pacote gridges para dados de densidade sobrepostos
library(ggridges)

ggplot(milhas, aes(x = rodovia, y = tracao, fill = tracao, color = tracao))+
  geom_density_ridges(alpha = 0.5, show.legend = FALSE)


 #Exercicio 9.3.1----

# 1 - Qual geom você usaria para construir um gráfico de linha? E um boxplot?
# e um histograma? E um gráfico de área?

ggplot(milhas, aes(x = cilindrada, y = rodovia))+
  geom_smooth()

ggplot(milhas, aes(x = cilindrada, y = rodovia, group = classe))+
  geom_boxplot()

ggplot(milhas, aes(x = cilindrada, y = rodovia))+
  geom_area(fill = "blue")

# 2 - Anteriormente nesse capítulo nós utilizamos o argumento show.legend sem explica-lo.

ggplot(milhas, aes(x = cilindrada, y = rodovia))+
  geom_smooth(aes(color = tracao), show.legend = FALSE)

# O que o o argumento "show.legend" faz nesse gráfico?
#  Ele remove a legenda que aparece no canto direito com informações sobre as linhas

# O que acontece se você remove?
ggplot(milhas, aes(x = cilindrada, y = rodovia))+
  geom_smooth(aes(color = tracao))

# Ele adiciona informaçoes sobre as linhas no canto direito do gráfico.

# Por que você acha que utilizamos anteriormente?
# Acredito que por ter poucas observações e fácil de entender o que cada linha representa
# as vezes uma informação pode se tornar obvia por representação gráfica, outro motivo seria para aprender sobre o show.legend.

# 3 - O que o argumento se da geometria geom_smooth() faz?
ggplot(milhas, aes(x = cilindrada, y = rodovia))+
  geom_smooth(se = TRUE)

# Adiciona uma faixa de confiança no gráfico.

# 4 - Recriação de gráficos.

#1
ggplot(milhas, aes(x = cilindrada, y = rodovia))+
  geom_point()+
  geom_smooth()

#2
ggplot(milhas, aes(x = cilindrada, y = rodovia, line = tracao))+
  geom_point()+
  geom_smooth()

#3
ggplot(milhas, aes(x = cilindrada, y = rodovia, color = tracao))+
  geom_point()+
  geom_smooth()

#4
ggplot(milhas, aes(x = cilindrada, y = rodovia))+
  geom_point(aes(color = tracao))+
  geom_smooth()

#5
ggplot(milhas, aes(x = cilindrada, y = rodovia, linetype = tracao))+
  geom_point(aes(color = tracao))+
  geom_smooth()

#6
ggplot(milhas, aes(x = cilindrada, y = rodovia))+
  geom_point(aes(color = tracao))










