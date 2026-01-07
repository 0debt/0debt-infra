# Planes de Precios - 0debt

La siguiente tabla muestra una comparación completa de los planes disponibles en **0debt**, incluyendo precios, límites operativos, capacidades de análisis y niveles de soporte. El sistema adapta automáticamente la funcionalidad (Self-Adaptation) basándose en el plan activo del usuario.

| **Características** | **FREE (Gratuito)** | **PRO (9.99€ / mes)** | **ENTERPRISE (29.99€ / mes)** |
|------------------------------|---------------------------------------|-------------------------------------|-----------------------------------------|
| **Precio** | 0 €                                   | 9.99 € / mes                        | 29.99 € / mes                           |
| **Usuarios** | Perfil básico                         | Cambio de foto de avatar            | Cambio de foto de avatar                |
| **Grupos** | Máx. 3 grupos activos | Ilimitados                          | Ilimitados                              |
| **Miembros por grupo** | Máx. 5 miembros                       | Máx. 50 miembros                    | Ilimitados                              |
| **Historial de Gastos** | Últimos 30 días                       | Ilimitado                           | Ilimitado                               |
| **Añadir Gastos** | 25 gastos por grupo                   | Ilimitado                           | Ilimitado                               |
| **Analytics & Gráficos** | Máx. 2 gráficos (QuickChart) | Máx. 10 gráficos (QuickChart)       | Máx. 50 gráficos (QuickChart)           |
| **Notificaciones Email** | Solo invitaciones                     | Alertas de Deuda (Resend)           | Alertas + Resúmenes (Resend)            |
| **Soporte** | Comunitario                           | Email (24h respuesta)               | Soporte Prioritario + SLA |
| **Rate Limit (API)** | 60 req/min      | 1000 req/min                        | 5000 req/min                            |

---

## Condiciones Generales de Suscripción

### 1. Ciclo de Facturación y Renovación Automática
Los planes de pago (**PRO** y **ENTERPRISE**) funcionan bajo un modelo de suscripción recurrente. El cobro se realizará automáticamente al inicio de cada ciclo de facturación mensual utilizando el método de pago vinculado a la cuenta.

### 2. Modificaciones de Precio
0debt se reserva el derecho de actualizar las tarifas de suscripción para reflejar mejoras en la infraestructura (Hetzner/Coolify) o costes de APIs externas:
- **Preaviso:** Cualquier aumento de precio será notificado al Cliente con al menos **30 días de antelación** vía correo electrónico.
- **Derecho a Cancelar:** Si el Cliente no está de acuerdo con la nueva tarifa, podrá cancelar su suscripción sin penalización antes de que se haga efectiva la renovación.

### 3. Aplicación de Límites (Throttling)
Para garantizar la estabilidad del sistema, el **API Gateway** aplica límites de tasa (*rate limits*) estrictos según el plan. Superar estos límites resultará en una denegación temporal del servicio (HTTP 429) hasta que el contador se reinicie.

---

## Política de Uso y Cancelación

### 4. Política de Uso Justo (Fair Use)
El término "Ilimitado" en los planes de pago se refiere al uso normal de gestión financiera personal o empresarial. 0debt se reserva el derecho de intervenir cuentas que utilicen el sistema de forma abusiva (ej. automatización masiva de gastos vía scripts) que comprometa la red interna de microservicios.

### 5. Cancelación y Reembolsos
- **Cancelación:** El Cliente puede cancelar su suscripción en cualquier momento desde su panel de control. El servicio permanecerá activo con todas las funciones premium hasta el final del periodo ya facturado.
- **Reembolsos:** Conforme a nuestra política operativa, no se ofrecen reembolsos por periodos parciales no utilizados, salvo por incumplimiento grave de nuestro SLA en el plan ENTERPRISE.