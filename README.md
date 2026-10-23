# Plataforma de cursos en Ruby on Rails

Aplicación web de gestión de cursos en línea, desarrollada individualmente para el curso
**Introducción a Aplicaciones Web (ICC4103)** de la Universidad de los Andes, durante el
segundo semestre de 2024.

Este proyecto fue mi **primera experiencia con Ruby y con Ruby on Rails**. Lo dejo tal como
quedó al cierre del curso, sin cambios posteriores, como registro de ese aprendizaje.

## Qué hace

- **Usuarios y autenticación** con [Devise]: registro, inicio de sesión y roles
  (estudiante por defecto, o instructor).
- **Cursos** creados por un instructor, con sus **lecciones** (contenido enriquecido con
  Action Text).
- **Inscripciones** de estudiantes a cursos, con porcentaje de avance y estado de completitud.
- **Foros** por curso, con **comentarios** de los usuarios.
- CRUD para todos los modelos, y restricciones para que solo el instructor pueda hacer
  ciertos cambios.
- Una tarea rake (`db:model_queries`) con consultas de ActiveRecord sobre el modelo de datos
  (por ejemplo, el estudiante con más cursos inscritos o el curso con más lecciones).

## Modelo de datos

```
User(id, name, email, role)
Course(id, instructor_id → User, title, description)
Lesson(id, course_id → Course, title, content_type, content)
Enrollment(user_id → User, course_id → Course, progress_percentage, completed)
Forum(id, course_id → Course, title)
Comment(id, forum_id → Forum, user_id → User, content)
```

El diagrama relacional está en [`RelationalDiagram.drawio.pdf`](RelationalDiagram.drawio.pdf)
y la descripción en [`Data_Model.txt`](Data_Model.txt).

## Tecnologías

Ruby 3.2 · Rails 7.2 · SQLite · Devise · Action Text / Active Storage · Hotwire (Turbo y
Stimulus) · Importmap

## Cómo correrlo

La aplicación está en `Aplicacion/Tarea`.

```bash
cd Aplicacion/Tarea
bundle install
bin/rails db:setup        # crea la base de datos y carga los datos de ejemplo
bin/rails server
```

Luego abrir <http://localhost:3000>.

Para ejecutar las consultas del modelo:

```bash
bin/rails db:model_queries
```

## Limitaciones conocidas

Como fue un primer proyecto, quedaron algunas cosas sin resolver al cierre del curso:

- La eliminación de registros con dependencias (por ejemplo, borrar un curso que tiene
  lecciones o inscripciones) puede fallar.
- La consulta 5 de `db:model_queries` usa la tabla `progresses`, que se eliminó en una
  migración posterior (el avance pasó a guardarse en `Enrollment`), así que esa consulta falla.
- No hay tests propios: los archivos de `test/` son los que genera Rails.

[Devise]: https://github.com/heartcombo/devise
