This is my modest attempt at creating an ECS (Entity Component System). The speed didn't meet my expectations, so I temporarily abandoned development, but the system is complete and can be used in small games where the number of entities doesn't exceed hundred of thousands.\
\
The main idea is that memory is divided into blocks, and entities belong to three lifetimes: QUICK, DYNAMIC, and STATIC.\
\
![Design](docs/design.png)\
\
![Quick](docs/quick.png)\
\
![Static](docs/static.png)\
