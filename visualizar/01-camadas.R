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






#4. Facetas ----

# Criação de facetas para dividir o gráfico
ggplot(milhas, aes(x = cilindrada, y = rodovia))+
  geom_point()+
  facet_wrap(~cilindros)

ggplot(milhas, aes(x = cilindrada, y = rodovia))+
  geom_point()+
  facet_grid(tracao~cilindros)


ggplot(milhas, aes(x = cilindrada, y = rodovia)) + 
  geom_point() + 
  facet_grid(tracao ~ cilindros, scales = "free_y")


 # 
 #Exercicio 9.4.1----

# 1 - O que acontece se você criar facetas com uma variável contínua?

# Divide o gráfico em vários intervalos de 1 a 7
ggplot(milhas, aes(x = cilindrada, y = rodovia))+
  geom_point()+
  facet_wrap(~cilindrada)

# 2 - O que significam essas células vazias no gráfico acima com 
# facet_grid(tracao ~ cilindros)? Execute o código a seguir. 
# Como elas se relacionam com o gráfico que resulta desse código?

# Acontece porque nem todas as combinações podem existir, o ggplot cria espaçoes vazios para manter um padrão.
ggplot(milhas) + 
  geom_point(aes(x = tracao, y = cilindros))+
  facet_grid(tracao~cilindros)


# 3 - Quais gráficos o código a seguir cria? O que o . faz?

# Cria facetas para dianteira, traseira e 4x4  das facetas do gráfico.
ggplot(milhas)+
  geom_point(aes(x = cilindrada, y = rodovia))+
  facet_grid(tracao ~ .)

# Cria facetas para número de cilindros e mostra o gráfico na vertical
ggplot(milhas) + 
  geom_point(aes(x = cilindrada, y = rodovia)) +
  facet_grid(. ~ cilindros)

# 4 - Observe o primeiro gráfico criado por faceta abaixo:
ggplot(milhas)+
  geom_point(aes(x = cilindrada, y = rodovia))+
  facet_wrap(~classe, nrow = 2)

# 5 - Leia ?facet_wrap. O que o argumento nrow faz? O que o argumento ncol faz? 
#Quais outras opções controlam o layout dos paineis individuais? Por que a função facet_grid() não tem os argumentos nrow e ncol?

?facet_wrap
?facet_grid
#nrow define o numero de linhas e o ncol define o número de colunas.
#O layout é forçado a seguir essa estrutura, podendo gerar espaços vazios se alguns níveis das variáveis não tiverem dados.

# 6 - Qual dos gráficos abaixo facilita a comparação do tamanho do motor (cilindrada) entre carros com diferentes tipos de tração?
#O que isso diz sobre quando colocar uma variável para criar facetas nas linhas ou colunas?

# A primeira opção acaba sendo melhor visualmente do que a segunda. Sobre quando colocar uma variável, é preciso ver qual gráfico representa melhor o seu conjunto de dados.
ggplot(milhas, aes(x = cilindrada)) + 
  geom_histogram() + 
  facet_grid(tracao ~ .)

ggplot(milhas, aes(x = cilindrada)) + 
  geom_histogram() +
  facet_grid(. ~ tracao)


# 7 - Muda a posição das facetas.
ggplot(milhas) + 
geom_point(aes(x = cilindrada, y = rodovia)) +
  facet_grid(tracao ~ .)

ggplot(milhas)+
  geom_point(aes(x = cilindrada, y = rodovia))+
  facet_wrap(tracao ~ .)


 
 
 
 
 



#5. Transformações estatísticas ----

# Testando transformações
ggplot(diamante, aes(x = corte))+
  geom_bar()

diamante |> 
  count(corte) |> 
  ggplot(aes(x = corte, y = n))+
  geom_bar(stat = "identity")

View(diamante)

# Frequencia
ggplot(diamante, aes(x = corte, y = after_stat(prop), group = 1))+
  geom_bar()

# Testando o stat_summary
ggplot(diamante)+
  stat_summary(
    aes(x = corte, y = profundidade),
    fun.min = min,
    fun.max = max,
    fun = median
  )

 #Exercicio 9.5.1----

# 1 - Qual é a geometria associada ao stat_summary() por padrão?
# Como você poderia reescrever o código para gerar o gráfico anterior usando uma função geom ao invés da função stat?

# 
ggplot(diamante)+
  stat_summary(
    aes(x = corte, y = profundidade)
  )

diamantes_resumo <- 
  diamante |> 
  group_by(corte) |> 
  summarise(
    media = mean(profundidade),  # media da profundidade
    min = min(profundidade),     # profundidade mínima
    max = max(profundidade)      # profundidade máxima
  )

diamantes_resumo


ggplot(diamantes_resumo, aes(x = corte, y = media))+
  geom_pointrange(aes(ymin = min, ymax = max), size =1)+
  labs(title = "Profundidade dos diamantes por corte",
       y = "Media",
       x = "Corte")

# 2 - O que a função geom_col() faz? No que ela difere da função geom_bar()?

ggplot(diamantes_resumo, aes(x = corte, y = media))+
  geom_col()

# geom_bar não é recomendado para representar valores numericos em y, geom_bar é para gráficos de contagem e espera apenas um eixo x
ggplot(diamantes_resumo, aes(x = corte))+
  geom_bar()

# 3 - 

# 4 - 

# 5 -



#6. Ajustes de Posição ----

# Cor na borda
ggplot(milhas, aes(x = tracao, color = tracao))+
  geom_bar()

# Cor na barra inteira
ggplot(milhas, aes(x = tracao, fill = tracao))+
  geom_bar()

# Direita
ggplot(milhas, aes(x = tracao, fill = tracao)) + 
  geom_bar()


# Colorindo as bordas
ggplot(milhas, aes(x = tracao, color = tracao))+
  geom_bar()

# Cor a tudo
ggplot(milhas, aes(x = tracao, fill = tracao))+
  geom_bar()

# Ele da cor através de classes
ggplot(milhas, aes(x = tracao, fill = classe))+
  geom_bar()

# Testando outros tipos
ggplot(milhas, aes(x = tracao, fill = classe))+
  geom_bar(alpha = 1/5, position = "identity")

ggplot(milhas, aes(x = tracao, color = classe))+
  geom_bar(fill = NA, position = "identity")

ggplot(milhas, aes(x = tracao, fill = classe))+
  geom_bar(position = "fill")

# testando dodge
ggplot(milhas, aes(x = tracao, fill = classe))+
  geom_bar(position = "dodge")

# sem jitter
ggplot(milhas, aes(x = cilindrada, y = rodovia))+
  geom_point()

# com jitter, ele coloca os pontos sem sobrepor
ggplot(milhas, aes(x = cilindrada, y = rodovia))+
  geom_point(position = "jitter")

ggplot(milhas, aes(x = cilindrada, y = rodovia))+
  geom_jitter()





 
 

 #Exercicio 9.6.1----

# 1 - Qual o problema com o gráfico abaixo? Como você poderia melhorá-lo?
ggplot(milhas, aes(x = cidade, y = rodovia)) + 
  geom_point()

# 2 - Qual, caso exista, é a diferença entre os dois gráficos abaixo? Por que?
# São identicos porque o identity é padrão
ggplot(milhas, aes(x = cilindrada, y = rodovia)) +
  geom_point()

ggplot(milhas, aes(x = cilindrada, y = rodovia)) +
  geom_point(position = "identity")

# 3 - Quais parâmetros do geom_jitter() controlam a quantidade de “jittering” (ruído aleatório adicionado a cada ponto)?
#width e height controlam
ggplot(milhas, aes(x = cidade, y = rodovia))+
  geom_jitter(width = 0.3, height = 3)


# 4 - Compare e aponte as diferenças entre geom_jitter() e geom_count().
# jitter coloca todos os pontos no gráfico sem sobrescrever enquanto o geom_count conta as sobreposições do grafico
ggplot(milhas, aes(x = cidade, y = rodovia))+
  geom_point(position = "jitter")

ggplot(milhas, aes(x = cidade, y = rodovia))+
  geom_count()

# 5 -





