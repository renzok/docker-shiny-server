# Docker: Shiny Server 

Based on
[original image](https://github.com/rocker-org/shiny/blob/master/Dockerfile)
from Rstudio's great open source
[Shiny Server](https://www.rstudio.com/products/shiny/shiny-server/).


Criticism of original:

 1. missing rm of  /var/lib/apt/lists apt-get cache and /tmp
 2. and no explicit versioning (version pinning in debian slang)
 3. runs as root by default
 
Other reasons:

1. Based on debian jessie


Be aware:

* Per default server logs are written into container file
  `/var/log/shiny-server.log`
* Shiny App logs depends on their configuration :( 

Example usage:

```
docker run -p 3838:3838 -d --name=shiny  renzok/shiny-server
```
