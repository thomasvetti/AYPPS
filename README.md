# Gestor de Tareas Personal - proyecto AYPPS

*Objetivo alcanzado:*
Configurar el entorno de desarrollo, crear la estructura inicial del backend con NestJS, conectar exitosamente la base de datos PostgreSQL en Neon Launchpad, e implementar el módulo completo de tareas con postman.


Se instalaron y configuraron las herramientas principales:
    Node.js
    NestJS CLI
    Repositorio GitHub

        AYPPS/
        ├── server/             # Backend NestJS
        ├── mobile/             # Flutter (pendiente)
        ├── docs/               # Documentación adicional
        ├── ai-conversations/   # Registro de interacciones con IA
        └── README.md

Creación del proyecto backend (NestJS)
*Se generó el proyecto base:*
        nest new server
    Se verificó el correcto funcionamiento local:
    Nest application successfully started
    Se eliminó el .git interno para mantener un único repositorio global.
    npm run start:dev para iniciar el servidor

        Se creó una base de datos remota en Neon Launchpad
        Se obtuvo la URL de conexión y se configuró en el archivo .env:
        Se instaló e integró TypeORM en el proyecto:

Implementación del módulo tasks
    Se generaron los elementos principales con:
    nest generate module tasks
    nest generate controller tasks
    nest generate service tasks
    *estructura task*

            src/tasks/
        ├── dto/
        │   ├── create-task.dto.ts
        │   └── update-task.dto.ts
        ├── entities/
        │   └── task.entity.ts
        ├── tasks.controller.ts
        ├── tasks.service.ts
        └── tasks.module.ts

Servicio

Implementa los métodos CRUD:

create()
findAll()
findOne()
update()
remove()

Método	    Ruta	    Descripción
POST	    /tasks	    Crear una nueva tarea
GET	        /tasks	    Listar todas las tareas
GET	        /tasks/:id	Obtener una tarea específica
PATCH	    /tasks/:id	Actualizar tarea
DELETE	    /tasks/:id	Eliminar tareab 