# Acuerdo de Nivel de Servicio (SLA) - 0debt

Este Acuerdo de Nivel de Servicio ("SLA") describe los compromisos de servicio proporcionados por **0debt** a sus clientes, con niveles de soporte y garantías diferenciados según el plan de suscripción. Este SLA es parte integral del **Acuerdo de Cliente de 0debt**.

En todos los casos, se excluyen incidencias derivadas de la infraestructura local del cliente, fallos en servicios de terceros no gestionados o eventos de fuerza mayor.

---

## 1. Definiciones

**1.1** "Tiempo de Actividad" (Uptime): Porcentaje de minutos en un mes de facturación en los que el **API Gateway** estuvo disponible para enrutar peticiones válidas.

**1.2** "Tiempo de Inactividad" (Downtime): Período en el que el Error Rate del sistema supera el 5% o existe una imposibilidad total de acceso, medido por los sistemas de monitoreo internos.

**1.3** "Incidencia": Evento que causa una interrupción o reducción de la calidad del servicio, como fallos en el cálculo de deudas o errores en la generación de gráficos.

**1.4** "Tiempo de Respuesta": Lapso desde que el Cliente notifica una incidencia hasta que el equipo de soporte de 0debt acusa recibo y comienza la mitigación.

---

## 2. Disponibilidad del Servicio (SLO)

**2.1 Garantía de tiempo de actividad por plan:**

* **Plan FREE:** No garantizado ("Best Effort").
* **Plan PRO:** **99.0%** de tiempo de actividad mensual.
* **Plan ENTERPRISE:** **99.9%** de tiempo de actividad mensual (alineado con el SLA de red de **Hetzner**).

**2.2 Exclusiones:**
El cálculo de disponibilidad excluye:
* Mantenimiento programado notificado con 48h de antelación.
* Fallos en APIs externas consumidas (**QuickChart, Resend, Frankfurter**) que activen los **Circuit Breakers** del sistema.
* Suspensión de cuenta por incumplimiento de los Términos de Uso.

---

## 3. Soporte y Tiempos de Respuesta

**3.1 Canales de soporte:**
* **Plan FREE:** Centro de ayuda y ticket por correo electrónico.
* **Plan PRO:** Correo prioritario y chat en vivo en horario comercial.
* **Plan ENTERPRISE:** Soporte 24/7 vía correo, chat y canal dedicado de comunicación directa.

**3.2 Tiempos de respuesta (Máximos):**

| Prioridad | Plan FREE | Plan PRO | Plan ENTERPRISE |
| :--- | :--- | :--- | :--- |
| **Crítica** (App caída) | 12 horas | 4 horas | 1 hora |
| **Alta** (Error en cálculos) | 1 día hábil | 8 horas | 4 horas |
| **Media** (Dudas técnicas) | 3 días hábiles | 1 día hábil | 8 horas |
| **Baja** (Sugerencias) | 5 días hábiles | 3 días hábiles | 1 día hábil |

---

## 4. Tiempo de Resolución de Incidencias

**4.1 Corrección de errores y seguridad:**
* **Fallas de Seguridad Críticas:** Resolución en menos de 12 horas para planes Enterprise y 24 horas para planes Pro.
* **Errores Funcionales:** Los tiempos de resolución variarán según la complejidad, priorizando siempre a los usuarios con planes de pago superiores.

---

## 5. Créditos por Incumplimiento de SLA

**5.1 Créditos de Servicio:**
Si 0debt no cumple con el SLO de disponibilidad, el Cliente podrá reclamar descuentos en su próxima factura:

| Uptime Mensual Alcanzado | Crédito (Plan PRO) | Crédito (Plan ENTERPRISE) |
| :--- | :--- | :--- |
| < Objetivo (99.0% / 99.9%) | 5% de la cuota | 10% de la cuota |
| < 95.0% | 15% de la cuota | 20% de la cuota |
| < 90.0% | 30% de la cuota | 50% de la cuota |

**5.2 Proceso:** Las reclamaciones deben enviarse en los 30 días posteriores al cierre del mes con la evidencia del fallo.

---

## 6. Respaldo y Recuperación de Datos

**6.1 Frecuencia de Backup:**
* **Plan FREE:** Semanal, retención de 14 días.
* **Plan PRO:** Diario, retención de 30 días.
* **Plan ENTERPRISE:** Diario, retención de 60 días.

**6.2 RTO (Objetivo de Tiempo de Recuperación):**
* **Plan PRO:** 8 horas.
* **Plan ENTERPRISE:** 4 horas.

---

## 7. Mantenimiento y Actualizaciones

**7.1** 0debt utiliza estrategias de **Rolling Update** a través de **Coolify** para asegurar que las actualizaciones no interrumpan el servicio (*Zero-Downtime*).

**7.2** Los mantenimientos de emergencia para parches de seguridad críticos se realizarán de inmediato, notificando a los usuarios afectados a la mayor brevedad posible.