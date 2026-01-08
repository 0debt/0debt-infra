# Documentación de la comunicación asíncrona: Redis Pub/Sub

Este documento detalla la arquitectura de comunicación asíncrona implementada entre los microservicios de la plataforma 0debt, utilizando **Redis** como bus de mensajería interno.

## 1. Arquitectura de mensajería
El sistema utiliza un modelo **Event-Driven** basado en el patrón **Publish/Subscribe (Pub/Sub)** de Redis. Esta capa permite que los microservicios se comuniquen de forma no bloqueante, reaccionando a eventos generados en otros dominios.

## 2. Emisores de eventos (Publishers)

### Microservicio de gastos (Expenses Service)
Publica eventos relacionados con la actividad financiera de los grupos.
- **Canal:** `events`
- **Evento principal:** `expense.created`
- **Contenido del mensaje:** Incluye el ID del gasto, el grupo afectado (`groupId`), el monto, la moneda y el ID del pagador.

### Microservicio de grupos (Groups Service)
Publica eventos relacionados con la gestión de miembros y la estructura de los grupos.
- **Canal:** `group-events`
- **Eventos principales:** 
    - `group.member.added`: Notifica cuando un usuario se une a un grupo.
    - `group.member.removed`: Notifica la salida de un usuario.
    - `group.deleted`: Notifica la eliminación total de un grupo.

## 3. Receptores de eventos (Subscribers)

### Microservicio de notificaciones (Notifications Service)
Es el principal consumidor de eventos para la comunicación con el usuario.
- **Suscripciones:** Escucha los canales `events` y `group-events`.
- **Acciones:**
    - Ante `expense.created`: Inicia el flujo de envío de correos electrónicos a través de la integración con **Resend API**.
    - Ante `group.member.added`: Dispara notificaciones de bienvenida y correos de invitación.
    - Ante `user.deleted`: Ejecuta la limpieza de registros de notificaciones y preferencias en su base de datos local.

### Microservicio de analytics (Analytics Service)
Utiliza la mensajería para sincronizar datos de visualización.
- **Suscripciones:** Escucha el canal `events`.
- **Acciones:** Captura los datos de los nuevos gastos para procesar las estadísticas que se visualizan mediante la integración con **QuickChart API**.

## 4. Detalles de infraestructura
- **Transporte:** Redis se encarga de la distribución de mensajes en memoria de forma inmediata.
- **Formato de datos:** Todos los mensajes se intercambian en formato **JSON**, permitiendo una fácil interoperabilidad entre los diferentes servicios.
- **Aislamiento:** Cada servicio mantiene su propia persistencia en **MongoDB**, utilizando Redis exclusivamente para la sincronización de eventos en tiempo real.
