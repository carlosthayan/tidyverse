#script de testes.

dados::mtcarros
view(mtcarros)
?milhas

mtcars?

mtcarros |> 
  select(milhas_por_galao) |> 
  filter(milhas_por_galao > 20)

mtcarros |> 
  select(milhas_por_galao, cilindros, cavalos_forca)

mtcarros |> 
  select(cilindros, cavalos_forca) |> 
  filter(cilindros == 6 & cavalos_forca > 100 )

mtcarros |> 
  select(milhas_por_galao) |> 
  arrange(milhas_por_galao)

mtcarros |> 
  select(cilindros) |> 
  arrange(desc(cilindros))

mtcarros |> 
  select(cilindros, cavalos_forca) |> 
  arrange(cilindros, cavalos_forca)

mtcarros |> 
  select(cavalos_forca, peso) |> 
  mutate(power_to_weight = cavalos_forca/peso)



library(dplyr)













