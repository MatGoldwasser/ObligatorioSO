FROM ubuntu
COPY Mostrador.sh .
RUN ["chmod", "555", "./Mostrador.sh"]
ENTRYPOINT ["./Mostrador.sh"]