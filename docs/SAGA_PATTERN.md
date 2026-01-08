# Implementación del Patrón Saga en 0debt

Este documento presenta el análisis técnico y la arquitectura de la transacción distribuida implementada para el caso de uso "Eliminar Usuario" en el sistema 0debt.

## 1. Resumen ejecutivo
El sistema implementa una variante del patrón **Saga** basada en **orquestación síncrona**. El objetivo principal es garantizar la consistencia e integridad de los datos financieros al eliminar una cuenta de usuario, coordinando operaciones entre múltiples microservicios (`users-service`, `expenses-service` y `analytics-service`).

---

## 2. Flujo de la transacción distribuida

El proceso de eliminación de usuario es una operación crítica que requiere validaciones cruzadas para evitar que usuarios con deudas pendientes abandonen el sistema, dejando estados financieros inconsistentes.

### Pasos de la Saga

| Orden | Servicio | Acción | Tipo | Propósito |
| :--- | :--- | :--- | :--- | :--- |
| **1** | `expenses-service` | `GET /internal/users/:id/debtStatus` | **Validación** | Verifica si el usuario tiene deudas o gastos pendientes. Actúa como *gatekeeper*. |
| **2** | `users-service` | `DELETE /users/:id` | **Ejecución** | Elimina el registro del usuario en la base de datos principal si la validación es correcta. |
| **3** | `analytics-service` | `DELETE /v1/internal/users/:id` | **Limpieza** | Elimina los presupuestos (*budgets*) creados por el usuario para mantener la higiene de datos. |

---

## 3. Análisis técnico del patrón

### Modelo de orquestación
El sistema utiliza un modelo de **orquestación**, donde el `users-service` actúa como el controlador central de la transacción.
*   **Decisión de diseño:** Se optó por comunicación síncrona (HTTP) en lugar de coreografía basada en eventos para este flujo específico.
*   **Justificación:** Facilita el razonamiento sobre el estado de la transacción y permite ofrecer feedback inmediato al usuario (ej. error 409 si hay deudas) sin la complejidad de gestionar consistencia eventual en la interfaz de usuario.

### Consistencia de datos
Se aplica un modelo de consistencia **Check-then-Act** (Validar-luego-Ejecutar):
*   **Integridad financiera:** La prioridad es evitar deudas huérfanas. Si el servicio de gastos (`expenses-service`) reporta deudas, la transacción se aborta antes de realizar cualquier cambio destructivo.
*   **Limpieza granular:** El servicio de analítica (`analytics-service`) elimina únicamente los registros propiedad del usuario, asegurando que no queden datos obsoletos afectando a las métricas globales.

---

## 4. Flujo end-to-end (UI -> Backend)

El siguiente esquema detalla el ciclo de vida completo de la operación, desde la interacción del usuario hasta la finalización de la Saga.

### Actores del sistema
*   **Usuario:** Actor que inicia la petición.
*   **Frontend:** Aplicación Next.js (Server Actions).
*   **Orquestador:** Microservicio de usuarios (`users-service`).
*   **Participantes:** Microservicios de gastos y analítica.

### Secuencia de ejecución

1.  **Interacción en interfaz (Frontend)**
    *   El usuario solicita la eliminación de cuenta desde su perfil.
    *   Tras confirmar en el diálogo de seguridad, se invoca la *Server Action* `deleteAccount`.

2.  **Inicio de la Saga (Orquestador)**
    *   El `users-service` recibe la petición `DELETE`.
    *   **Paso 1: Validación financiera.** El orquestador consulta síncronamente al `expenses-service`.
        *   *Escenario de fallo:* Si existen deudas, el proceso se detiene y retorna un error `409 Conflict`. El frontend notifica al usuario mediante un mensaje *toast* de error.
        *   *Escenario de éxito:* Si no hay deudas, el flujo continúa.

3.  **Ejecución y limpieza**
    *   **Paso 2: Borrado principal.** El orquestador elimina al usuario de su base de datos (MongoDB).
    *   **Paso 3: Limpieza de analítica.** El orquestador solicita al `analytics-service` la eliminación de los presupuestos asociados al usuario.

4.  **Finalización**
    *   El sistema retorna `200 OK`.
    *   El frontend cierra la sesión del usuario, redirige al login y muestra una notificación de éxito.

---
**Proyecto:** 0debt Microservices Architecture