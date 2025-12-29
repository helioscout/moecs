This is my modest attempt at creating an ECS (Entity Component System). The speed didn't meet my expectations, so I temporarily abandoned development, but the system is complete and can be used in small games where the number of entities doesn't exceed hundred of thousands.\
\
The main idea is that memory is divided into blocks, and entities belong to three lifetimes: QUICK, DYNAMIC, and STATIC.\
\
![Design](docs/design.png)\
\
For quick lifetime block entities and components are previously stored in the buffers - arrays of size QUICK_CHUNK_SIZE that are stored on the stack and passed by reference to ECS from main program.
\
![Quick](docs/quick.png)\
\
Because static lifetime entities lives wile the world exists there are no deleting mechanism for its blocks.
\
![Static](docs/static.png)\

[![Hits](https://hits.sh/sr.ht/~modevstudio/moecs.svg)](https://hits.sh/sr.ht/~modevstudio/moecs/)
