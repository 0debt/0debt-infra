# Criterio de Valoración - 0debt

Este documento expone los criterios de valoración cumplidos por la aplicación 0debt, organizados según la puntuación objetivo.

---

## Para el 5

### ✅ Interacción completa entre todos los microservicios

Integración completa entre todos los microservicios de la aplicación con intercambio de información. La integración se realiza a través del backend.

📎 **Referencia:** [Diagrama de Arquitectura](https://github.com/0debt/0debt-infra/blob/main/docs/diagrams/architecture.md)

---

### ✅ Frontend común integrado

Tener un frontend común que integre los frontends de cada uno de los microservicios. Cada pareja se ocupa, al menos, de la parte específica de su microservicio en el frontend común.

📎 **Referencias:**
- [Repositorio Frontend](https://github.com/0debt/frontend)
- [Aplicación desplegada](https://www.0debt.xyz)

---

### ✅ Suscripción a planes de precios

Permitir la suscripción del usuario a un plan de precios y adaptar automáticamente la funcionalidad de la aplicación según el plan de precios seleccionado.

**Planes disponibles:** Free / Pro / Enterprise

📎 **Referencia:** [Plan de Precios](https://github.com/0debt/0debt-infra/blob/main/docs/agreements/pricing.md)

---

### ✅ Customer Agreement

Diseño de un customer agreement para la aplicación en su conjunto con, al menos, tres planes de precios que consideren características funcionales y extrafuncionales.

📎 **Referencia:** [Customer Agreement](https://github.com/0debt/0debt-infra/blob/main/docs/agreements/customer-agreement.md)

---

### ✅ Ficha técnica de APIs externas

Ficha técnica normalizada del modelo de consumo de las APIs externas utilizadas en la aplicación, incluyendo servicio externo de envío de correos electrónicos con plan de precios múltiple (SendGrid).

Cada grupo utiliza su API externa correspondiente.

📎 **Referencia:** [APIs Externas](https://github.com/0debt/0debt-infra/blob/main/docs/agreements/external-apis.md)

---

## Para el 7

### ✅ Análisis de suscripción óptima de APIs

Análisis justificativo de la suscripción óptima de las APIs del proyecto.

📎 **Referencia:** [APIs Externas - Análisis](https://github.com/0debt/0debt-infra/blob/main/docs/agreements/external-apis.md)

---

## Para el 10

### ✅ Límites de uso en planes de precios

Incluir en el plan de precios límites de uso y aplicarlos automáticamente según la suscripción del usuario.

📎 **Referencia:** [Plan de Precios](https://github.com/0debt/0debt-infra/blob/main/docs/agreements/pricing.md)

---

### ✅ API Gateway con funcionalidad avanzada

Hacer uso de un API Gateway con funcionalidad avanzada como mecanismo de throttling y autenticación.

**Implementación:** Kong API Gateway

📎 **Referencia:** [Repositorio API Gateway](https://github.com/0debt/api-gateway)

---

### ✅ Sistema de comunicación asíncrono

Hacer uso de un sistema de comunicación asíncrono mediante un sistema de cola de mensajes para los microservicios. Implementado con Redis para ciertos microservicios con justificación razonada.

📎 **Referencia:** [Comunicación Asíncrona con Redis](https://github.com/0debt/0debt-infra/blob/main/docs/comunicacion_asincrona_redis.md)

---

### ✅ Mecanismo para deshacer transacciones distribuidas

Implementación de un mecanismo para poder deshacer transacciones distribuidas mediante el patrón SAGA.

📎 **Referencia:** [Patrón SAGA](https://github.com/0debt/0debt-infra/blob/main/docs/SAGA_PATTERN.md)

---

## Resumen

| Criterio | Nota | Estado |
|----------|------|--------|
| Interacción entre microservicios | 5 | ✅ |
| Frontend común | 5 | ✅ |
| Planes de precios | 5 | ✅ |
| Customer Agreement | 5 | ✅ |
| Ficha técnica APIs externas | 5 | ✅ |
| Análisis suscripción óptima APIs | 7 | ✅ |
| Límites de uso en planes | 10 | ✅ |
| API Gateway avanzado (Kong) | 10 | ✅ |
| Comunicación asíncrona (Redis) | 10 | ✅ |
| Transacciones distribuidas (SAGA) | 10 | ✅ |
