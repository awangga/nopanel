   81  cd ~/DO180/labs/troubleshoot-container
   82  ls
   83  sudo podman build >  -t troubleshoot-container .
   84  sudo podman build -t troubleshoot-container .
   85  sudo podman images
   86  sudo podman run --name troubleshoot-container - -p 10080:80 troubleshoot-container
   87  sudo podman run --name troubleshoot-container -p 10080:80 troubleshoot-container
   88  sudo podman run --name troubleshoot-container -d -p 10080:80 troubleshoot-container
   89  sudo podman contaainer ls
   90  sudo podman container ls
   91  sudo podman container
   92  sudo docker ps
   93  sudo podman ps
   94  sudo podman ps -a
   95  sudo podman start troubleshoot-container
   96  sudo podman ps
   97  sudo podman logs -f troubleshoot-container
   98  curl http://127.0.0.1:10080
   99  sudo podman logs troubleshoot-container
