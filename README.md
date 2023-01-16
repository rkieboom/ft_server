# ft_server
ft_server is a project that focuses on the creation and deployment of a web server. The project utilizes the 42 programming curriculum and covers topics such as server administration, web infrastructure, and security. The project is done using Linux, Nginx, MariaDB, PHP and Wordpress. The goal of the project is to provide a comprehensive understanding of web servers and their role in hosting web applications, as well as gaining knowledge in server administration and security best practices.

## Usage:
Build the image with the following command
```
docker build -t ft_server .
```

And run the container with this command
```
docker run -p 80:80 -p 443:443 ft_server
```

You can now acces the website on localhost
