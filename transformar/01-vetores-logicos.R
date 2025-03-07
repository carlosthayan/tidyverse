library(dados)
library(tidyverse)

# 1 - Introdução ----


# 2 - Comparações ----

x <- c(1, 2, 3, 5, 7, 11, 13)

x*2

df <- tibble(x)
df |> 
  mutate(y = x * 2)

view(df)

voos |> 
  filter(horario_saida > 600 & horario_saida < 2000 & abs(atraso_chegada) < 20)


voos |> 
  mutate(
    diurno = horario_saida > 600 & horario_saida < 2000,
    aprox_no_horario = abs(atraso_chegada) < 20,
    .keep = "used"
  )

voos |> 
  mutate(
    diurno = horario_saida > 600 & horario_saida < 2000,
    aprox_no_horario = abs(atraso_chegada) < 20,
    ) |> 
  filter(diurno & aprox_no_horario)

# Comparações pontos flutuante
# Cuidado ao usar == com números
x <- c(1 / 49 * 49, sqrt(2) ^ 2)
x

x == c(1, 2)

print(x, digits = 16)

# Outra alternativa
near(x, c(1, 2))

# NA são contagiosos
idade_maria <- NA
idade_joao <-  NA

idade_maria == idade_joao

# is.na retorna TRUE para valores faltantes e FALSE para qualquer outro valor
voos |> filter(is.na(horario_saida)) #retorna todos os valores faltantes

# Teste colocando os NA no topo utilizando dataframe.
voos |> 
  filter(mes == 1, dia == 1) |> 
  arrange(horario_saida)

voos |> 
  filter(mes ==1, dia == 1) |> 
  arrange(desc(is.na(horario_saida)), horario_saida)










 #Exercicio 12.2.4 ----