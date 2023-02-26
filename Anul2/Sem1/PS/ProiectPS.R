# Load the Shiny library
library(shiny)
library(ggplot2)



#generam valorile pentru paradoxul lui monty hall

montyHall <- function(nrSimulari, switch = TRUE) {
  
  castig <- 0
  
  # Loop de nr de simulari ori
  for (i in 1:nrSimulari) {
    usi <- c(1, 2, 3)
    
    #alegem random o usa in spatele careia sa fie premiul
    premiu<-sample(usi,1)
    
    #alegem o usa 
    alegere <- sample(usi,1)
    
    #deschidem o usa
    
    #daca nu am ales usa cu premiul deschidem usa ramasa
    if(premiu!=alegere)
    {
      afisez<-usi[-c(premiu,alegere)]
    }else{#altfel arat o usa random
      afisez <-sample(usi[-c(premiu)],1)
    }
    
    
    if(switch==TRUE) #daca schimb=> aleg usa care nu e afisata de gasta si e diferita de alegerea mea
    {
      alegere <-usi[-c(alegere,afisez)]
    }
    
    if (alegere==premiu)
      castig<-castig+1
  }
  
  return(list(rez=castig/nrSimulari))
  
}





# UI
ui <- fluidPage(
  selectInput("select", "Paradox: ",
              c("Paradoxul Monty Hall" = 1,
                "Paradoxul Simpson" = 2
              )
  ),
  uiOutput("plot_ui"),
  plotOutput("plot"),
  textOutput("text")
)



# functia pentru paradoxul lui Simpson



filtru = function(v_gen,df){
  filtrate <- df[df$gen == v_gen, ]
  return(filtrate)
}

functie = function(input){
  df <- data.frame(
    cure = c("Tratament vechi", "Tratament vechi", "Tratament nou", "Tratament nou"),
    gender = c("Barbati", "Femei", "Barbati", "Femei"),
    infected = c(1000, 100, 250, 800),
    cured = c(500, 80, 80, 500),
    percent_cured = c(50, 80, 32, 63),
    total_percent_cured = c(53, 0, 0, 55)
  )
  if (input$date == "Numarul de pacienti vindecati") {
    grafic <- 
      ggplot(df,aes(x = cure, y = cured, fill = gender)) +
      geom_col(width = 0.5) +
      labs(x = "Tratament", y = "Numarul de pacienti vindecati")
  } else if (input$date == "Numarul de pacienti infectati") {
    grafic <- 
      ggplot(df,aes(x = cure, y = infected, fill = gender)) +
      geom_col(width = 0.5) +
      labs(x = "Tratament", y = "Numarul de pacienti infectati")
  } else if (input$date == "Procentul barbatilor vindecati") {
    grafic <-
      ggplot(filtru("Barbati",df),aes(x = cure, y = percent_cured, fill = gender)) +
      geom_col(width = 0.5) +
      labs(x = "Tratament", y = "Procentul barbatilor vindecati")
  } else if (input$date == "Procentul femeilor vindecate") {
    grafic <-
      ggplot(filtru("Femei",df),aes(x = cure, y = percent_cured, fill = gender)) +
      geom_col(width = 0.5) +
      labs(x = "Tratament", y = "Procentul femeilor vindecate")
  }else {
    grafic <- 
      ggplot(df,aes(x = cure, y = total_percent_cured)) +
      geom_col(width = 0.5) +
      labs(x = "Tratament", y = "Numarul total de pacienti vindecati")
  }
  
  return (list(grafic=grafic))
}




# functie de generare a outpulului.
myFunction <- function(input) {
  if (input$select == 1) {
    temp1<-montyHall(input$slider)
    temp2<-montyHall(input$slider,FALSE)
    plot<-ggplot(input_data <- data.frame(
      fst_casey = c(temp1$rez),
      snd_casey = c(temp2$rez)),
      aes(x=c(0,0.10,0.20,0.40,0.80), y=c(0,0.25,0.50,0.75,1))) +
      geom_col(aes(x=c(0.2), y=fst_casey,fill=fst_casey),width =0.1)+
      geom_col(aes(x=c(0.5), y=snd_casey,fill=snd_casey ),width =0.1)+
      geom_col(aes(x=c(0.1), y=c(1)),width =0.00001)+
      geom_text(aes(label=c("cu schimbarea usii"), x=c(0.2), y=fst_casey), vjust=-0.5, hjust=0.5, color="black")+
      geom_text(aes(label=c("fara schimbarea usii"), x=c(0.5), y=snd_casey), vjust=-0.5, hjust=0.5, color="black")+
      xlab("") +
      ylab(" probabilitatea de castig") +
      guides(fill=guide_legend(title="variabile"))
  } else if (input$select==2){
    
    plot<-functie(input)
    
  } 
  return(list(plot = plot))
}

myFunction2 <- function(input) {
  if (input$select == 1) {
    text <-""
  } else if (input$select == 2) {
    text <- ""
  } 
  return(list( text = text))
}

# Server logic
server <- function(input, output) {
  
  output$plot_ui <- renderUI({
    if (input$select == 1) {
      
      sliderInput("slider", "Numar de simulari:", min = 1000, max = 5000, value = 2000)
      
    } else if( input$select ==2)
      
      sidebarPanel(
        radioButtons("date", "Particularizarea datelor:",
                     choices = c( "Numarul total de pacienti vindecati", "Numarul de pacienti infectati","Numarul de pacienti vindecati", "Procentul barbatilor vindecati", "Procentul femeilor vindecate"),
                     selected = "Numarul total de pacienti vindecati")
      )
    
    
  })
  
  
  output$plot <- renderPlot({
    myFunction(input)$plot
  })
  output$text <- renderText({
    myFunction2(input)$text
  })
}


shinyApp(ui, server)