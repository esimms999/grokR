# grokR

An R package to interface with the Grok AI API by xAI.  

Visit the [grokR website](https://esimms999.github.io/grokR/) for documentation.  


## For users:

    # Install from GitHub  

    install.packages("devtools")  
    devtools::install_github("esimms999/grokR")  
    library(grokR)  
    
    api_key <- "your API key here"  
    query_grok("What is the capital city of England?", api_key)  

  
## For developers:

    # Setup with renv to ensure you’re using the same package versions as the developer:  

    library(renv)  
    renv::restore()  
